require '/Users/Paul/Makers/Projects/oystercard/lib/oystercard'
require '/Users/Paul/Makers/Projects/oystercard/lib/journey'

card = Oystercard.new

card.top_up(30)
p "Topped up 30"

card.touch_in("West Hampstead")
card.touch_out("Kings Cross")

p "charged 1"
p card

card.touch_in("Kings Cross")
card.touch_out("West Hampstead")

p "charged 1"
p card

card.touch_out("Old Street")

p "charged 6"
p card

card.touch_in("Liverpool Street")

p "should not be charged"
p card

card.touch_in("West Hampstead")

p "charged 6"
p card

card.touch_in("West Hampstead")
card.touch_out("Kings Cross")

p "charged 7"
p card
