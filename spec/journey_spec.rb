require 'journey'

describe Journey do

  let(:station) { double :station }

  it { is_expected .to respond_to(:start_journey).with(1).argument }

  it { is_expected .to respond_to(:finish_journey).with(1).argument }

  describe '#start_journey' do
    it 'will store entrance_station details' do
      expect(subject.start_journey(station)).to eq station
    end
  end

    describe '#finish_journey' do
    it 'will store exit_station details' do
      expect(subject.finish_journey(station)).to eq station
    end
  end

    describe '#complete?' do

      before do
        subject.start_journey(station)
      end

      it 'will return true if journey complete' do
        subject.finish_journey(station)
        expect(subject.complete?).to eq true
      end

      it "will return false if journey not completed" do
        expect(subject.complete?).to eq false
      end
    end

      # it "registers start of journey" do
      #   expect(subject).to be_in_journey
      # end

      # it "registers end of journey" do
      #   expect(subject).to_not be_in_journey
      # end

    #   describe "#in_journey?" do

    #   it "initially not in journey" do
    #     expect(subject).not_to be_in_journey
    #   end
  
    # end



end