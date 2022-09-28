Feature: Minesweeper
_____________________________
                        
GLOSSARY OF TERMS

Board data:
mine => |*|
emptyCell => |-|

Board info:
emptyCell => |-|
hiddenCell => |x|
mine => |*|
flag => |!|
interrogation => |?|
mine not tagged correctly => |X|
number of adjacent mines => |1-8|

cell position on the board => (1,2) means row 1 column 2
_____________________________

Background:
	Given a user opens the app

Scenario: Validating the dimensions of the minefield
Then the height of the minefield should be eight rows
And the width of the minefield should be eight columns

Scenario: Discovering a cell with a mine, the user should lose the game
Given the user load the following board: "*-"
When the user discover the cell "(1,1)"
Then  the cell "(1,1)" should show a mine 
And the game should be over

Scenario: Discovering all the cells without mine, the user should win the game
Given the user load the following board: "*-"
When the user discover the cell "(1,2)"
Then the user should win the game

Scenario Outline: Discovering a cell with mines around, show the number of surrounding mines
Given the user load the following board: "<board>"
When the user discover  cell "(2,2)"
Then the cell "(2,2)" should show a "<number>"

|    board    |  number |
| --*/---/--- |    1    |    
| --*/---/*-- |    2    |
| --*/---/**- |    3    |
| --*/---/*** |    4    |
| -**/---/*** |    5    |
| ***/---/*** |    6    |
| ***/*--/*** |    7    |
| ***/*-*/*** |    8    |

Scenario: Discovering a cell without mine & surrounding mines, should be empty
Given the user load the following board: "---/---/---/***"
When the user discover cell  "(2,2)"
Then the cell "(2,2)" should be empty

Scenario: Discovering and empty cell, discover the surrounding cells
Given the user load the following board: "---/---/---/***"
When the user discover cell "(2,2)"
Then the board should look like: "---/---/---/xxx"

Scenario: A neighbor discover an empty cell, discover the surrounding cells of the empty cell
Given the user load the following board:

"""
----
---*
---*
----
"""

When the user discover cell "(1,4)"
Then the board should look like: 

"""
--11
1-2x
1-2x
213x
"""

