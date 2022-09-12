Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Default display screen
When in screen is shown and all boxes are hidden
Then the game starts

Scenario:User click a hidden mine
Given the box is hidden
When in screen is shown a mine in the box
Then all the hidden boxes are no longer hidden and game finish

Scenario: User click a hidden box without number or mine
Given the box is hidden
When in screen is shown a number in the box


