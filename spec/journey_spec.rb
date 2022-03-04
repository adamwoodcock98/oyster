require 'journey.rb'

describe Journey do

  let(:station1) { double :station1, zone: 1}
  let(:station2) { double :station2, zone: 1}


  it 'should return a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY
  end

  it 'should know if a journey is complete' do
    expect(subject.complete?).to eq false
  end

  it 'should save an entry station' do
    journey = Journey.new(station1)
    expect(journey.entry_station).to eq station1
  end

  it 'should save an exit station' do
    subject.exit_station=station2
    expect(subject.exit_station).to eq station2
  end

  # it 'should return itself when finished' do
  #   journey = Journey.new(station1)
  #   expect(journey.finish(station1)).to eq journey
  # end

  context "if only touched in" do
    # before do
    #   journey = Journey.new(station1)
    # end
    it 'should calculate a penalty fare' do
      expect(subject.fare).to eq Journey::PENALTY
    end
  end

  context 'if only touched out' do
    it 'should calculate a penalty fare' do

      expect(subject.fare).to eq Journey::PENALTY
    end
  end

  context 'if touched in and touched out' do
    it 'should calculate minimum fare' do
      subject.entry_station = station1
      subject.exit_station = station2
      expect(subject.fare).to eq Journey::FARE
    end
  end

end