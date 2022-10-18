    var minefield;
    var width;
    var height;
    let countEmptyCell=0;
    let countIsNotaMine=0;
    var gameFinished=false;
    let timer=0;
    let myInterval;
    let isTimerInicializated=false;

    window.onload = function(){ 
        
    document.getElementById('game').oncontextmenu=function(event){event.preventDefault();}  
    var mockData=getParametersURL();

    if(mockData==''){

        generateStaticMineField();

    }
    else{


        generateMinesForMockData(mockData);

    }
    
    createTable();
    document.getElementById('face').onclick = function(){resettingGame()};

    }

    function getParametersURL(){
        
        var pageURL = window.location.search.substring(1);

        if(pageURL==''){

            return pageURL
        }
        
        return pageURL.substring(pageURL.indexOf('=')+1).split('/');
    }

   
    function generateMinesForMockData(mockData){
    
        height = mockData.length;
        width = mockData[0].length;

        minefield = new Array(height);
        
        for( var i=0;i<minefield.length;i++){

            minefield[i] = new Array(width);

        }
            
        for( var i=0;i<height;i++){

            for( var j=0;j<width;j++){
        

                if(mockData[i][j]=='*'){
                
                    minefield[i][j] = {
                
                        value: 'mines',
                        visibility: 'hidden',
                        tag: 'none',
                        clicks:'0'

                    };
                
                }
                else{
                
                    minefield[i][j] = {
                
                        value: 'emptyCell',
                        visibility: 'hidden',
                        tag: 'none',
                        clicks:'0'
                    };

                    countIsNotaMine++;
                }

            }

        }

    }

    function generateStaticMineField(){
       
        let min=0;
        let max=7;
        let NumberOfMinesLaid=0;
        height=8;
        width=8;
        countIsNotaMine=54;
        
        minefield = new Array(8);
        
        for( var i=0;i<8;i++){

            minefield[i] = new Array(8);

        }

        for( var i=0;i<height;i++){

            for( var j=0;j<width;j++){

                minefield[i][j] = {
                
                    value: 'emptyCell',
                    visibility: 'hidden',
                    tag: 'none',
                    clicks:'0'
                };

            
            }
        }

              
        while(NumberOfMinesLaid<10){

        i= Math.floor(Math.random() * (max - min) + min);
        j= Math.floor(Math.random() * (max - min) + min);
        console.log(i,j);
        
        if(minefield[i][j].value!='mines'){
            
            minefield[i][j].value='mines';


        }

        NumberOfMinesLaid++;

        }
       
  
    }

    
    function createTable(){

        var table=document.getElementById('panel');

        for( var i=0;i<height;i++){

            var row =document.createElement('tr');
            row.setAttribute('id','row'+i);

            for( var j=0;j<width;j++){
                
                var cell =document.createElement('td');
                cell.setAttribute('id','cells'+i+'-'+j);
                cell.onclick = discoverCell.bind(cell,i,j);
                cell.oncontextmenu = taggedCell.bind(cell,i,j);
                row.appendChild(cell);
                 
            }

            table.appendChild(row);

        }
       
    }

    function discoverCell(row,column){

        document.getElementById('cells'+row+'-'+column).classList.remove("flag");
        document.getElementById('cells'+row+'-'+column).classList.remove("interrogation");
        
        
        var face=document.getElementById("face");

            if(minefield[row][column].visibility=='hidden' && !gameFinished){

                if(minefield[row][column].value=='mines'){
                   
                    document.getElementById('cells'+row+'-'+column).classList.add("mine");
                    
                    for( var i=0;i<height;i++){ //showallMines
                        
                        for( var j=0;j<width;j++){
                          
                            if(document.getElementById('cells'+i+'-'+j).classList.contains("flag")){
                               
                                document.getElementById('cells'+i+'-'+j).classList.remove("flag");
                                document.getElementById('cells'+i+'-'+j).innerHTML="x";
                                document.getElementById('cells'+i+'-'+j).style.background="white";
                            }

                            if(minefield[i][j].value=='mines'){
                            
                                minefield[i][j].visibility='notHidden';
                                document.getElementById('cells'+i+'-'+j).classList.add("mine");

                            }  
                        }
                    }

                    gameFinished=true;
                    stopTimer();
                    face.innerHTML="&#128577;";
                    var gameOver =document.createElement('h3');
                    gameOver.setAttribute('id','gameOver');
                    document.body.appendChild(gameOver);
      
                }
                else if(minefield[row][column].value=='emptyCell'){
                    
                    let minesAround=SearchForMinesAround(row,column);

                    minefield[row][column].visibility='notHidden';
                    document.getElementById('cells'+row+'-'+column).classList.add("cellWithoutMines");
                    countEmptyCell++;
                    
                    if(minesAround>0){
                       
                        document.getElementById('cells'+row+'-'+column).innerHTML=minesAround;

                    }
                    else{

                        revealNeighbourCells(row,column)
                    
                    }

                }

                if(countEmptyCell==1 && !gameFinished){
                 
                    if(!isTimerInicializated){
                        
                        startTimer();
                        isTimerInicializated=true;
                    }

                }

                if(countIsNotaMine == countEmptyCell){
                  
                    gameFinished=true;
                    stopTimer();
                    isTimerInicializated=false;
                    face.innerHTML="&#128512;";
                    var win =document.createElement('h3');
                    win.setAttribute('id','win');
                    document.body.appendChild(win);

                }

            } 


    }


    function taggedCell(row,column){
      
        var cell = document.getElementById('cells'+row+'-'+column);
        var Countflags=parseFloat(document.getElementById("Countflags").innerHTML);
        var clicks= parseFloat(minefield[row][column].clicks);
        cell.setAttribute('value','');
        clicks++;
        minefield[row][column].clicks=clicks;
        
        if(!isTimerInicializated){
                        
            startTimer();
            isTimerInicializated=true;

        }
        
        if(clicks==1 && minefield[row][column].visibility=='hidden' && !gameFinished){
           
            cell.classList.add("flag");
            Countflags--;

        }
        else if(clicks==2 && minefield[row][column].visibility=='hidden' && !gameFinished){
           
            cell.classList.remove("flag");
            cell.classList.add("interrogation");
            Countflags++;
            cell.setAttribute('value','interrogation');
        }
        else if(gameFinished==false){
         
            cell.classList.remove("interrogation");
            cell.classList.remove("flag");
            minefield[row][column].clicks=0;
            cell.setAttribute('value','');

        }
        
        document.getElementById("Countflags").innerHTML=Countflags;

    }
    
    function startTimer(){
       
        myInterval = setInterval(myTimer, 1000);
       
        function myTimer() {
            timer++;
            document.getElementById("timer").innerHTML = timer;
        }

    }  

    function stopTimer(){
          
        console.log("timer parado")
        clearInterval(myInterval);
            
    }

            
    function isPositionLegal(row,column){
       
        let isUndefinedMine=false;

        if(row<0){

            return isUndefinedMine = false;

        }
        if(column<0){

            return isUndefinedMine = false;

        }
        if(row>=height){

            return isUndefinedMine = false;

        }
        if(column>=width){

            return isUndefinedMine = false;

        }
        else{

            return isUndefinedMine = true;

        }
    }

    function SearchForMinesAround(row,column){

        let minesAround=0;
        let isUndefinedMine;

            for(let i=row-1;i<=row+1;i++){

                for(let j=column-1;j<=column+1;j++){
 
                    isUndefinedMine = isPositionLegal(i,j)

                    if(isUndefinedMine){
                       
                        if(minefield[i][j].value=='mines'){
                      
                            minesAround++;
                            
                        }
                                   
                    }    
                }
     
            }
            
        return minesAround;

    }

    function revealNeighbourCells(row,column){
        

        for(let i=row-1;i<=row+1;i++){

            for(let j=column-1;j<=column+1;j++){

                if(isPositionLegal(i,j)){
                    
                    if(minefield[i][j].visibility=='hidden'){
                  
                        discoverCell(i,j)
                        
                    }
                       
                }    
            }
 
        }
    }

    function resettingGame(){
       
        stopTimer();
        document.getElementById('face').innerHTML="&#128528;";
        document.getElementById('timer').innerHTML="0";
        document.getElementById('Countflags').innerHTML="10";

        if(getParametersURL()==''){
           
            window.location.reload();
    
        }
        else{
            
            clearTable();
            createTable();

        }

    }

    function clearTable(){

        var table=document.getElementById('panel');

        for( var i=0;i<height;i++){

            var row =document.getElementById('row'+i);

            for( var j=0;j<width;j++){
                
                var cell =document.getElementById('cells'+i+'-'+j);
               
                row.removeChild(cell);
                 
            }

            table.removeChild(row);

        }
    }


   