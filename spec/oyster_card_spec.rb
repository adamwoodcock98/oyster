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
        expect(subject.current_journey).to_not be_nil
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

    # once touched out - complete journey (has a minimum fare), receives a journey back

    # if they don't touch in first

    # it "deducts fare when touched out" do
    #   expect{ subject.touch_out(:exit_station) }.to change{ subject.balance }.by(-1)
    # end 

  end

  describe 'list of journeys' do
    it 'should have an empty list of journeys by default' do
      expect(subject.journey_list).to be_empty
    end

    # save a journey, journey list includes journey.

    

    # it 'should save a journey' do
    #   subject.top_up(1)
    #   subject.touch_in(:entry_station)
    #   subject.touch_out(:exit_station)
    #   journey = {:entry_station => :entry_station, :exit_station => :exit_station}
    #   #expect(subject.journeys(entry_station, exit_station)).to eq journey
    #   expect(subject.journey_list).to include journey #logic to change, end result to stay the same
    # end
  end
end


# edge case: to deduct penalty for not touching out, this would need testing when they touch in twice in a row, once hits +24 hours