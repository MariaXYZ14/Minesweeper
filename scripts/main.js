    var minefield;
    var width;
    var height;
    let countEmptyCell=0;
    let countIsNotaMine=0;
    var gameFinished=false;
    let timer=0;
    let myInterval;

    window.onload = function(){ 
        
    document.getElementById('game').oncontextmenu=function(event){event.preventDefault();}  
    var mockData=getParametersURL();

    if(mockData==''){

        //generateRandomMines();

    }
    else{


        generateMinesForMockData(mockData);

    }
    
    createTable();

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
        
        console.log(minefield);
    
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

    function createTable(){

        var table=document.getElementById('panel');

        for( var i=0;i<height;i++){

            var row =document.createElement('tr');

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
                    
                    for( var i=0;i<height;i++){
                        
                        for( var j=0;j<width;j++){
                          
                            if(minefield[i][j].value=='mines'){
                                minefield[i][j].visibility='notHidden';
                               
                                document.getElementById('cells'+i+'-'+j).classList.remove("flag");
                                document.getElementById('cells'+i+'-'+j).classList.remove("interrogation");
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

                }

                if(countEmptyCell==1 && !gameFinished){
                 
                    startTimer();

                }

                if(countIsNotaMine == countEmptyCell){
                  
                    gameFinished=true;
                    stopTimer();
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
        if(row>3){

            return isUndefinedMine = false;

        }
        if(column>3){

            return isUndefinedMine = false;

        }
        else{

            return isUndefinedMine = true;

        }
    }


    function SearchForMinesAround(row,column){

        let minesAround=0;
        let isUndefinedMine;

            for(let i=row-1;i<3;i++){

                for(let j=column-1;j<3;j++){
 
                    isUndefinedMine = isPositionLegal(i,j)

                    if(isUndefinedMine && minefield[i][j].value=='mines'){
                        
                        minesAround++;
        
                    }    
                }
     
            }
            
        return minesAround;

    }

        

    

   