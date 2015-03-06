import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList();
boolean response = false;
boolean gameOver = false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i<NUM_ROWS; i++) 
    {
        for(int z = 0; z<NUM_COLS; z++) 
        {
            buttons[i][z] = new MSButton(i, z);
        }
    }
    for(int i = 0; i<=40; i++){setBombs();}
}
public void setBombs()
{
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][col])) 
    {
        bombs.add(buttons[row][col]);
    }
}

public void draw ()
{
    if(gameOver == false) 
    {
        if(isWon()) 
        {
            background( 0 );
            displayWinningMessage();
            gameOver = true;
        }
    }
}
public boolean isWon()
{
    for(int z =0; z<NUM_ROWS; z++) 
    {
        for(int x = 0; x<NUM_COLS; x++) 
        {
            if(!bombs.contains(buttons[z][x]) && buttons[z][x].isClicked()) 
            {
                if(z==NUM_ROWS-1 && x ==NUM_COLS-1) {return true;}
            }
        }
    }
    return false;
}
public void displayLosingMessage()
{
    String loseMsg = "YOU SUCK YAH NERD!";
    for(int i = 1; i<=18; i++) 
    {
        buttons[10][2+i].setLabel(loseMsg.substring(i-1,i));
    }
}
public void displayWinningMessage()
{    
    String winMsg = "CONGRATS YAH NERD!";
    for(int i =1; i<=18; i++) 
    {
        buttons[10][2+i].setLabel(winMsg.substring(i-1,i));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed) 
        {
            marked = !marked;
        }
        else if(bombs.contains(this)) 
        {
            displayLosingMessage();
            gameOver = true;
        }
        else if(this.countBombs(r,c)>0) 
        {label = countBombs(r,c)+"";}
        else 
        {
            if((isValid(r-1,c-1)) && (buttons[r-1][c-1].clicked == false)) {buttons[r-1][c-1].mousePressed();}
            if((isValid(r,c-1)) && (buttons[r][c-1].clicked == false)) {buttons[r][c-1].mousePressed();}
            if((isValid(r+1,c-1)) && (buttons[r+1][c-1].clicked == false)) {buttons[r+1][c-1].mousePressed();}
            if((isValid(r-1,c)) && (buttons[r-1][c].clicked == false)) {buttons[r-1][c].mousePressed();}
            if((isValid(r+1,c)) && (buttons[r+1][c].clicked == false)) {buttons[r+1][c].mousePressed();}
            if((isValid(r-1,c+1)) && (buttons[r-1][c+1].clicked == false)) {buttons[r-1][c+1].mousePressed();}
            if((isValid(r,c+1)) && (buttons[r][c+1].clicked == false)) {buttons[r][c+1].mousePressed();}
            if((isValid(r+1,c+1)) && (buttons[r+1][c+1].clicked == false)) {buttons[r+1][c+1].mousePressed();}
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel){label = newLabel;}

    public boolean isValid(int r, int c)
    {
        return ((r<20 && c<20) && (r>=0 && c>=0));
    }

    public int countBombs(int r, int c)
    {
        int numBombs = 0;
        if(isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1])) {numBombs++;}
        if(isValid(r-1,c) && bombs.contains(buttons[r-1][c])) {numBombs++;}
        if(isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1])) {numBombs++;}
        if(isValid(r,c-1) && bombs.contains(buttons[r][c-1])) {numBombs++;}
        if(isValid(r,c+1) && bombs.contains(buttons[r][c+1])) {numBombs++;}
        if(isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1])) {numBombs++;}
        if(isValid(r+1,c) && bombs.contains(buttons[r+1][c])) {numBombs++;}
        if(isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1])) {numBombs++;}
        return numBombs;
    }
}
