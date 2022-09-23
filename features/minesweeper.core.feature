Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Number of initial not tagged mined counter
Then the not tagged mined counter should be "10"

Scenario: Tagging a cell as mined (Tagging with a Flag)
Given the not tagged mines counter is "10"
When the user tags as mined the cell "(1,1)"
Then the cell "(1, 1)" should show a flag symbol
And the not tagged mines counter should be "9"

Scenario: Tagging a cell as  possible mined (Tagging with a Interrogation)
Given the not tagged mines counter is "9"
When the user tags as possible mined the cell "(1,1)"
Then the cell "(1, 1)" should show a interrogation symbol
And the not tagged mines counter should be "10"

Scenario: Tagging a cell as mined but truly isn't a mine
Given the user tagged mine in cell "(3,3)"
When the user click cell "(8,7)" and this a mine
Then the cell "(3,3)" should show a mine not placed correctly

Scenario: Timer is initialized when clicking in a cell
Given the timer should be disabled 
When the user click cell "(1,2)"
Then the timer should be enabled

Scenario: Timer is stopped when clicking in a mine
Given the timer should be enabled 
When the user click cell "(1,3)" should show a mine
Then the timer should be disabled

Scenario: Timer change to infinity when pass ten minuts
Given the timer value should be "599" 
When the timer pass the value "600"
Then the timer value should be "infinity"

Scenario: Initial face icon
When the timer should be disabled
Then the face icon change a neutral face 

Scenario: Face icon when user lost
Given the timer should be enabled
When the user click cell "(1,1)" should show a mine
Then the face icon change a sad face 

Scenario: Face when user win
Given the timer should be enabled
When all mines are hidden
Then the user icon change a happy face

@manual
Scenario: Resetting game when face icon is clicked
Given the user lost 
When user click a face icon
Then the game is reset