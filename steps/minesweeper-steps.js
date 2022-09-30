const {Given,When,Then} = require('@cucumber/cucumber');
const{expect} = require('@playwright/test'); 
const url="http://127.0.0.1:5500/";


Given('a user opens the app', async () => {
	await page.goto(url);
});

//Number of initial not tagged mined counter

Then('the not tagged mined counter should be {string}', async (string) => {
	const taggedMined = await page.locator('data-testid=taggedMined').innerText();
	expect(taggedMined).toBe(string);
});