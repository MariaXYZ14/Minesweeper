Feature: Minesweeper

Background:
	Given a user opens the app

Scenario: Default display screen
Given the game starts
When in screen is shown and all boxes are hidden
Then the user could play

Scenario: Default mines field 
Given until the game starts
When in screen is shown a mines field
Then the size of field is 8 mines of width and 8 mines of height


Scenario:Initial graphical elements values
When the game starts
Then  the <elements> have the text <values>
Examples:
 
|elements     |values|
|hiddenMines  |  -1  |
|unlockedMines|   0  |
|numbers	  |  1-8 |
|hiddenBoxes  | null |

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

Scenario:Initial face
Given the game starts
When is shown <face>
And <face> = 1
Then the face icon change a neutral face 

Scenario: Face when user wins
Given the game finish
When the user win
Then the <face>=2 and the face icon change a happy face

Scenario: Face when user lost
Given the user finish
When the user lost
The the <face>=3 and the face icon change a sad face

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


Scenario Outline: User click a hidden mine in the first round
Given the game starts
When the user click a <hiddenMines>
Then the all hidden mines are unlocked and game finish

Examples:

|	|	|	| -1|	|	|	|-1	|
|	|	|	|	|	|-1	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|
|	|	|-1	| 	|-1 |	|	|-1	|
|	|	|	|-1	|	|	|	|-1	|
|-1	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|-1	|

Scenario: 