require "station"

describe Station do

    subject { Station.new(station, zone) }
    let(:station) {double :station}
    let(:zone) {double :zone}

  it "stores the name" do
    expect(subject.station_name).to eq station
  end

  it "stores the zone" do
    expect(subject.zone).to eq zone
  end

end