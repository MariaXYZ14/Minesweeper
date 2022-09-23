Feature: Minesweeper
_____________________________
                        
GLOSSARY OF TERMS

mine => |*|
hiddenCell => |x|
emptyCell => |-|
mine => |*|
flag => |!|
interrogation => |?|
mine not placed correctly => |X|
numbers => |1-8|
_____________________________

Background:
	Given a user opens the app

Scenario: Validating the dimensions of the minefield
Then the height of the minefield should be eight rows
And the width of the minefield should be eight columns

Scenario: Clicking a cell with a mine
When the user click cell "(1,1)"
Then  the cell "(1,1)" should show a mine 
And game over

Scenario: User win the game
Given the user click cell "(8,8)"
When all mines haven't clicked
Then the user is the winner

Scenario Outline: Clicking a cell with mines around
Given the user load the "<board>"
When the user click  cell "(2,5)"
Then the cell "(2,5)" should show a "<number>"

|    board    |  number |
| xx*/xxx/xxx |    1    |    
| xx*/xxx/*xx |    2    |
| xx*/xxx/**x |    3    |
| xx*/xxx/*** |    4    |
| x**/xxx/*** |    5    |
| ***/xxx/*** |    6    |
| ***/*xx/*** |    7    |
| ***/*x*/*** |    8    |

Scenario: A neighbor unlocks an empty cell
Given the user click cell "(4,3)" and cell with number should show "1"
When the user click cell "(3,3)"
Then the cell is unlocked and should show as empty cell

Scenario Outline: Clicking a cell without numbers or mines
Given the user load the "<board>"
When the user click cell 
Then the "<baord>" unlocked to "<boardUnlocked>"

|        board        |     boardUnlocked     |
| xxxx/xxxx/xxxx/xxxx | 1112/---1/--12/--1x   |
|     xxx/xx*/xxx     |      x1-/x1-/x1-      | 
|     xxx/xxx/xxx     |      111/1-1/111      |   


