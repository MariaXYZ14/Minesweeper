Feature: Minesweeper
_____________________________

GLOSSARY OF TERMS

mine => |*|
hiddenCell => |-|
unlockedCell => |x|
mine => |*|
flag => |!|
interrogation => |?|
_____________________________

Background:
	Given a user opens the app

Scenario: Validating the dimensions of the minefield
Then the height of the minefield should be eight rows
And the width of the minefield should be eight columns

Scenario: Clicking a hidden cell  without number or mine
Given the cell should have value "-"
When user click a cell "(1,4)"
Then the  cell show value "x"

Scenario Outline: User click a cell with a mine
Given the cell "(1,1)" should show a hidden cell
When the user click cell "(1,1)"
Then  the cell "(1,1)" should show a mine 
And game over

  |   board   | cell  |
  |*--/---/---| (1,1) | 
  |---/*--/---| (1,2) |     
  |---/---/*--| (1,3) |     
  |-*-/---/---| (2,1) |     
  |---/-*-/---| (2,2) |     
  |---/---/-*-| (2,3) |     
  |--*/---/---| (3,1) |     
  |---/--*/---| (3,2) |     
  |---/---/--*| (3,3) |     


