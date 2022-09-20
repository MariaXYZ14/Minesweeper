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
|flag         |  !   |
|flagsCont    |  10  |
|interrogation|  ?   |
|gameOver     | 0/ 1 |
|timer        |0/1   |

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
When the user click a "<mine>"
Then the game state change to "<gameOver>":"1" and "<hiddenBox>" change to "<mine>" 

| VisibleBoardData | row |
| 	 ---*----  	   |  1  |
|	 --------  	   |  2  |
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

Scenario Outline: Game State when the game is in progress
When game have started
Then the "<gameOver>"  will have the following next value:0

Scenario Outline: Game State when the game is finish
When game have finished
Then the "<gameOver>"  will have the following next value:1

Scenario: Number of initial flags
When the game starts
Then the "<flagsCont>" will have the following next value:10

Scenario Outline: User click the right button to enter a flag
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

Scenario Outline: timer actived 
When game have started
Then the "<timer>"  will have the following next value:"1"

Scenario Outline: timer disactived 
When game have started
Then the "<timer>"  will have the following next value:"0"