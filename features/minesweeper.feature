Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Default display screen
Given the game starts
When in screen is shown and all boxes are hidden
Then the user could play

Scenario: Number of initial flags
Given the game starts
When is shown the <flagsCont>
Then the <flagsCont> = 10

Scenario: Flags counter at the end of the game
Given the game finish
When user click right button of mouse 
Then <flagsCont> couldn't increase

Scenario: Time initiador
Given the game starts
When is shown <timer>
Then the value of <timer> = 0

Scenario:Game over timer
Given the game finish
When is shown <timer>
Then th <timer> will be stop

Scenario Outline:User click a hidden mine
Given the box is hidden
When in game screen is shown a <mine> in the box
And <mine> change his value for 0
Then all the hidden <mine> boxes are no longer hidden and game finish


Examples:

|	|	|	| 0 |	|	|	| 0	|
| 0	|	|	|	|	| 0	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|
|	|	| 0	| 	| 0 |	|	| 0	|
|	|	|	| 0	|	|	|	|	|
| 0	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	| 0	|


Scenario: User click a hidden box without number or mine
Given the box is hidden
When in game is shown the unlocked box
Then nearby  hidden boxes around it are unlocked 

Scenario Outline: User click a hidden box with <number>
Given the box is hidden
When in the box  is shown a <number>
Then in game <number> will be displayed depending on the  number of mines around it

Examples:

|	|	|	| -1|	|	|	|-1	|
|-1	|	|	|	|	|-1	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|-1	| 3	|-1 |	|	|-1	|
|	|	|	|-1	|	|	|	|	|
|-1	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|-1	|

Scenario: User click all hidden boxes without mines
Given the user click the last hidden box
When all boxes are unlocked and mines hidden
Then the user win and game finished

