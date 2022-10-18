const {Given,When,Then} = require('@cucumber/cucumber');
const{expect} = require('@playwright/test'); 
const url="https://mariaxyz14.github.io/Minesweeper/";

function getCellId(string){
	
	let cell;
		
	let stringComma=string.split(",");
	let x=stringComma[0];
	x=x[1]-1;
	let y=stringComma[1];
    y=y[0]-1;
	
	cell="cells"+x+"-"+y;

	return cell;

}

function obtainURL(string){

	return url+"?="+string;

}

Given('a user opens the app', async () => {
	
	await page.goto(url);

});

//Validating the dimensions of the minefield

Then('the height of the minefield should be eight rows', async () => {

	let rows = await page.locator('#panel tr');
	let numberOfRows = await rows.count();
	expect(numberOfRows).toBe(8);

});

Then('the width of the minefield should be eight columns', async () => {

	let columns = await page.locator('#row1 td');
	let numberOfColumns = await columns.count();
	expect(numberOfColumns).toBe(8);  

});

//Discovering a cell with a mine, the user should lose the game

  	Given('the user load the following board: {string}', async (string) => {
	
	let path= obtainURL(string);
	await page.goto(path);

  });

  When('the user discover the cell {string}', async (string) =>{
	
    let cellId = getCellId(string);
	let cell = await page.locator("#"+cellId);
	await cell.click();

  });

 
  Then('the cell {string} should show a mine', async (string) => {
   
	let cellId = getCellId(string);
	let cell = await page.locator("#"+cellId);
	let mine = await cell.getAttribute('class');
	
	expect(mine).toBe("mine");  
   
  });

  Then('the game should be over', async () => {
	
	 let gameOver= await page.locator("#gameOver").getAttribute('id');
	 expect(gameOver).toBe("gameOver");  

  });

//Discovering all the cells without mine, the user should win the game
  
   Then('the user should win the game', async () => {
	
	let win= await page.locator("#win").getAttribute('id');
	expect(win).toBe("win"); 

  });

//Discovering a cell with mines around, show the number of surrounding mines
	
    Then('the cell {string} should show a {string}', async (string, string2)=> {       

		let cellId = getCellId(string);
	    let cell = await page.locator("#"+cellId);
		let number = await page.locator("#"+cellId).innerText();
		await cell.click();
		expect(number).toBe(string2); 

	});

//Discovering a cell without mine & surrounding mines, should be empty

	Then('the cell {string} should be empty',  async (string) => {
		
		let cellId = getCellId(string);
		let cell = await page.locator("#"+cellId);
		let emptyCell = await cell.getAttribute('class');
	
		expect(emptyCell).toBe("cellWithoutMines"); 

	});

//Discovering and empty cell, discover the surrounding cells

	Then('the board should look like:',async (docString) => {
		
		let minesField="";
		let docStringSplit=docString.split("\n");
		
		for(let i=0;i<docStringSplit.length;i++){

			for(let j=0;j<docStringSplit[i].length;j++){

				let cellId= "cells"+i+"-"+j;
				let cell = await page.locator("#"+cellId);
				let cellClass = await cell.getAttribute('class');
                
				if(cellClass == 'cellWithoutMines'){

					minesField+="-";
				}
				else{
					
					minesField+="x";

				}
                
			}
			if(i!=docStringSplit.length-1){
				
				minesField+="\n";

			}

		}

		expect(minesField).toBe(docString); 
	
    });

//A neighbor discover an empty cell, discover the surrounding cells of the empty cell

Then('the board result should look like:',async (docString) => {
		
		let minesField="";
		let docStringSplit=docString.split("\n");

		for(let i=0;i<docStringSplit.length;i++){

			for(let j=0;j<docStringSplit[i].length;j++){

				let cellId= "cells"+i+"-"+j;
				let cell = await page.locator("#"+cellId);
				let cellClass = await cell.getAttribute('class');
				let number = await cell.innerText();

				if(cellClass == 'cellWithoutMines'){
				
					if(number==""){
						
						minesField+="-";

					}
					else{

						minesField+=number;

					}

				}
				else if(number == 'x'){
					
					minesField+="X";

				}
				else if(cellClass == 'mine'){
					
					minesField+="*";

				}
				else{
					
					minesField+="x";

				}	
			}
				
			if(i!=docStringSplit.length-1){
				
				minesField+="\n";

			}

		}
		
		expect(minesField).toBe(docString); 

	});
//Tagging a cell as mined (Tagging with a Flag)

	When('the user tags as mined the cell {string}', async (string) => {
		
		let cellId = getCellId(string);
		let cell = await page.locator("#"+cellId);
	    await cell.click({button:"right"});

	});

	Then('the cell {string} should show a flag symbol', async (string) => {
		
		let cellId =getCellId(string);
		let cell = await page.locator("#"+cellId);
		let flag = await cell.getAttribute('class');
	    expect(flag).toBe("flag"); 

	});

//Mines counter as tagging a cell as mined 

	Given('the not tagged mines counter is {string}',async (string) => {
		
		const taggedMined = await page.locator('data-testid=taggedMined').innerText();
		expect(taggedMined).toBe(string);

	});

	Then('the not tagged mines counter should be {string}', async (string) => {
		
		const taggedMined = await page.locator('data-testid=taggedMined').innerText();
		expect(taggedMined).toBe(string);

	});


//Tagging a cell as uncertain mined (Tagging with a Interrogation) 

	When('the user tags as uncertain mined the cell {string}', async (string) => {
		
		let cellId = getCellId(string);
		let cell = await page.locator("#"+cellId);
	    await cell.click({button:"right"});
	    await cell.click({button:"right"});

  	});

  	Then('the cell {string} should show a uncertain mined cell symbol', async (string) => {
		
		let cellId =getCellId(string);
		let cell = await page.locator("#"+cellId);
		let interrogation = await cell.getAttribute('class');
	    expect(interrogation).toBe("interrogation"); 

 	});

//Number of initial not tagged mined counter

	Then('the not tagged mined counter should be {string}', async (string) => {
		const taggedMined = await page.locator('data-testid=taggedMined').innerText();
		expect(taggedMined).toBe(string);
	});

//Tagging a cell as mined but truly isn't a mine

//Initial face icon, neutral by default

	Then('the face icon should be a neutral face', async () => {

		let face = await page.locator('data-testid=face').innerText();
		expect(face).toBe("😐"); 

	});

//State of the face icon, the user lost

	When('the user discover cell {string} should show a mine', async (string) => {
		
		let cellId = getCellId(string);
		let cell = await page.locator("#"+cellId);
		await cell.click();
		let mine = await cell.getAttribute('class');
		expect(mine).toBe("mine");  
   
	});

   Then('the face icon should be a sad face', async () => {
	
		let face = await page.locator('data-testid=face').innerText();
		expect(face).toBe("🙁");
    });

//State of the face icon, the user wins

	Then('the user icon should be happy face', async () => {
		let face = await page.locator('data-testid=face').innerText();
		expect(face).toBe("😀");
	});

//Reseting a game, restore the innitial state

	Given('the user load the following board:{string}', async (string) => {
		
		let path= obtainURL(string);
		await page.goto(path);

	});
	
	Given('board result should look like:', async (docString)=> {

		let minesField="";
		let docStringSplit=docString.split("\n");

		for(let i=0;i<docStringSplit.length;i++){

			for(let j=0;j<docStringSplit[i].length;j++){

				let cellId= "cells"+i+"-"+j;
				let cell = await page.locator("#"+cellId);
				let cellClass = await cell.getAttribute('class');
				let number = await cell.innerText();

				if(cellClass == 'cellWithoutMines'){
				
					if(number==""){
						
						minesField+="-";

					}
					else{

						minesField+=number;

					}

				}
				else if(number == 'x'){
					
					minesField+="X";

				}
				else if(cellClass == 'mine'){
					
					minesField+="*";

				}
				else{
					
					minesField+="x";

				}	
			}
				
			if(i!=docStringSplit.length-1){
				
				minesField+="\n";

			}

		}
		
		expect(minesField).toBe(docString); 
	});

	When('the user resets the game', async () => {
		
		let face = await page.locator('data-testid=face');
	    await face.click();

	});

	Then('the timer should be disabled', async () => {
		
		let timer = await page.locator('data-testid=timer').innerText();
		expect(timer).toBe("0"); 

	});

//Resetting game using the face button with the mouse(toDo)

	Given('the user discover cell {string}', async (string) => {
		
		let cellId = getCellId(string);
		let cell = await page.locator("#"+cellId);
		await cell.click();

	});
	When('the user clicks on face icon', async () => {
	
		let face = await page.locator('data-testid=face');
	    await face.click();

	});
