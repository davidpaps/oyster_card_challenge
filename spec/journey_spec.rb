require 'journey'

describe Journey do

  let(:station) { double :station }
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }


  it { is_expected .to respond_to(:start_journey).with(1).argument }

  it { is_expected .to respond_to(:finish_journey).with(1).argument }

  describe '#start_journey' do
    it 'will store entrance_station details' do
      expect(subject.start_journey(station)).to eq station
    end

    it 'will reset_card if previous journey was not completed' do
      subject.start_journey(station)
      subject.start_journey(station)
      expect(subject.journey[:exit_station]).to eq nil
    end

  end

    describe '#finish_journey' do
    it 'will store exit_station details' do
      expect(subject.finish_journey(station)).to eq station
    end

    it 'will reset_card if previous journey was completed' do
      subject.finish_journey(station)
      subject.finish_journey(station)
      expect(subject.journey[:entry_station]).to eq nil
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

    describe '#reset_card' do
      it 'will set journey entry station value to nil' do
        subject.start_journey(station)
        subject.reset_card
        expect(subject.journey[:entry_station]).to eq nil
      end

      it 'will set journey exit station value to nil' do
        subject.finish_journey(station)
        subject.reset_card
        expect(subject.journey[:exit_station]).to eq nil
      end

    end





end