Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Number of initial not tagged mined counter
Then the not tagged mined counter should be "10"

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
Scenario: Timer is initialized on tag a cell as mined 
Given the timer should be disabled 
When the user tags as mined the cell "(1,2)"
Then the timer should be enabled

@manual
Scenario: Timer is stopped on discover a mine
Given the timer should be enabled 
When the user discover cell "(1,3)" should show a mine
Then the timer should be disabled

@manual
Scenario: After 999 seconds, timer should be infinity  
Given the user change the initial time to "998"
When the timer pass the value "999"
Then the timer value should be "infinity"

Scenario: Initial face icon, neutral by default
Then the face icon should be a neutral face 

Scenario: State of the face icon, the user lost
Given the user load the following board: "*-"
When the user discover cell "(1,1)" should show a mine
Then the face icon should be a sad face 

Scenario: State of the face icon, the user wins
Given the user load the following board: "*-"
When the user discover the cell "(1,2)"
Then the user should win the game 
And the user icon should be happy face

@manual
Scenario: Resetting game, face icon is discovered
Given the game should be over
When user discover a face icon
Then the game is reset