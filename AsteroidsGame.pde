USS_Enterprise USS_EnterpriseD;

public void setup() 
{
  size(500,500);
  stroke(0);
  strokeWeight(2);
  USS_EnterpriseD = new USS_Enterprise();
}

public void draw() 
{
  pushMatrix();
  fill(0,0,0,10);
  rect(-1,-1,501,501);
  popMatrix();
  USS_EnterpriseD.show();
  USS_EnterpriseD.move();
  //your code here
}

public void keyPressed() {
  if (key == CODED) {
    
    //LEFT
    if (keyCode == LEFT) {
      USS_EnterpriseD.rotate(-15);
    }
    
    //RIGHT
    if (keyCode == RIGHT) {
      USS_EnterpriseD.rotate(15);
    }
    
    //UP
    if (keyCode == UP) {
      USS_EnterpriseD.accelerate(0.1);
    }
    
    //DOWN
    if (keyCode == DOWN) {
      USS_EnterpriseD.accelerate(-0.1);
    }
  }
}

class USS_Enterprise extends Floater  
{
  // Declare and/or Initialize Corner Variables
  int[] coordinates = {2,-2, 3,-5, 6,-9, 8,-10, 13,-10, 13,-9, 17,-5, 18,-2, 18,2, 17,5, 13,9, 13,10, 8,10, 6,9, 3,5, 2,2, 2,-2, 
                       -1,-3, -4,-7, 2,-7, 3,-8, 3,-10, 2,-11, -10,-11, -11,-10, -11,-8, -10,-7, -7,-7,
                       -7,7, -10,7, -11,8, -11,10, -10,11, 2,11, 3,10, 3,8, 2,7, -4,7, -1,3, 2,2};
  int count = 0;
  //==============================================
  //Declare and/or Initialize SpaceShip Variables
  
  
  
  USS_Enterprise() {
    // Create Corners
    corners = coordinates.length/2;
    xCorners = new float[corners];
    yCorners = new float[corners];
    
    int cornerElement = -1;
    while(count < coordinates.length) {
      if(count % 2 == 0) {
        cornerElement++;
        xCorners[cornerElement] = coordinates[count]*3/2;
        println(cornerElement);
        println(coordinates[count]);
      }
      else {
        yCorners[cornerElement] = coordinates[count]*3/2;
        println(cornerElement);
        println(coordinates[count]);
      }
    count++;
    }
    //==========================
    // Initialize SpaceShip Variables
    myColor = color(#75A3A3);//#8291B0
    myCenterX = 250;
    myCenterY = 250;
    //===============================
  }
  
  //Encapsulation
  public void setX(int x) { myCenterX = x; }
  public int getX() { return (int)myCenterX; }   
  public void setY(int y) { myCenterY = y; }
  public int getY() { return (int)myCenterY; }
  public void setDirectionX(double x) { myDirectionX = x; }
  public double getDirectionX() { return myDirectionX; }
  public void setDirectionY(double y) { myDirectionY = y; }
  public double getDirectionY() { return myDirectionY; }
  public void setPointDirection(double degrees) { myPointDirection = degrees; }
  public double getPointDirection() { return myPointDirection; }
  //===========================
  
  //Change SuperClass Actions

}

class Star {
  int x, y;
  
  Star() {
    
  }
  
  
  
  
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected float[] xCorners;   
  protected float[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
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
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();      
    stroke(#87CEFA);
    strokeWeight(1.6);   
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