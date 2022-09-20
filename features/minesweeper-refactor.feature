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
|hiddenBoxes  |  -   |
|flag         |  !   |
|interrogation|  ?   |

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
Then the "<ViisbleBoardData>" is charging in the game

Examples:

| ViisbleBoardData | row |
| 	 --------  	   |  1  |
|	 --------  	   |  2  |
| 	 --------  	   |  3  |
|  	 --------  	   |  4  |
| 	 --------  	   |  5  |
|	 --------      |  6  |
| 	 --------      |  7  |
| 	 --------      |  8  |

Scenario Outline: A mine is activated
When the  "<mine>" is actived 
Then the game stage change to "<gameOver>"

Scenario Outline: User click a mine in the first round
When the user click a "<mine>"
Then the game stage change to "<gameOver>" and "<hiddenBoxes>" change to "<mine>" 

Scenario: Default display screen
Given the game starts
When in "<VisbleBoardData>" is shown "hiddenBoxes" are hidden
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
Then the size of field is eight "rows" and eight characters in "<VisbleBoardData>"

Scenario: Number of initial flags
When the game starts
Then the "<flag>" will have the following next value:10