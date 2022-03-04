require 'journey_log'

describe JourneyLog do

  let(:station) { double :station }
  let(:journey_double) { double :journey_double, :exit_station => station }

  it 'should contain an empty journey list' do
    expect(subject.journeys).to eq []
  end

  it '#start should return a journey object and add an entry_station' do
    subject.start(station)
    expect(subject.journey.entry_station).to eq station
  end

  it '#finish should return a journey object and add an exit_station' do
    subject.finish(station)
    expect(subject.journey.exit_station).to eq station
  end

  it 'should save a journey when finished' do
    subject.finish(station)
    expect(subject.journeys).to_not be_empty
  end

end