Feature: Minesweeper

Background:
	Given a user opens the ap

Scenario: Initial graphical elements values
When the game starts
Then  the "<elements>" have the text "<values>"

Examples:
 
|elements     |values|
|mine		  |  *   |
|numbers	  |  1   |
|numbers	  |  2   |
|numbers	  |  3   |
|numbers	  |  4   |
|numbers	  |  5   |
|numbers	  |  6   |
|numbers	  |  7   |
|numbers	  |  8   |
|hiddenBox    |  -   |
|unlockedBox  |  x   |
|flag         |  !   |
|flagsCont    |  10  |
|interrogation|  ?   |
|gameOver     | 0/ 1 |
|timer        |0/1   |
|face         |1-3   |
|winner       |0/1   |

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

Scenario Outline: User click a mine in the first round
When the user click a "<mine>" and the game state have "<gameOver>":"0"
Then  and "<hiddenBox>" change to "<mine>" 

| VisibleBoardData | row |
| 	 ---*----  	   |  1  |
|	 ---*----  	   |  2  |
| 	 ---*----  	   |  3  |
|  	 ---*----  	   |  4  |
| 	 ---*----  	   |  5  |
|	 ---*----      |  6  |
| 	 ---*----      |  7  |
| 	 ---*----      |  8  |

Scenario Outline: User click a mine in the first round and game over
When the user before click a "<mine>" and after the game state have "<gameOver>":"1"
Then  all "<mine>" will be unlocked

| VisibleBoardData | row |
| 	 ---*----  	   |  1  |
|	 -------  	   |  2  |
| 	 --------  	   |  3  |
|  	 --------  	   |  4  |
| 	 --------  	   |  5  |
|	 --------      |  6  |
| 	 --------      |  7  |
| 	 --------      |  8  |

Scenario: Default display screen
Given the game starts
When in "<VisibleBoardData>" is shown "<hiddenBox>" are hidden
Then the user could play

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

Scenario: Default mines field 
When in screen is shown "<VisbleBoardData>"
Then the size of field is eight "<rows>" and eight characters in "<VisbleBoardData>"

Scenario: Game State when the game is in progress
When game have started
Then the "<gameOver>"  will have the following next value:"0"

Scenario: Game State when the game is finish
When game have finished
Then the "<gameOver>"  will have the following next value:"1"

Scenario: Number of initial flags
When the game starts
Then the "<flagsCont>" will have the following next value:10

Scenario: User click the right button to enter a flag
Given the game state  be "<gameOver>":"0"
When "<hiddenBox>" change to "<flag>"
Then "<flagCont>" will be one subtracted from its value

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
Then the "<timer>"  will have the following next value:"1"

Scenario: Timer disactived when game over
When  game state change to "<gameOver>":"1"
Then the "<timer>"  will have the following next value:"0"

Scenario: Initial face
Given game state change to "<gameOver>":"0"
When "<face>" have the following value: "1"
Then the face icon change a neutral face 

Scenario: Face when user wins
Given game state change to "<gameOver>":"1"
When "<winner>" change the following value: "1" and "<face>" have the following value: "2"
Then the face icon change a happy face

Scenario: Face when user lost
Given game state change to "<gameOver>":"1"
When "<winner>" change the following value: "0" and "<face>" have the following value: "3"
Then the face icon change a sad face

Scenario Outline: User click all hidden boxes without mines
Given the user click the last "<hiddenBox>"
When all "<unlockedBox>" are unlocked and all "<mine>" hidden
Then "<winner>" change the following value: "1" and  game state change to "<gameOver>":"1"

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