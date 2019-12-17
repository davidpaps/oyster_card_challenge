require "oystercard"

describe Oystercard do

  let(:station) { double :station }

  describe "#initialize" do
    it "has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#topup" do
    it { is_expected .to respond_to(:top_up).with(1).argument }

    it "adds 5 money to the balance" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    # it {expect{ subject.top_up 1 }.to change{ subject.balance }.by 1}
    end

    it "has a limit of 90" do
      max_cap = Oystercard::MAX_CAP
      subject.top_up(max_cap)
      expect { subject.top_up(Oystercard::MIN) }.to raise_error "Maximum limit of #{max_cap} reached"
    end
  end

  describe "#touch_in" do
    it "registers start of journey" do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "raises_error insufficient funds" do
      expect { subject.touch_in(station) }.to raise_error "insufficent funds"
    end

    it { is_expected .to respond_to(:touch_in).with(1).argument }

    it "no entry station before touch in" do
      expect(subject.entrance_station).to eq nil
    end

    it 'remembers entry station' do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
      expect(subject.entrance_station).to eq station
    end
  end

  describe "#touch_out" do
    it "registers end of journey" do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

    it "deducts fare" do
      subject.top_up(20)
      subject.touch_in(station)
      expect{subject.touch_out}.to change{ subject.balance}.by(-Oystercard::MIN_CHARGE)
    end

    it "forget entry station on touch out" do
      subject.top_up(20)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entrance_station).to eq nil
    end
  end

  describe "#in_journey?" do
    it "initially not in journey" do
      expect(subject).not_to be_in_journey
    end
  end
end
