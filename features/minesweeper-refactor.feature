Feature: Minesweeper

bla bla bla
 

Background:
	Given a user opens the app

Scenario: Initial graphical elements values
When the game starts
Then  the "<elements>" have the text "<values>"

Examples:
 
|elements     |values|
|mine		  |  *   |
|hiddenBox    |  -   |
|unlockedBox  |  x   |
|flag         |  !   |
|flagsCont    |  10  |
|interrogation|  ?   |
|gameOver     | 0-1  |
|timer        | 0-1  |
|face         | 1-3  |
|winner       | 0-1  |

Scenario Outline: load game board data
When the game starts
Then the "<boardData>" is charging in the game

Examples:

| boardData | row |
| ---*----  |  1  |
| ---*----  |  2  |
| ---*----  |  3  |
| ---*----  |  4  |
| ---*----  |  5  |
| ---*----  |  6  |
| ---*----  |  7  |
| ---*----  |  8  |

Scenario Outline: load visible game board data
When the game starts
Then the "<VisibleBoardData>" is charging in the game

Examples:

| VisibleBoardData | row |
| 	 --------  	   |  1  |
|	 --------  	   |  2  |
| 	 --------  	   |  3  |
|  	 --------  	   |  4  |
| 	 --------  	   |  5  |
|	 --------      |  6  |
| 	 --------      |  7  |
| 	 --------      |  8  |

Scenario: Validating the dimensions of the minefield
Then the height of the minefield should be eight rows
And the width of the minefield should be eight columns

Scenario: Game State when the game is in progress
When game have started
Then the "<gameOver>"  will have the following next value:"0"

Scenario: Game State when the game is finish
When game have finished
Then the "<gameOver>"  will have the following next value:"1"

Scenario: Number of initial not tagged mined counter
Then the not tagged mined counter should be "10"

Scenario: Tagging a cell as mined (Tagging with a Flag)
Given the not tagged mines counter is "10"
When the user tags as mined the cell "(1,1)"
Then the cell "(1, 1)" should show a flag symbol
And the not tagged mines counter should be "9"

Scenario Outline: Flags counter at the end of the game
When user click "<flag>" and game state change to "<gameOver>":"1"
Then "<flagCont>" couldn't increase

Examples:

| VisibleBoardData | row |
| 	 ----*---  	   |  1  |
|	 ----*---  	   |  2  |
| 	 ----*---  	   |  3  |
|  	 ----*---  	   |  4  |
| 	 ----*---  	   |  5  |
|	 ----*---      |  6  |
| 	 ----*---      |  7  |
| 	 ----*---      |  8  |

Scenario: Timer actived when game started
When game state change to "<gameOver>":"0"
Then the "<timer>" will have the following next value:"1"

Scenario: Timer disactived when game over
When  game state change to "<gameOver>":"1"
Then the "<timer>" will have the following next value:"0"

Scenario: Initial face
Given game state change to "<gameOver>":"0"
When "<face>" have the following value:"1"
Then the face icon change a neutral face 

Scenario: Face when user wins
Given game state change to "<gameOver>":"1"
When "<winner>" change the following value:"1" and "<face>" have the following value:"2"
Then the face icon change a happy face

Scenario: Face when user lost
Given game state change to "<gameOver>":"1"
When "<winner>" change the following value:"0" and "<face>" have the following value:"3"
Then the face icon change a sad face

Scenario Outline: User click a mine in the first round
When the user click a "<mine>" and the game state have "<gameOver>":"0"
Then  a "<hiddenBox>" change to "<mine>" 
"""
	 --------  	   
 	 --------  	   
  	 --------  	   
 	 --------  	  
	 --------      
 	 --------      
 	 --------   
"""

Examples:

| VisibleBoardData | row |
| 	 ---*----/----*----  	   |  1  |
|	 --------  	   |  2  |
| 	 --------  	   |  3  |
|  	 --------  	   |  4  |
| 	 --------  	   |  5  |
|	 --------      |  6  |
| 	 --------      |  7  |
| 	 --------      |  8  |


Scenario Outline: User click a mine in the first round and game over
When the user after click a "<mine>" and after the game state have "<gameOver>":"1"
Then  all "<mine>" will be unlocked

Examples:

| VisibleBoardData | row |
| 	 ---*----  	   |  1  |
|	 ---*----  	   |  2  |
| 	 ---*----  	   |  3  |
|  	 ---*----  	   |  4  |
| 	 ---*----  	   |  5  |
|	 ---*----      |  6  |
| 	 ---*----      |  7  |
| 	 ---*----      |  8  |

Scenario Outline: User click all hidden boxes without mines
Given the user click the last "<hiddenBox>"
When all "<unlockedBox>" are unlocked and all "<mine>" hidden
Then "<winner>" change the following value:"1" and  game state change to "<gameOver>":"1"

Examples:

| VisibleBoardData | row |
| 	 xxxx-xxx  	   |  1  |
|	 xxxx-xxx      |  2  |
| 	 xxxx-xxx      |  3  |
|  	 xxxx-xxx      |  4  |
| 	 xxxx-xxx      |  5  |
|	 xxxx-xxx      |  6  |
| 	 xxxx-xxx      |  7  |
| 	 xxxx-xxx      |  8  |

| boardData | row |
| xxxx*xxx  |  1  |
| xxxx*xxx  |  2  |
| xxxx*xxx  |  3  |
| xxxx*xxx  |  4  |
| xxxx*xxx  |  5  |
| xxxx*xxx  |  6  |
| xxxx*xxx  |  7  |
| xxxx*xxx  |  8  |

Scenario: User clicks twice in a row on a box
Given the user click  and activate "<flag>"
When user click and activate "<interrogant>"
Then the "<flagCont>" will add one to its value

Examples:
 
| VisibleBoardData | row |
| 	 --------  	   |  1  |
|	 ----!---  	   |  2  |
| 	 --------  	   |  3  |
|  	 --------  	   |  4  |
| 	 --------  	   |  5  |
|	 --------      |  6  |
| 	 --------      |  7  |
| 	 --------      |  8  |

|flagCont|
|  9 	 |

--------------------------------

| VisibleBoardData | row |
| 	 --------  	   |  1  |
|	 ----?---  	   |  2  |
| 	 --------  	   |  3  |
|  	 --------  	   |  4  |
| 	 --------  	   |  5  |
|	 --------      |  6  |
| 	 --------      |  7  |
| 	 --------      |  8  |

|flagCont|
|  10 	 |