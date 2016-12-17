# ece287
Repository for my work during ECE287


test.v is the verilog file for the final project by Brandt Groene and Haley Olson.


Youtube Video:  https://youtu.be/Q4WGpJwHwzg


Description of design:

A major part of this project was creating an original game.


How was the story created?
The idea for growing corn was one based on my (Brandt) family’s iowa heritage. Corn stalks are easy to model, as they are thin and tall, and their fruit of corn is a very recognizable color. This means that there is a goal (grow corn), graphics (corn stalk in a field) and a conflict (nature can make plant growing difficult). We had the opportunity for a story here, and faced a technical difficulty with communicating this story through the vga. Thus, we decided to use notecards as the way to deliver the story, with the VGA being the illustration of the corn stalk. The apps on a phone that send notifications can be used to add character to what could otherwise be a somewhat dull set of instructions, and also contribute a mechanic of the game that makes it significantly more fun, which is decoding the warnings and hints from the phone and using that knowledge to plan the next day of actions. 

How was game length managed?
We experimented with game lengths ranging from five days to 18 days, each with a morning and afternoon action. It seemed like on the smaller end of days, usually less than eight, it was too hard with the way our mechanics worked to catch up if you made a mistake in the beginning. As length of days started increasing above ten or twelve, the game became somewhat monotonous and the plant growth had to be very slow and not as visibly rewarding per turn. Also, it showed the weakness of the low number of weather effects, as several patterns would repeat, a problem when each day is trying to be part of an interesting story.



How was the graphical art developed?
As we didn’t have any sort of example to go off of, all the “artwork” had to be designed to be understandable. The stalk would be green, but turn brownish red when the plant is in distress and not growing. This is an obvious “green = good, red = bad” trope found in most games. For the graphics of the effects, some of the limitations of the vga module had to be taken into account and the corn stalk and weather effects could only be represented in colored blocks. A looming gray sky overhead during days of rain represented rain. A bite appearing in the side of the plant representing deer in the area. The challenge of making relevant onscreen feedback using just colored boxes, and finicky ones at that, was one of the main design challenges of the game in both a technical and artistic way. 



How does the player advance?
The advancement is a simple comparison between the effect of the day, and how well you choose what action to take based off of the alerts on your “phone” the day before. If the action and scenario are the same value, then the needed value and correct value increase by one. When needed and correct are the same, the plant grows every half-day. If the action and scenario are different values, the player is wrong and the plant turns distressed. The way to get the plant back to being healthy was a mechanic where when the plant is in distress, correct moves give a +2 to the correct column, enabling the player to get the plant healthy again and keep it growing.
What is the winning condition?
The winning condition is the growth of the plant to a height value of +700 before the end of the 9th day. Upon this height target, a piece of corn appears in the plant. You can still let the plant grow until the 9th day to see how tall you can get the plant, but the victory condition is the appearance of the corn. If a perfect game is played, victory can happen on the 7th day. This leaves a cushion of about two or three errors to be still able to reach victory before the end.




Our design has 18 states, one for the morning and afternoon of each day. The 9 days are indicated by LEDR17-LEDR9. The time of day (morning and afternoon) is displayed by switching back and forth between LEDG1 and LEDG0, (LEDG1 for morning and LEDG0 for afternoon). The time of day and each day can be advanced by pressing KEY1. For example, the game will start on day 1 in the morning. One press of KEY1 will switch the state to afternoon on day 1. Another press of KEY1 will switch it to day 2 in the morning, and so on. As this key is pressed, the corn on the VGA will grow. This is implemented in our code as a finite state machine along with the variables and correct actions. These actions are implemented by the player by flipping switches SW17-SW15 on the FPGA. The switches are as follows:
Do nothing = 000  //used for days of rain
Water the plants = 001 //used for sunny days
Go hunting = 010 //used for days of deer
Heat the plant = 100 // used for days of frost.



The VGA module was the one that Parth had edited to work on these displays.

