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

Scenario: Timer is initialized when clicking in a cell
Given the timer should be disabled 
When the user click cell "(1,2)"
Then the timer should be enabled

Scenario: Timer is stopped when clicking in a mine
Given the timer should be enabled 
When the user click cell "(1,3)" should show a mine
Then the timer should be disabled

Scenario: Initial face
When the timer should be disabled
Then the face icon change a neutral face 

Scenario: Face when user lost
Given the timer should be enabled
When the user click cell "(1,1)" should show a mine
Then the face icon change a sad face 

Scenario: Face when user lost
Given the timer should be enabled
When all mines are hidden
Then the user icon change a happy face