require "oystercard"

describe Oystercard do

  let(:station) { double :station }

  describe "#initialize" do
  
    it "has a balance of 0 by default" do
      expect(subject.balance).to eq(0)
    end

    it "Has an empty journey history on creation" do
      expect(subject.journey_history).to be_empty
    end
    
  end

  describe "#topup" do

    it { is_expected .to respond_to(:top_up).with(1).argument }

    it "adds 5 money to the balance" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it "has a limit of 90" do
      max_cap = Oystercard::MAX_CAP
      subject.top_up(max_cap)
      expect { subject.top_up(Oystercard::MIN) }.to raise_error "Maximum limit of #{max_cap} reached"
    end

  end

  describe "#touch_in" do
    
    it { is_expected .to respond_to(:touch_in).with(1).argument }

    it "no entry station exists before touch in" do
      expect(subject.entrance_station).to eq nil
    end

    context "journey with no money" do

      it "raises_error insufficient funds" do
        expect { subject.touch_in(station) }.to raise_error "insufficent funds"
      end

    end

  end

  describe "#touch_out" do

    it { is_expected .to respond_to(:touch_out).with(1).argument }

    let(:entry_station) { double :station}
    let(:exit_station) { double :station}

    before do
      subject.top_up(Oystercard::MIN)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end



      it "deducts fare" do
        expect{subject.touch_out(station)}.to change{ subject.balance}.by(-Oystercard::MIN_CHARGE)
      end

      it "forget entry station on touch out" do
        expect(subject.entrance_station).to eq nil
      end
    


      let(:journey_history) { {entry_station: entry_station, exit_station: exit_station} }
    
      it "stores the journey history" do
        skip
        expect(subject.journey_history).to include journey_history
      end

  end



end
