 var minefield;
 var width;
 var height;
 
window.onload = function(){ 
    
    //let button= getButtons('cell1-1');

   // button.onclick; 
  
  
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

 /*function getButtons(buttonName){

    let button;

    button = document.getElementById(buttonName);

    return button;

}*/

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
     
            if(mockData[i][j]=='x'){
              
                minefield[i][j] = {
              
                    value: 'mines',
                    visibility: 'hidden',
                    tag: 'none'
                };

            }
            else{
               
                minefield[i][j] = {
              
                    value: 'emptyCell',
                    visibility: 'hidden',
                    tag: 'none'
                };

            }

        }

    }

}

function createTable(){


    var table=document.getElementById('panel');

    console.log(width,height);

    for( var i=0;i<height;i++){

        var row =document.createElement('tr');

        for( var j=0;j<width;j++){
            
            var cell =document.createElement('td');
            cell.setAttribute('id','cell'+i+'-'+j);
            row.appendChild(cell);

        }

        table.appendChild(row);

    }

}

function discoverCell(row,column){

        row=1;
        column=1;
        
        if(!(minefield[row][column].visibility=='hidden')){

            minefield[row][column]
        } 
    
        
    
}