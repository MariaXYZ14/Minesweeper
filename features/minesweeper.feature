Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Number of initial not tagged mined counter
Then the not tagged mined counter should be "10"

Scenario: Tagging a cell as mined but truly isn't a mine
Given the user load the following board: "*---/--**/----/-*--"
When the user tags as mined the cell "(2,2)" 
And the user discover the cell "(1,1)"
Then the board result should look like:

"""
*xxx
xX**
xxxx
x*xx
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

Scenario: Reseting a game, restore the innitial state
Given the user load the following board:"*--/---/---"
And the user discover the cell "(2,1)" 
And board result should look like: 

"""
xxx
1xx
xxx
"""
When the user resets the game
Then the not tagged mines counter should be "10"
And the timer should be disabled 
And board result should look like:

"""
xxx
xxx
xxx
"""

Scenario: Resetting game using the face button with the mouse
Given the user load the following board: "*-"
And the user discover cell "(1,2)"
And the user should win the game
When the user clicks on face icon
Then board result should look like:

"""
xx
"""