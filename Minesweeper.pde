import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++)
    {
        for (int j = 0; j < NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i, j);
        }
    }
    for (int i = 0; i < 21; i++)
    {
      setBombs();  
    }
    
}
public void setBombs()
{
    int x = (int)(Math.random()*20);
    int y = (int)(Math.random()*20);
    if (bombs.contains(buttons[y][x]) == false)
    {
        bombs.add(buttons[x][y]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for (int i = 0; i < bombs.size(); i++)
    {
        if (bombs.get(i).isClicked() == true)
        {
            return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    String loseMsg = "YOU SUCK";
    for (int i = 1; i <= loseMsg.length(); i++)
        {
            buttons[10][i].setLabel(loseMsg.substring(i - 1, i));
        }
}
public void displayWinningMessage()
{
    if (isWon() == true)
    {
        String winMsg = "CONGRATS YAH NERD!";
        for (int i = 1; i <= winMsg.length(); i++)
        {
            buttons[10][i].setLabel(winMsg.substring(i - 1, i));
        }
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
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (keyPressed){marked =! marked;}
        else if (bombs.contains(this)){displayLosingMessage();}
        else if (countBombs(r, c) > 0)
        {
            label = Integer.toString(countBombs(r, c));
        }
        else
        {
            if(isValid(r - 1, c) && (buttons[r - 1][c].clicked == false)){buttons[r - 1][c].mousePressed();}
            if(isValid(r - 1, c - 1) && (buttons[r - 1][c - 1].clicked == false)){buttons[r - 1][c - 1].mousePressed();}
            if(isValid(r - 1, c + 1) && (buttons[r - 1][c + 1].clicked == false)){buttons[r - 1][c + 1].mousePressed();}
            if(isValid(r, c - 1) && (buttons[r][c - 1].clicked == false)){buttons[r][c - 1].mousePressed();}
            if(isValid(r, c + 1) && (buttons[r][c + 1].clicked == false)){buttons[r][c + 1].mousePressed();}
            if(isValid(r + 1, c - 1) && (buttons[r + 1][c - 1].clicked == false)){buttons[r + 1][c - 1].mousePressed();}
            if(isValid(r + 1, c) && (buttons[r + 1][c].clicked == false)){buttons[r + 1][c].mousePressed();}
            if(isValid(r + 1, c + 1) && (buttons[r + 1][c + 1].clicked == false)){buttons[r + 1][c + 1].mousePressed();}
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
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r < 20 && c < 20 && r >= 0 && c >= 0)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(r - 1, c) && bombs.contains(buttons[r - 1][c])) {numBombs+=1;}
        if (isValid(r - 1, c - 1) && bombs.contains(buttons[r - 1][c - 1])) {numBombs+=1;}
        if (isValid(r - 1, c + 1) && bombs.contains(buttons[r - 1][c + 1])) {numBombs+=1;}
        if (isValid(r, c - 1) && bombs.contains(buttons[r][c - 1])) {numBombs+=1;}
        if (isValid(r, c + 1) && bombs.contains(buttons[r][c + 1])) {numBombs+=1;}
        if (isValid(r + 1, c - 1) && bombs.contains(buttons[r + 1][c - 1])) {numBombs+=1;}
        if (isValid(r + 1, c) && bombs.contains(buttons[r + 1][c])) {numBombs+=1;}
        if (isValid(r + 1, c + 1) && bombs.contains(buttons[r + 1][c + 1])) {numBombs+=1;}
        return numBombs;
    }
}