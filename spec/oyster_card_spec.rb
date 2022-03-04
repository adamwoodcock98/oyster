require 'oyster_card'

describe Oystercard do
  
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  let(:station1) { double :station1, zone: 1}
  let(:station2) { double :station2, zone: 1}

  describe "balance" do
    it "respond to balance" do
      expect(subject).to respond_to(:balance)
    end 
  end

  describe "top_up" do
    it 'should top up balance' do
      expect(subject).to respond_to(:top_up).with(1).argument
      expect{subject.top_up(5)}.to change {subject.balance}.by(5)
    end
    it "raises error if top up exceeds limit" do
      subject.top_up(90)
      expect{ subject.top_up(1) }.to raise_error "Your balance is now £90. Maximum limit of £90 reached" 
    end 
  end

  describe 'touch_in' do

      it "raises error if insufficient balance when touching in" do
        expect{ subject.touch_in(:entry_station) }.to raise_error "Insufficient balance" 
      end

      it 'should check if current_journey is not empty' do
        subject.top_up(10)
        subject.touch_in(station1)
        expect(subject.journey_log.journey).to_not be_nil
      end

      it 'should return a penalty when touching in twice in a row' do
        subject.top_up(10)
        subject.touch_in(station1)
        expect { subject.touch_in(station2) }.to change { subject.balance }.by(-Journey::PENALTY)
      end

    end

  describe "touch_out" do
    before do
      subject.top_up(10)
    end

    it 'should return penalty if only touched out' do
      expect { subject.touch_out(station1) }.to change { subject.balance }.by(-Journey::PENALTY)
    end

    it 'should return fare if journey completed' do
      subject.touch_in(station1)
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-Journey::FARE)
    end

  end

  describe 'list of journeys' do
    let(:journey) {double :journey}
    it 'oyster card should have an empty journey log by default' do
      expect(subject.journey_log.journeys).to be_empty
    end

    # it 'should save a journey into journey list' do
    #   subject.top_up(10)
    #   subject.touch_in(station1)
    #   subject.touch_out(station2)
    #   expect(subject.journey_log.journeys).to_not be_empty
    # end
  end
end
