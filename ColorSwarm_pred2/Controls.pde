import controlP5.*; // library for onscreen user interface controlls

ControlP5 cp5;//User controls for the program

//int lastUSerInteractionTime = 0; // will be used to hold the time since the last user interaction
int addBoidTime = 0; 

boolean artMode = true;

int lastUSerInteractionTime = 0; // will be used to hold the time since the last user interaction

final int OUR_FRAME_RATE = 60; // our number of frames per second.
final int TIME_TO_RESET = OUR_FRAME_RATE * 1200; // larger the number, the longer the simulation goes until it resets. 

//set information for the on screen user controls
int controls_height = 0;
int controls_width = 0; 

Slider avoidSlider, approchSlider, alignSlider;

void checkForBoidCreate() // see if enough time has passed before adding new boids
{                         // will pick two at randome and mix the colors together to make a new color
  if ( (frameCount-addBoidTime) >= HOW_MANY_FRAMES_BEFORE_ADD_CHILD )
  {
     if(swarm1.BOIDCount() >= MAX_BOIDS_THAT_CAN_BE_ADDED )
        swarm1.removeRandomBoid(5);
        
        
    for(int i=0; i < 5; i++)
    {
      Boid p1 = swarm1.getBoid( (int) random(swarm1.BOIDCount()-1) ); 
      Boid p2 = swarm1.getBoid( (int) random(swarm1.BOIDCount()-1) ); 
      
      if(p1 != null & p2 != null)
      {
        color p1C = p1.getColor();
        color p2C = p2.getColor();
        swarm1.addBoidRandomWithColor( p1C + p2C);
      }
    }
    
    addBoidTime = frameCount; 
  }
}

void drawInterfaceBackground()
{
  fill(0, 100); // semi-transparent grey
  stroke(255);

  //bottom controls
  rect(10, height-controls_height, controls_width-35, controls_height-1);
}

void mousePressed()
{
  checkForAddBOID();
}

void checkForAddBOID()
{
  //Check for mouse click and add boid at clicked location
  if (mousePressed 
    && isMouseClickWithinterface() == false
    )
  {
   
    if(swarm1.BOIDCount() >= MAX_BOIDS_THAT_CAN_BE_ADDED )
        swarm1.removeRandomBoid(5);
      
    //only add if mouse click did not come from within the controls portion of the screen
    swarm1.addBoidAtLocation(mouseX, mouseY); 
    markUserInteractTime();
  }
}

boolean isMouseClickWithinterface()
{
  if (mouseX > 10 && mouseX < 10 + ((controls_width)) && 
    mouseY > (height-controls_height) && 
    mouseY < ((height-controls_height) + controls_height-1)) return true;
  else return false;
}

//used to reset the system after a period of no interaction from the user
void checkForSwarmReset()
{

  if ( (frameCount-lastUSerInteractionTime) >= TIME_TO_RESET)
  {
    resetSystem();
  }
}

void resetSystem()
{
     markUserInteractTime();
    resetSwarm();
    resetSwarmControls();

    fill( color(167) ); // fill background with gray to indicate a reset
    stroke(0);
    rect(0, 0, width, height);
  
}

//resets basic control varibales for the swarm back to standard values
//that result in nice flockng patterns
void resetSwarmControls()
{
  avoidSlider.setValue(avoidForce);
  approchSlider.setValue(approchForce);
  alignSlider.setValue(alignForce);
}



void setUpUserInterface()
{
  addBoidTime = frameCount; 
  int controls_top_x = 10;
  int controls_top_y = height-controls_height;

  cp5 = new ControlP5(this); 

  PFont pfont = createFont("Arial", 20, true); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont);
  
  PFont pfont2 = createFont("Arial", 30, true); // use true/false for smooth/no-smooth
  ControlFont font2 = new ControlFont(pfont2);


int txtTop = 200;
int gap = 50;
         
              
            //LABELS ABOVE CONTROLS
           cp5.addTextlabel("label")
                    .setText("Play with contols below to change how BOIDS react to each other")
                    .setPosition(width / 2 - 450,controls_top_y + 10)
                    .setFont(font2)
                       .setColor(#B76D18)
                    ;
                    
int xAlignControls = 120;
int yAlignControls = 50;

  //set up sliders for forces
  avoidSlider = cp5.addSlider("Avoid_Force")
    .setPosition(controls_top_x+xAlignControls, controls_top_y+50+ yAlignControls )
    .setSize(300, 40)
    .setRange(0, avoidForce + 100)
    .setValue(avoidForce)
    .setFont(font)
    .setLabel("How much BOIDS try to avoid eachother");
  ;


  approchSlider = cp5.addSlider("Approch_Force")
    .setPosition(controls_top_x+xAlignControls, controls_top_y+120+ yAlignControls )
    .setSize(300, 40)
    .setRange(0, approchForce + 100)
    .setValue(approchForce)
    .setFont(font)
    .setLabel("How much BOIDS try to aproach eachother");
  ;

  alignSlider = cp5.addSlider("Align_Force")
    .setPosition(controls_top_x+xAlignControls, controls_top_y+190+ yAlignControls )
    .setSize(300, 40)
    .setRange(0, alignForce + 100)
    .setValue(alignForce)
    .setFont(font)
    .setLabel("How much BOIDS try to align with eachother");
  ;

  

  cp5.addButton("openCode_Button")
    .setPosition(controls_top_x+xAlignControls, controls_top_y+240+ yAlignControls )
    .setSize(400, 40)
    .setFont(font)
    .setLabel("Go to code");
  ;
  

  cp5.addButton("reset_Button")
    .setPosition(controls_top_x+420+(xAlignControls), controls_top_y+240+ yAlignControls )
    .setSize(400, 40)
    .setFont(font)
    .setLabel("Reset");
  ;
  
   // create a toggle and change the default look to a (on/off) switch look
  cp5.addToggle("Art_Mode")
     .setPosition(controls_top_x+860+(xAlignControls), controls_top_y+50+ yAlignControls )
     .setSize(200,40)
     .setValue(true)
     .setFont(font)
     .setLabel("Art Mode (On/Off)")
     //.setMode(ControlP5.SWITCH)
     ;
}

void reset_Button(float value) { 
   resetSystem();
}


void Avoid_Force(float value) {   
  if (value > 0 && isMouseClickWithinterface()) {
    avoidForce = (int)value;
  }   
  markUserInteractTime();
}
void Approch_Force(float value) { 
  if (value > 0 && isMouseClickWithinterface()) { 
    approchForce = (int)value;
  }  
  markUserInteractTime();
}
void Align_Force(float value) { 
  if (value > 0 && isMouseClickWithinterface()) { 
    alignForce = (int)value;
  }  
  markUserInteractTime();
}



//called when a value changes on the background clear knob
void Background_Clear(int value)
{
  if (isMouseClickWithinterface())
  {
    background_clear_value = value;
    markUserInteractTime();
  }
}

void markUserInteractTime()
{
  lastUSerInteractionTime = frameCount;
}

void openCode_Button(int theValue)
{
  exit();
}

void Art_Mode(boolean theFlag) {
  artMode = theFlag;
}
