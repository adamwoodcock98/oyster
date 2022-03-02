require 'journey.rb'

describe Journey do

end

it 'forgets entry station when touched out' do
  subject.touch_out(:exit_station)
  expect(subject.entry_station).to eq nil
end

it 'saves exit station when touched out' do
  subject.touch_out(:exit_station)
  expect(subject.exit_station).to eq :exit_station
end

"touch in describe"

it 'should return true if touched in' do
  expect(subject).to be_in_journey
end

it 'should return false if touched out' do
  subject.touch_out(:exit_station)
  expect(subject).to_not be_in_journey
end

it 'after touched in saves the entry station' do
  subject.top_up(1)
  subject.touch_in(:entry_station)
  expect(subject.entry_station).to eq :entry_station
end