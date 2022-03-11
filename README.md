Oyster Challenge
==================
```
___________   _______________________________________^__
 ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\
|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\
|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \
           |||                    |___|___| |  |__|         )
___________|||______________________________|______________/
           |||                                        /--------
-----------'''---------------------------------------'
 ```

Getting started
-------

* Clone this repo
* Run `bundle` in the directory of this project to install all associated gems.

## Takeaways
This challenge definitely presented some challenges, particularly some of the steps where we had to [split](https://github.com/adamwoodcock98/oyster/commit/ee099978cc4b3b6a709e3685aca175b051fe29d4) our [classes](https://github.com/adamwoodcock98/oyster/commit/31f4e1bee4d56518e42813d2d943eae7120a1fdd). This took a lot of time and involved a lot of planning, we opted to use diagrams to aid in this visually:

![diagram](https://github.com/adamwoodcock98/MakersPortfolio/blob/main/Evidence/Screenshot%202022-03-11%20at%2019.51.41.png?raw=true)

Once we had completed the diagram, things were a little more straightforward.

We did not get the last user story to calculate a variable fare, this would have been a straightforward test/implementation in the journey class. A fare would start with a minimum charge of £1, and £1 added for each zone travelled (or an additional £1 if they travel within the same zone). This would be a simple calculation done within a private method, subsequently called by the `fare` method of the `Journey` class.

For a more detailed look at my thoughts/feelings/problems, please checkout my blog posts at the bottom of [this weeks portfolio page](https://github.com/adamwoodcock98/MakersPortfolio/blob/main/Week2.md).

Testing
-------

The program contains a series of tests using Rspec (this library should be installed if the steps above were followed)

To run all tests across all class files, do the following:

```bash
cd Navigate/to/project/directory

rspec
```

To run tests for a specific class file, do the following:

```bash
cd Navigate/to/project/directory

rspec spec/oyster_card.rb
# or
rspec spec/journey.rb
# or
rspec spec/journey_log.rb
```
> Tests related to formatted currency are looking for the use of the '£', to denote GBP.



Instructions
-------

### IRB
This application will be executed using IRB

```bash
irb
```

### Creating an Oystercard

The first step will be to instantiate a card object

```bash
adamwoodcock@Adams-MacBook-Pro oyster-cards-2 % irb -r ./lib/oyster_card.rb
3.0.0 :001 > card = Oystercard.new
 => #<Oystercard:0x00007fb4e81d21b8 @balance=0, @journey_list=[], @journey_log=#<JourneyLog:0x00007fb4e81d2168 @journeys=[], @journey=nil>> 
3.0.0 :002 > 
```
> It's possible to instantiate a card object with a `JourneyLog` object containing previous journey information. A new log will be created by default.

### Topping up the card

```bash
3.0.0 :001 > card = Oystercard.new
3.0.0 :002 > card.top_up(25)
 => 25 
```

#### Balance limits
For security, a card may not contain a balance in excess of £90. There are safeguards in place to prevent this happening.

```bash
3.0.0 :001 > card = Oystercard.new
 => #<Oystercard:0x00007fb08a8fe638 @balance=0, @journey_list=[], @journey_log=#<JourneyLog:0x00007fb08a8fe5e8 @journeys=[], @journey=nil>> 
3.0.0 :002 > card.top_up(91)
Traceback (most recent call last):
        5: from /Users/adamwoodcock/.rvm/rubies/ruby-3.0.0/bin/irb:23:in `<main>'
        4: from /Users/adamwoodcock/.rvm/rubies/ruby-3.0.0/bin/irb:23:in `load'
        3: from /Users/adamwoodcock/.rvm/rubies/ruby-3.0.0/lib/ruby/gems/3.0.0/gems/irb-1.3.0/exe/irb:11:in `<top (required)>'
        2: from (irb):2:in `<main>'
        1: from /Users/adamwoodcock/Documents/Coding/Makers/Projects/oyster-cards-2/lib/oyster_card.rb:19:in `top_up'
RuntimeError (Transaction failed. Maximum limit of £90 reached)
```

#### Viewing balance

```bash
3.0.0 :001 > card = Oystercard.new
 => #<Oystercard:0x00007fc0549937b8 @balance=0, @journey_list=[], @journey_log=#<JourneyLog:0x00007fc054993768 @journeys=[], @journey=nil>> 
3.0.0 :002 > card.top_up(10)
 => nil 
3.0.0 :003 > card.balance
 => 10 
```

### Creating stations
For our Oystercard to work, we need to have some stations. We just need to pass in a name and a zone.

```bash
adamwoodcock@Adams-MacBook-Pro oyster-cards-2 % irb -r ./lib/oyster_card.rb
3.0.0 :001 > kings_cross = Station.new("Kings Cross St. Pancras", 1)
3.0.0 :002 > aldgate = Station.new("Aldgate", 1)
```

### Tapping in

To touch in, we will also need to create some stations as seen in the below. All we nee

```bash
adamwoodcock@Adams-MacBook-Pro oyster-cards-2 % irb -r ./lib/oyster_card.rb
3.0.0 :001 > kings_cross = Station.new("Kings Cross St. Pancras", 1)
 => #<Station:0x00007f8bb38b08f8 @name="Kings Cross St. Pancras", @zone=1> 
3.0.0 :002 > aldgate = Station.new("Aldgate", 1)
3.0.0 :003 > card = Oystercard.new
 => #<Oystercard:0x00007f8bb79a0048 @balance=0, @journey_list=[], @journey_log=#<JourneyLog:0x00007f8bb38cbfb8 @journeys=[], @journey=nil>> 
3.0.0 :004 > card.top_up(10)
 => nil 
3.0.0 :005 > card.touch_in(kings_cross)
 => #<Station:0x00007f8bb38b08f8 @name="Kings Cross St. Pancras", @zone=1> 
```

### Tapping out

```bash
3.0.0 :008 > card.touch_out(aldgate)
 => 9 
```
The card returns the balance, minus the £1 fare.

### Penalty fares
If a user was top not tap in, or tap out, then they would be charged a penalty fare of £6.

```bash
adamwoodcock@Adams-MacBook-Pro oyster-cards-2 % irb -r ./lib/oyster_card.rb
3.0.0 :001 > kings_cross = Station.new("Kings Cross St. Pancras", 1)
 => #<Station:0x00007f80d2a35a20 @name="Kings Cross St. Pancras", @zone=1> 
3.0.0 :002 > aldgate = Station.new("Aldgate", 1)
 => #<Station:0x00007f80d29c4ca8 @name="Aldgate", @zone=1> 
3.0.0 :003 > card = Oystercard.new
 => #<Oystercard:0x00007f80d2a85890 @balance=0, @journey_list=[], @journey_log=#<JourneyLog:0x00007f80d2a85818 @journeys=[], @journey=nil>> 
3.0.0 :004 > card.top_up(10)
 => nil 
3.0.0 :005 > card.touch_out(aldgate)
 => 4 
```

### Viewing journeys
You are able to view previous journeys stored on the card, including incomplete ones.

```bash
3.0.0 :004 > card.top_up(50)
3.0.0 :005 > 5.times {
3.0.0 :006 >   card.touch_in(kings_cross)
3.0.0 :007 >   card.touch_out(aldgate)
3.0.0 :008 > }
3.0.0 :009 > card.journey_log.journeys
 => [#<Journey:0x00007f7bd1969a98 @entry_station=#<Station:0x00007f7bd4139118 @name="Kings Cross St. Pancras", @zone=1>, @exit_station=#<Station:0x00007f7bd08ade48 @name="Aldgate", @zone=1>>, #<Journey:0x00007f7bd1969a98 @entry_station=#<Station:0x00007f7bd4139118 @name="Kings Cross St. Pancras", @zone=1>, @exit_station=#<Station:0x00007f7bd08ade48 @name="Aldgate", @zone=1>>, #<Journey:0x00007f7bd1969a98 @entry_station=#<Station:0x00007f7bd4139118 @name="Kings Cross St. Pancras", @zone=1>, @exit_station=#<Station:0x00007f7bd08ade48 @name="Aldgate", @zone=1>>, #<Journey:0x00007f7bd1969a98 @entry_station=#<Station:0x00007f7bd4139118 @name="Kings Cross St. Pancras", @zone=1>, @exit_station=#<Station:0x00007f7bd08ade48 @name="Aldgate", @zone=1>>, #<Journey:0x00007f7bd1969a98 @entry_station=#<Station:0x00007f7bd4139118 @name="Kings Cross St. Pancras", @zone=1>, @exit_station=#<Station:0x00007f7bd08ade48 @name="Aldgate", @zone=1>>]
```

## User stories

Here are the user stories you will be working on for this project:

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
