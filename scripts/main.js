    var minefield;
    var width;
    var height;
    
    window.onload = function(){ 
        
       
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

        for( var i=0;i<height;i++){

            var row =document.createElement('tr');

            for( var j=0;j<width;j++){
                
                var cell =document.createElement('td');
                cell.setAttribute('id','cells'+i+'-'+j);
                cell.onclick = discoverCell.bind(cell,i,j);
                row.appendChild(cell);
                 
            }

            table.appendChild(row);

        }
       
    }

    function discoverCell(row,column){


            if(minefield[row][column].visibility=='hidden'){

                if(minefield[row][column].value=='mines'){
                   
                    document.getElementById('cells'+row+'-'+column).classList.add("mine");
                    
                }
                else if(minefield[row][column].value=='emptyCell'){

                    document.getElementById('cells'+row+'-'+column).classList.add("cellWithoutMines");

                }
            } 
 
    }