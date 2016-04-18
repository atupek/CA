// cellular_autom.pde
// Ann Tupek
// For CS601
// Lecture on Cellular Automats
// 4/28/16

// Cell class
class Cell
{
    boolean filled;
    int numFilledNeighbors;

    Cell()
    {
        filled = false;
        numFilledNeighbors = 0;
    }

    Cell(boolean fillStatus, int numFillNeigh)
    {
        filled = fillStatus;
        numFilledNeighbors = numFillNeigh;
    }
}

boolean run_sim = false;
boolean pause_sim = false;

int lastUpdateTime = 0;
int num_generations = 0;

int width = 400;
int height = 100;


Cell[][] cellArray = new Cell[width][height];


//drawCells
void drawCells()
{

  for(int i = 1; i < width-1; ++i)
    {
        for(int j = 1; j < height-1; ++j)
        {
            if(cellArray[i][j].filled == true)
            {
              fill(255-i*2, 0, j*2);
              rect(0+5*i, 0+5*j, 5, 5);
            }
        }
    }
}

void determineNumNeighbors()
{
    for(int i = 1; i < width-1; ++i)
    {
        for(int j = 1; j < height-1; ++j)
        {
            cellArray[i][j].numFilledNeighbors = 0;
            if(cellArray[i-1][j-1].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i][j-1].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i+1][j-1].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i-1][j].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i+1][j].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i-1][j+1].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i][j+1].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
            if(cellArray[i+1][j+1].filled == true)
            {
                cellArray[i][j].numFilledNeighbors++;
            }
        }
    }
}

//determine filled status of cells
void determineCellStatus()
{
    for(int i = 1; i < width-1; ++i)
    {
        for(int j = 1; j < height-1; ++j)
        {
            if(cellArray[i][j].filled == false && cellArray[i][j].numFilledNeighbors == 3)
            {
                cellArray[i][j].filled = true;
            }
            if(cellArray[i][j].filled == true && (cellArray[i][j].numFilledNeighbors == 0 ||
                cellArray[i][j].numFilledNeighbors == 1 || cellArray[i][j].numFilledNeighbors >= 4))
            {
                cellArray[i][j].filled = false;
            }
        }
    }   
}


//updateCells
void updateCells()
{
    drawCells();
}

void run()
{
    run_sim=true;
    determineNumNeighbors();
    determineCellStatus();
    updateCells();
}

void reset_sim()
{
    run_sim=false;
    num_generations = 0;
    for(int i = 0; i< width; ++i)
    {
        for(int j = 0; j<height; ++j)
        {
          cellArray[i][j].filled = false;
        }
    }
    drawCells();
}

void mouseClicked()
{
    if(cellArray[floor(mouseX/5)][floor(mouseY/5)].filled == true)
    {
        cellArray[floor(mouseX/5)][floor(mouseY/5)].filled = false;
    }
    else
    {
        cellArray[floor(mouseX/5)][floor(mouseY/5)].filled = true;
    }
    drawCells();
}

void pause()
{
    pause_sim = !pause_sim;
    if(pause_sim==true)
    {
        noLoop();
    }
    if(pause_sim==false)
    {
        loop();
    }
}

void simple_oscilators()
{
    reset_sim();
    for(int i = 0; i<4; ++i)
    {
    //toad
    cellArray[3+20*i][5].filled = true;
    cellArray[4+20*i][5].filled = true;
    cellArray[5+20*i][5].filled = true;
    cellArray[4+20*i][6].filled = true;
    cellArray[5+20*i][6].filled = true;
    cellArray[6+20*i][6].filled = true;
    
    //blinker
    cellArray[11+20*i][5].filled = true;
    cellArray[11+20*i][6].filled = true;
    cellArray[11+20*i][7].filled = true;

    //beacon
    cellArray[16+20*i][5].filled = true;
    cellArray[17+20*i][5].filled = true;
    cellArray[16+20*i][6].filled = true;
    cellArray[17+20*i][6].filled = true;
    cellArray[18+20*i][7].filled = true;
    cellArray[19+20*i][7].filled = true;
    cellArray[18+20*i][8].filled = true;
    cellArray[19+20*i][8].filled = true;
    }
    run();
}

void spaceships()
{
    reset_sim();

    //lightweight space ships
    for(int i = 0; i < 8; i++)
    {
        cellArray[10+10*i][4].filled = true;
        cellArray[11+10*i][4].filled = true;
        cellArray[8+10*i][5].filled = true;
        cellArray[9+10*i][5].filled = true;
        cellArray[11+10*i][5].filled = true;
        cellArray[12+10*i][5].filled = true;
        cellArray[8+10*i][6].filled = true;
        cellArray[9+10*i][6].filled = true;
        cellArray[10+10*i][6].filled = true;
        cellArray[11+10*i][6].filled = true;
        cellArray[9+10*i][7].filled = true;
        cellArray[10+10*i][7].filled = true;
    }

    for(int i = 0; i<8; ++i)
    {
        //gliders
        cellArray[5+5*i][10].filled = true;
        cellArray[6+5*i][11].filled = true;
        cellArray[4+5*i][12].filled = true;
        cellArray[5+5*i][12].filled = true;
        cellArray[6+5*i][12].filled = true;
    }
    run();
}

void pulsar()
{
    reset_sim();
    cellArray[15][17].filled = true;
    cellArray[15][18].filled = true;
    cellArray[15][19].filled = true;
    cellArray[15][23].filled = true;
    cellArray[15][24].filled = true;
    cellArray[15][25].filled = true;
    cellArray[17][15].filled = true;
    cellArray[18][15].filled = true;
    cellArray[19][15].filled = true;
    cellArray[17][20].filled = true;
    cellArray[18][20].filled = true;
    cellArray[19][20].filled = true;
    cellArray[17][22].filled = true;
    cellArray[18][22].filled = true;
    cellArray[19][22].filled = true;
    cellArray[17][27].filled = true;
    cellArray[18][27].filled = true;
    cellArray[19][27].filled = true;
    cellArray[20][17].filled = true;
    cellArray[20][18].filled = true;
    cellArray[20][19].filled = true;
    cellArray[20][23].filled = true;
    cellArray[20][24].filled = true;
    cellArray[20][25].filled = true;
    cellArray[22][17].filled = true;
    cellArray[22][18].filled = true;
    cellArray[22][19].filled = true;
    cellArray[22][23].filled = true;
    cellArray[22][24].filled = true;
    cellArray[22][25].filled = true;
    cellArray[23][15].filled = true;
    cellArray[24][15].filled = true;
    cellArray[25][15].filled = true;
    cellArray[23][20].filled = true;
    cellArray[24][20].filled = true;
    cellArray[25][20].filled = true;
    cellArray[23][22].filled = true;
    cellArray[24][22].filled = true;
    cellArray[25][22].filled = true;
    cellArray[23][27].filled = true;
    cellArray[24][27].filled = true;
    cellArray[25][27].filled = true;
    cellArray[27][17].filled = true;
    cellArray[27][18].filled = true;
    cellArray[27][19].filled = true;
    cellArray[27][23].filled = true;
    cellArray[27][24].filled = true;
    cellArray[27][25].filled = true;
    run();
}

void pentadecathlon()
{
    reset_sim();
    cellArray[20][20].filled = true;
    cellArray[19][21].filled = true;
    cellArray[21][21].filled = true;
    cellArray[18][22].filled = true;
    cellArray[22][22].filled = true;
    cellArray[18][23].filled = true;
    cellArray[22][23].filled = true;
    cellArray[18][24].filled = true;
    cellArray[22][24].filled = true;
    cellArray[18][25].filled = true;
    cellArray[22][25].filled = true;
    cellArray[18][26].filled = true;
    cellArray[22][26].filled = true;
    cellArray[18][27].filled = true;
    cellArray[22][27].filled = true;
    cellArray[19][28].filled = true;
    cellArray[21][28].filled = true;
    cellArray[20][29].filled = true;
    run();
}

void gosper_glider_gun()
{
    reset_sim();
    cellArray[1][5].filled = true;
    cellArray[1][6].filled = true;
    cellArray[2][5].filled = true;
    cellArray[2][6].filled = true;
    
    cellArray[11][5].filled = true;
    cellArray[11][6].filled = true;
    cellArray[11][7].filled = true;
    cellArray[12][4].filled = true;
    cellArray[12][8].filled = true;
    cellArray[13][3].filled = true;
    cellArray[13][9].filled = true;
    cellArray[14][3].filled = true;
    cellArray[14][9].filled = true;
    cellArray[15][6].filled = true;
    cellArray[16][4].filled = true;
    cellArray[16][8].filled = true;
    cellArray[17][5].filled = true;
    cellArray[17][6].filled = true;
    cellArray[17][7].filled = true;
    cellArray[18][6].filled = true;
    
    cellArray[21][3].filled = true;
    cellArray[21][4].filled = true;
    cellArray[21][5].filled = true;
    cellArray[22][3].filled = true;
    cellArray[22][4].filled = true;
    cellArray[22][5].filled = true;
    cellArray[23][2].filled = true;
    cellArray[23][6].filled = true;
    cellArray[25][1].filled = true;
    cellArray[25][2].filled = true;
    cellArray[25][6].filled = true;
    cellArray[25][7].filled = true;
    
    cellArray[35][3].filled = true;
    cellArray[35][4].filled = true;
    cellArray[36][3].filled = true;
    cellArray[36][4].filled = true;
    run();
}

void acorn()
{
    reset_sim()
    cellArray[width/4][height/2].filled = true;
    cellArray[width/4+2][height/2+1].filled = true;
    cellArray[width/4-1][height/2+2].filled = true;
    cellArray[width/4][height/2+2].filled = true;
    cellArray[width/4+3][height/2+2].filled = true;
    cellArray[width/4+4][height/2+2].filled = true;
    cellArray[width/4+5][height/2+2].filled = true;
    run();
}

void diehard()
{
    reset_sim()
    cellArray[width/4+3][height/2-1].filled = true;
    cellArray[width/4-3][height/2].filled = true;
    cellArray[width/4-2][height/2].filled = true;
    cellArray[width/4-2][height/2+1].filled = true;
    cellArray[width/4+2][height/2+1].filled = true;
    cellArray[width/4+3][height/2+1].filled = true;
    cellArray[width/4+4][height/2+1].filled = true;
    run();
}

void random_sim()
{
    reset_sim();
    for(int i = 0; i < width; i++)
    {
        for(int j = 0; j<height; j++)

        {
            int rand_num = int(random(10));
            if(rand_num%2==0)
            {
                cellArray[i][j].filled=true;
            }    
        }
    }
    run();
}

void cross()
{
    reset_sim();
    for(int i = 0; i < 10; i++)
    {
        cellArray[width/4+2*i-10][height/2].filled = true;
    }
    for(int i = 0; i < 9; i++; i++)
    {
        cellArray[width/4+2*i-9][height/2-1].filled = true;
        cellArray[width/4+2*i-9][height/2+1].filled = true;
    }
    for(int i = 0; i < 5; i++)
    {
        cellArray[width/4][height/2+2*i].filled = true;
        cellArray[width/4-2][height/2+2*i].filled = true;
    }
    for(int i = 0; i < 6; i++)
    {
        cellArray[width/4-1][height/2+2*i-1].filled = true;
    }
    for(int i = 0; i < 5; i++)
    {
        cellArray[width/4][height/2-2*i].filled = true;
        cellArray[width/4-2][height/2-2*i].filled = true;
    }
    for(int i = 0; i < 5; i++)
    {
        cellArray[width/4-1][height/2-2*i-1].filled = true;
    }
    run();
}

// setup
// Processing.js setup function
void setup()
{
    size(1010, 510);
    background(0, 0, 0);
    
    for(int i = 0; i< width; ++i)
    {
        for(int j = 0; j<height; ++j)
        {
          cellArray[i][j] = new Cell(false, 0);
        }
    }
    
    for(int i = 1; i< width; ++i)
    {
        for(int j = 1; j<height; ++j)
        {
            noStroke();
            rect(0+5*i, 0+5*j, 5, 5);
        }
    }
}

// draw
void draw()
{
	background(255,255,255);

  int m = millis();

  if(run_sim==true)
  {
    if(m>lastUpdateTime+100)
    {
        lastUpdateTime = m;
        determineNumNeighbors();
        determineCellStatus();
        updateCells();
        num_generations++;
    }
    }
    //println("Number of Generations: " + num_generations);
    drawCells();

}
