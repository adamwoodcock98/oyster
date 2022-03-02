require 'oyster_card'

describe Oystercard do
  
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

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

  describe "touch_out" do
    # it 'should reduce balance by an amount' do
    #   expect(subject).to respond_to(:deduct).with(1).argument
    #   subject.top_up(5)
    #   expect{subject.deduct(5)}.to change {subject.balance}.by(-5)
    # end
    before do
      subject.top_up(1)
      subject.touch_in(:entry_station)
    end

    it "deducts fare when touched out" do
      # subject.top_up(1)
      # subject.touch_in(:entry_station)
      expect{ subject.touch_out(:exit_station) }.to change{ subject.balance }.by(-1)
    end 

    it 'forgets entry station when touched out' do
      # subject.top_up(1)
      # subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'saves exit station when touched out' do
      # subject.top_up(1)
      # subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.exit_station).to eq :exit_station
    end
  end

  describe "in_journey" do
    before do
      subject.top_up(1)
      subject.touch_in(:entry_station)
    end

    it 'should return true if touched in' do
      # subject.top_up(1)
      # subject.touch_in(:entry_station)
      expect(subject).to be_in_journey
    end
    it 'should return false if touched out' do
      # subject.top_up(1)
      # subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject).to_not be_in_journey
    end
  end

  describe 'touch_in' do
    it "raises error if insufficient balance when touching in" do
      expect{ subject.touch_in(:entry_station) }.to raise_error "Insufficient balance" 
    end 

    it 'after touched in saves the entry station' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect(subject.entry_station).to eq :entry_station
    end
  end

  describe 'list of journeys' do
    it 'should have an empty list of journeys by default' do
      expect(subject.journey_list).to be_empty
    end
    
    #let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'creates one journey after touching in and out' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      journey = {:entry_station => :entry_station, :exit_station => :exit_station}
      #expect(subject.journeys(entry_station, exit_station)).to eq journey
      expect(subject.journey_list).to include journey
    end
  end
end