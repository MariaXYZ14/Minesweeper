const {Given,When,Then} = require('@cucumber/cucumber');
const{expect} = require('@playwright/test'); 
const url="http://127.0.0.1:5500/";



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

//Number of initial not tagged mined counter

Then('the not tagged mined counter should be {string}', async (string) => {
	const taggedMined = await page.locator('data-testid=taggedMined').innerText();
	expect(taggedMined).toBe(string);
});


//Initial face icon, neutral by default

Then('the face icon should be a neutral face', async () => {

	return 'pending';
  });
