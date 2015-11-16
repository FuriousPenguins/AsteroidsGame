//Global Variables
int screenX = 1000;
int screenY = 500;

USS_Enterprise USS_EnterpriseD;
Asteroids Asteroid1;
Star[] stars;
Asteroids[] asteroids;

public void setup() 
{
  size(screenX,screenY);
  //Create Spaceship
  USS_EnterpriseD = new USS_Enterprise();
  //======================
  //Create Stars
  stars = new Star[150];
  for(int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  asteroids = new Asteroids[10];
  for(int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroids();
  }
  //======================
  //Create Asteroids
  Asteroid1 = new Asteroids();
  //======================
}

public void draw() 
{
  ellipse(screenX/2,screenY/2,30,30);
  //Fade Background
  pushMatrix();
  fill(0,0,0,50);
  rect(-1,-1,screenX+1,screenY+1);
  popMatrix();
  //=================
  //Stars
  for(int i = 0; i < stars.length; i++) {
    stars[i].show();
  }
  //=================
  // Asteroid
  for(int i = 0; i < asteroids.length; i++) {
    asteroids[i].move();
    asteroids[i].show();
  }
  Asteroid1.move();
  Asteroid1.show();
  //================
  //Starship
  USS_EnterpriseD.move();
  USS_EnterpriseD.show();
  //=================
  //Collision Check
  float distance = sqrt( sq(USS_EnterpriseD.getX() - Asteroid1.getX()) + sq(USS_EnterpriseD.getY() - Asteroid1.getY()) );
  if (distance < 30) {
    println(distance);
  }
  //=================
}

public void keyPressed() {
  if (key == CODED) {
    //LEFT
    if (keyCode == LEFT) {
      USS_EnterpriseD.setLeft(true);
    }
    
    //RIGHT
    if (keyCode == RIGHT) {
      USS_EnterpriseD.setRight(true);
    }
    
    //UP
    if (keyCode == UP) {
      USS_EnterpriseD.setForward(true);
    }
    
    //DOWN
    if (keyCode == DOWN) {
      USS_EnterpriseD.setBackward(true);
    }
  }
  if(key == 'h') {
    USS_EnterpriseD.setX( (int)(Math.random()*(screenX+1)) );
    USS_EnterpriseD.setY( (int)(Math.random()*(screenX+1)) );
  }
}

public void keyReleased() {
  if (key == CODED) {
    //LEFT
    if (keyCode == LEFT) {
      USS_EnterpriseD.setLeft(false);
    }
    
    //RIGHT
    if (keyCode == RIGHT) {
      USS_EnterpriseD.setRight(false);
    }
    
    //UP
    if (keyCode == UP) {
      USS_EnterpriseD.setForward(false);
    }
    
    //DOWN
    if (keyCode == DOWN) {
      USS_EnterpriseD.setBackward(false);
    }
  }
}

class USS_Enterprise extends Floater  
{
  // Declare and/or Initialize Corner Variables
  private int[] coordinates = {2,-2, 3,-5, 6,-9, 8,-10, 13,-10, 13,-9, 17,-5, 18,-2, 18,2, 17,5, 13,9, 13,10, 8,10, 6,9, 3,5, 2,2, 2,-2, 
                       -1,-3, -4,-7, 2,-7, 3,-8, 3,-10, 2,-11, -10,-11, -11,-10, -11,-8, -10,-7, -7,-7,
                       -7,7, -10,7, -11,8, -11,10, -10,11, 2,11, 3,10, 3,8, 2,7, -4,7, -1,3, 2,2};
  private int count = 0;
  //==============================================
  //Declare and/or Initialize SpaceShip Variables
  private boolean turnLeft = false;
  private boolean turnRight = false;
  private boolean forward = false;
  private boolean backward = false;

  //==============================================
  
  public USS_Enterprise() {
    // Create Corners
    corners = coordinates.length/2;
    xCorners = new float[corners];
    yCorners = new float[corners];
    
    int cornerElement = -1;
    while(count < coordinates.length) {
      if(count % 2 == 0) {
        cornerElement++;
        xCorners[cornerElement] = coordinates[count]*3/2;
      }
      else {
        yCorners[cornerElement] = coordinates[count]*3/2;
      }
    count++;
    }
    //==========================
    // Initialize SpaceShip Variables
    myFill = color(#75A3A3);//#8291B0
    myStroke = color(#87CEFA);
    myStrokeWeight = 1.6;
    myCenterX = 250;
    myCenterY = 250;
    //===============================
  }
  //Encapsulation
  public void setX(int x) { myCenterX = x; }
  public float getX() { return (float)myCenterX; }   
  public void setY(int y) { myCenterY = y; }
  public float getY() { return (float)myCenterY; }
  public void setDirectionX(double x) { myDirectionX = x; }
  public double getDirectionX() { return myDirectionX; }
  public void setDirectionY(double y) { myDirectionY = y; }
  public double getDirectionY() { return myDirectionY; }
  public void setPointDirection(double degrees) { myPointDirection = degrees; }
  public double getPointDirection() { return myPointDirection; }

  public void setLeft(boolean x) { turnLeft = x; }
  public void setRight(boolean x) { turnRight = x; }
  public void setForward(boolean x) { forward = x; }
  public void setBackward(boolean x) { backward = x; }
  //===========================

  public void move () 
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY    
    if(turnLeft == true) {
      rotate(-3);
    }
    if(turnRight == true) {
      rotate(3);
    }
    if(forward == true) {
      accelerate(.05);
    }   
    if(backward == true) {
      accelerate(-.05);
    }
    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY; 
  }

  //Starship Impulse speed
  // public void accelerateImpulse() {
  //     float previousX = (float)myCenterX;
  //     float previousY = (float)myCenterY;
  //     accelerate(0.1);
  //     float currentX = (float)myCenterX;
  //     float currentY = (float)myCenterY;

  //     pushMatrix();
  //     strokeWeight(3);
  //     stroke(255);
  //     line(previousX,previousY,currentX,currentY);
  //     popMatrix();
  //   }
  //========================

}

class Asteroids extends Floater {

  // Declare and/or Initialize Corner Variables
  private int[] coordinates = { 5,5, 5,-5, -5,-5, -5,5 };
  private int count;
  //==============================================
  //Declare and/or Initialize Asteroids Variables
  private int rotation;
  //==============================================

  public Asteroids() {
    myFill = color(255);
    // Create Corners
    corners = coordinates.length/2;
    xCorners = new float[corners];
    yCorners = new float[corners];
    
    int cornerElement = -1;
    while(count < coordinates.length) {
      if(count % 2 == 0) {
        cornerElement++;
        xCorners[cornerElement] = coordinates[count]*3;
      }
      else {
        yCorners[cornerElement] = coordinates[count]*3;
      }
    count++;
    }
    //==========================
    //Set velocity of Asteroid
    int randomDirection = (int)(Math.random()*4+1);

    int randomX = (int)(Math.random()*2+2); //Random velocity in the X direction
    int randomY = (int)(Math.random()*2+2); //Random velocity in the Y direction

    if (randomDirection == 1) { //Use Quadrants in Math, ex. Quadrant 1,2,3,4
      myDirectionX = randomX;
      myDirectionY = randomY;
    }
    else if(randomDirection == 2) {
      myDirectionX = -randomX;
      myDirectionY = randomY;
    }
    else if(randomDirection == 3) {
      myDirectionX = -randomX;
      myDirectionY = -randomY;
    }
    else if(randomDirection == 4) {
      myDirectionX = randomX;
      myDirectionY = -randomY;
    }


    //==========================
    rotation = (int)(Math.random()*11-5);

    myCenterX = (int)(Math.random()*501+500);;
    myCenterY = (int)(Math.random()*screenY+1);

    myStrokeWeight = 5;
    myFill = #778572;
    myStroke = #638756;
  }

  public void move() {
    rotate(rotation);
    super.move();
  }
  //Encapsulation
  public void setX(int x) { myCenterX = x; }
  public float getX() { return (float)myCenterX; }   
  public void setY(int y) { myCenterY = y; }
  public float getY() { return (float)myCenterY; }
  public void setDirectionX(double x) { myDirectionX = x; }
  public double getDirectionX() { return myDirectionX; }
  public void setDirectionY(double y) { myDirectionY = y; }
  public double getDirectionY() { return myDirectionY; }
  public void setPointDirection(double degrees) { myPointDirection = degrees; }
  public double getPointDirection() { return myPointDirection; }
  //===========================
}

class Star {
  private int x,y; //Coordinates : Location
  private int sizeX,sizeY; //ellipse width; //ellipse height
  private int red,green,blue; //Color
  Star() {
    x = (int)(Math.random()*(screenX + 1));
    y = (int)(Math.random()*(screenY + 1));
    sizeX = (int)(Math.random()*6+4);
    sizeY = (int)(Math.random()*6+4);
    red = (int)(Math.random()*256);
    green = (int)(Math.random()*256);
    blue = (int)(Math.random()*256);
  }

  public void show() {
    stroke(0);
    fill(red,green,blue);
    ellipse(x,y,sizeX,sizeY);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected float[] xCorners;   
  protected float[] yCorners;   
  protected int myFill;
  protected float myStrokeWeight;
  protected int myStroke;
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);
  abstract public float getX();   
  abstract public void setY(int y);   
  abstract public float getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(double degrees);   
  abstract public double getPointDirection();

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)
  {
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myFill);   
    strokeWeight(myStrokeWeight);
    stroke(myStroke);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();      
 
    for(int nI = 0; nI < corners; nI++)    
    {
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }
    endShape(CLOSE);
  }
} 