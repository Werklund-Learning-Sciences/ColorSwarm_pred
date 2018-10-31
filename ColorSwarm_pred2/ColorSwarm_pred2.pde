// /\
// ||        +-----------------------------------+
//  +========|Press the Play button above to run |
//           |the program after you make changes |
//           +-----------------------------------+
//
// Play around with the code and make changes.
//
//A flocking simulation based on Daniel Shiffman's chapter 
//about steering forces in 'The nature of code'.
//Set up of program done by jordan kidney (jordan.kidney@gmail.com)

Swarm swarm1; // main controler for all boids and predators

//constats for how many creatues to create at the start of the
//simulation
final int START_NUMBER_OF_BOIDS = 100;
final int START_NUMBER_OF_PREDATORS = 15;

//constants for add type on tap
final int ADD_BOID = 0;
final int MAX_BOIDS_THAT_CAN_BE_ADDED = 200;

int backGroundColor = 255; //can be a value between 0 and 255
int background_clear_value = 1;// can be values between 1 to 255

// higher the value the more the backlground 
//is cleared

//forces that change how BOIDs react
int  avoidForce; // how much they try to avoid eachother
int approchForce; // how much they move towards`
int alignForce; // how much the follow the same direction
int repelForce_boid; //how repeled boids are by predators
int repelForce_pred; //how repeled predators are by other predators



//Constants for the boids
final int BOID_VELOCITY_LIMIT = 5;
final int PRED_VELOCITY_LIMIT = 8;
final int BOID_SHAPE = 0;// 0 will be a triangle, any other number will be a circle
final int MAX_BOID_FORCE = 6;
final int MAX_PRED_FORCE = 10;

final int SMALLEST_BOID_MASS = 5; 
final int LARGEST_BOID_MASS = 20; 

final int SMALLEST_PRED_MASS = 20; 
final int LARGEST_PRED_MASS = 25; 

final int HOW_MANY_FRAMES_BEFORE_ADD_CHILD = 300; //smaller number means they are added faster

void resetSwarm()
{
  swarm1 = new Swarm(START_NUMBER_OF_BOIDS, START_NUMBER_OF_PREDATORS);
  avoidForce = 20; // how much they try to avoid eachother
  approchForce = 40; // how much they move towards
  alignForce = 60; // how much the follow the same direction
  repelForce_boid = 70; //how repeled boids are by predators
  repelForce_pred = 30; //how repeled predators are by other predators
}

void setup() 
{
  background(backGroundColor);
  frameRate(OUR_FRAME_RATE);
  resetSwarm();
 
 
  fullScreen();
  controls_height = height/4;
  controls_width = width; 
  setUpUserInterface();
  
}

void draw() 
{ 
  //background fade
    if(artMode) 
    {
       fill(backGroundColor, background_clear_value); // semi-transparent black background
    }
    else
    {
        fill(backGroundColor);
    }
    
  stroke(0);
  rect(0, 0, width, height);
  
  if(artMode) filter(ERODE);
 
  checkForAddBOID();
  checkForBoidCreate();

  //update all boids and predators to move
  swarm1.update();
  drawInterfaceBackground();
}
