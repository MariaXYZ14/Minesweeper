Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Default display screen
When in screen is shown and all boxes are hidden
Then the game starts and 

Scenario:User click a hidden mine
Given the box is hidden
When in game screen is shown a mine in the box
Then all the hidden boxes are no longer hidden and game finish

Scenario: User click a hidden box without number or mine
Given the box is hidden

Scenario Outline: User click a hidden box with <number>
Given the box is hidden
When in the box  is shown a <number>
Then in game <number> will be displayed depending on the <numberMines> around it

Examples:
|	|	|	| -1|	|	|	|-1	|
|-1	|	|	|	|	|-1	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|-1	| 3	|-1 |	|	|-1	|
|	|	|	|-1	|	|	|	|	|
|-1	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|-1	|