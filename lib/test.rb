require_relative 'oystercard'
require_relative 'station'
require_relative 'journey'

card = Oystercard.new
station1 = Station.new("Hampstead", 2)
station2 = Station.new("West Brompton", 3)
station3 = Station.new("Paddington", 2)
station4 = Station.new("Kings Cross", 1)

card.top_up(50)
p card

p "touch in - station1"

card.touch_in(station1)
p card.current_journey
p card.journey_history

p "----"
p "touch out - station2"

card.touch_out(station2)
p card.current_journey
p card.journey_history

# p "----"

# p "touch in - station3"

# card.touch_in(station3)
# p card.current_journey
# p card.journey_history

p "----"
p "touch out - station4"

card.touch_out(station4)
p card.current_journey
p card.journey_history
p card.journey_history.count

p "----"
