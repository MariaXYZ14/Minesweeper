Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Number of initial not tagged mined counter
Then the not tagged mined counter should be "10"

Scenario: Tagging a cell as mined (Tagging with a Flag) //no partlem contador
Given the not tagged mines counter is "10"
When the user tags as mined the cell "(1,1)"
Then the cell "(1, 1)" should show a flag symbol
And the not tagged mines counter should be "9"

Scenario: Tagging a cell as possible mined (Tagging with a Interrogation) //no parlem contador
Given the not tagged mines counter is "10"
When the user tags as possible mined the cell "(1,1)"
Then the cell "(1, 1)" should show a interrogation symbol
And the not tagged mines counter should be "10"

Scenario: Tagging a cell as mined but truly isn't a mine
Given the user load the following board: 

"""
*---
--**
----
-*--
"""

When the user tagged a  mine in cell "(2,2)"
Then the cell "(2,3)" should show a mine not tagged correctly "X"
And the board should look like:

"""
*222
1X**
1x32
1*1-
"""

@manual
Scenario: Timer is initialized on discover a cell
Given the timer should be disabled 
When the user discover cell "(1,2)"
Then the timer should be enabled

@manual
Scenario: Timer is stopped on discover a mine
Given the timer should be enabled 
When the user discover cell "(1,3)" should show a mine
Then the timer should be disabled

@manual
Scenario: Timer change to infinity when pass ten minuts
Given the user change the initial time to "998"
When the timer pass the value "999"
Then the timer value should be "infinity"

Scenario: Initial face icon, neutral by default
Then the face icon should be a neutral face 

Scenario: State of the face icon when the user lost
Given the timer should be enabled
When the user discover cell "(1,1)" should show a mine
Then the face icon change a sad face 

Scenario: State of the face icon when the user lost
Given the timer should be enabled
When the game should be over
Then the face icon change a sad face 

Scenario: State of the face icon when the user wins
Given the timer should be enabled
When the user should win the game
Then the user icon change a happy face

@manual
Scenario: Resetting game when face icon is discovered
Given the game should be over
When user discover a face icon
Then the game is reset