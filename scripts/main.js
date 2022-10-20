    let minefield;
    let width;
    let height;
    let countEmptyCell = 0;
    let countIsNotaMine = 0;
    let gameFinished = false;
    let timer = 0;
    let myInterval;
    let isTimerInicializated = false;

    window.onload = function(){ 
       
        document.getElementById('game').oncontextmenu = function (event) { event.preventDefault(); }  
        startGame();  
        getFace().onclick = function () { resettingGame()};

    }
    
    function startGame() { 
    
        var mockData = getParametersURL();

        if (mockData == '') {

            generateStaticMineField();

        }
        else {

            generateMinesForMockData(mockData);

        }
        
        createTable();
        
    }

    function getFace() { 
        
        return document.getElementById('face');

    }
    
    function getCell(i,j){ 
        
        return document.getElementById('cells' + i + '-' + j);

    }
    
    function getParametersURL(){
        
        var pageURL = window.location.search.substring(1);

        if (pageURL == '') {

            return pageURL;

        }
        
        return pageURL.substring(pageURL.indexOf('=') + 1).split('/');
        
    }

    function generateMinesForMockData(mockData){
    
        height = mockData.length;
        width = mockData[0].length;

        generateMinefield();
                
       
        for (var i = 0; i < height; i++){

            for (var j = 0; j < width; j++){
         
                if (mockData[i][j] == '*') {
                
                    minefield[i][j] = {
                
                        value: 'mines',
                        visibility: 'hidden',
                        tag: 'none',
                        clicks:'0'

                    };
                
                } 
                else {
                
                    minefield[i][j] = {
                
                        value: 'emptyCell',
                        visibility: 'hidden',
                        tag: 'none',
                        clicks: '0'
                        
                    };

                    countIsNotaMine++;
                }

            }

        }

    }
    
    function generateMinefield() {
            
        minefield = new Array(height);
         
        for (var i = 0; i < minefield.length; i++){
           
            minefield[i] = new Array(width);

        }

    }

    function generateStaticMineField(){
       
        height = 8;
        width = 8;
        countIsNotaMine = 54;
        
        generateMinefield();

        for (var i = 0; i < height; i++){
 
            for (var j = 0; j < width; j++){

                minefield[i][j] = {
                
                    value: 'emptyCell',
                    visibility: 'hidden',
                    tag: 'none',
                    clicks: '0'
                    
                };

            }

        }

        generateRandomMines();
         
    }

    function generateRandomMines() { 
        
        let NumberOfMinesLaid = 0;
        let min = 0;
        let max = 7;

        while (NumberOfMinesLaid < 10) {
            
            let i = Math.floor(Math.random() * (max - min) + min);
            let j = Math.floor(Math.random() * (max - min) + min);
 
            if (minefield[i][j].value != 'mines') {
                
                minefield[i][j].value = 'mines';

            }

            NumberOfMinesLaid++;

        }

    }
    
    function createTable(){

        var table = document.getElementById('panel');

        for (var i = 0; i < height; i++){

            var row = document.createElement('tr');
            row.setAttribute('id','row'+i);
    
            for (var j = 0; j < width; j++){
                 
                var cell = document.createElement('td'); 
                cell.setAttribute('id', 'cells' + i + '-' + j); 
                cell.onclick = discoverCell.bind(cell, i, j);      
                cell.oncontextmenu = taggedCell.bind(cell, i, j);   
                row.appendChild(cell);
                 
            }

            table.appendChild(row);

        }
       
    }

    function discoverCell(row,column){
  
        getCell(row, column).classList.remove("flag");  
        getCell(row, column).classList.remove("interrogation");
          
        if (minefield[row][column].visibility == 'hidden' && !gameFinished) {
     
            if (minefield[row][column].value == 'mines') {
                   
                    getCell(row,column).classList.add("mine");      
                    showAllMines();
                    losed();
                         
            }
                
            else if (minefield[row][column].value == 'emptyCell') {
                    
                    
                let minesAround = SearchForMinesAround(row, column);

                    
                minefield[row][column].visibility = 'notHidden';       
                getCell(row, column).classList.add("cellWithoutMines");  
                countEmptyCell++;   
                if (minesAround > 0) {
                          
                    getCell(row, column).innerHTML = minesAround;

                    
                }    
                else {
      
                    revealNeighbourCells(row, column)
                      
                }

                
            }    
            
            if (!isTimerInicializated && !gameFinished) {
                              
                startTimer();      
                isTimerInicializated = true;
            }
     
            if (countIsNotaMine == countEmptyCell) {
                  
                gameFinished = true;     
                winned();
                
            }
            
        } 

    }

    function showAllMines() {
 
        for (var i = 0; i < height; i++){ 
                          
            for (var j = 0; j < width; j++){
             
                if (getCell(i, j).classList.contains("flag")) {
                   
                    getCell(i, j).classList.remove("flag");
                    getCell(i, j).innerHTML = "x"; 
                    getCell(i, j).style.background = "white";
                    
                }               
                if (minefield[i][j].value == 'mines') {

                    minefield[i][j].visibility = 'notHidden'; 
                    getCell(i, j).classList.add("mine");
 
                }  
            }
        }

        gameFinished = true;
        
    }
    
    function losed(){ 
        
        isTimerInicializated = false;
        stopTimer();
        getFace().innerHTML = "&#128577;";
        var gameOver = document.createElement('h3');
        gameOver.setAttribute('id', 'gameOver');
        document.body.appendChild(gameOver);  

    } 
        
    function winned() {
        
        isTimerInicializated = false;
        stopTimer();
        getFace().innerHTML = "&#128512;";
        var win = document.createElement('h3');
        win.setAttribute('id', 'win');
        document.body.appendChild(win);

    }

    function taggedCell(row, column) {
      
        var cell = getCell(row, column); 
        var Countflags = parseFloat(document.getElementById("Countflags").innerHTML);     
        var clicks = parseFloat(minefield[row][column].clicks);
        cell.setAttribute('value', '');
        clicks++;
        minefield[row][column].clicks = clicks;
        
        if (!isTimerInicializated) {
                        
            startTimer(); 
            isTimerInicializated = true;

        }    
        if (clicks == 1 && minefield[row][column].visibility == 'hidden' && !gameFinished) {
           
            cell.classList.add("flag");
            Countflags--;

        } 
        else if (clicks == 2 && minefield[row][column].visibility == 'hidden' && !gameFinished) {
           
            cell.classList.remove("flag");
            cell.classList.add("interrogation");
            Countflags++;
            cell.setAttribute('value', 'interrogation');
            
        }     
        else if (!gameFinished) {
         
            cell.classList.remove("interrogation");
            cell.classList.remove("flag");
            minefield[row][column].clicks = 0;
            cell.setAttribute('value','');

        }
        
        document.getElementById("Countflags").innerHTML = Countflags;

    }
    
    function startTimer(){
       
        myInterval = setInterval(myTimer, 1000);
       
        function myTimer() {

            timer++;
            document.getElementById("timer").innerHTML = timer;
            
        }

    }  

    function stopTimer(){
          
        clearInterval(myInterval);
            
    }
     
    function isPositionLegal(row,column){
       
        let isUndefinedMine = false;
    
        if (row < 0) {

            return isUndefinedMine = false;

        }    
        if (column < 0) {

            return isUndefinedMine = false;

        }     
        if (row >= height) {

            return isUndefinedMine = false;

        }     
        if (column >= width) {

            return isUndefinedMine = false;

        }   
        else {

            return isUndefinedMine = true;

        }
    }
 
    function SearchForMinesAround(row, column) {

        let minesAround = 0;
        let isUndefinedMine;

          
        for (let i = row - 1; i <= row + 1; i++){
 
            for (let j = column - 1; j <= column + 1; j++){
      
                isUndefinedMine = isPositionLegal(i, j);
   
                if (isUndefinedMine) {
                             
                    if (minefield[i][j].value == 'mines') {
                        
                        minesAround++;                         
                        
                    }
                                      
                }    
                
            }
            
        }
            
        return minesAround;

    }

    function revealNeighbourCells(row, column) {
         
        for (let i = row - 1; i <= row + 1; i++){
  
            for (let j = column - 1; j <= column + 1; j++){
    
                if (isPositionLegal(i, j)) {
                     
                    if (minefield[i][j].visibility == 'hidden') {
                  
                        discoverCell(i,j)
                        
                    }
                       
                }    
            }
 
        }
    }

    function clearTable(){

        var table = document.getElementById('panel');

        for (var i = 0; i < height; i++){
 
            var row = document.getElementById('row' + i);
  
            for (var j = 0; j < width; j++){
                  
                var cell = document.getElementById('cells' + i + '-' + j);
               
                row.removeChild(cell);
                 
            }

            table.removeChild(row);

        }

    }
    
    function resettingGame(){
       
        stopTimer(); 
        getFace().innerHTML = "&#128528;";
        document.getElementById('timer').innerHTML = "0";
        document.getElementById('Countflags').innerHTML = "10";
  
        isTimerInicializated = false;
        gameFinished = false;
        countEmptyCell = 0;
        countIsNotaMine = 0;
        timer = 0;
        
        clearTable();
        startGame();

    }