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



class Predator extends Boid { //Predators are just boids with some extra characteristics.
  float maxForce = MAX_PRED_FORCE; //Predators are better at steering.
  Predator(PVector location) {
    super(location);
    mass = int(random(SMALLEST_PRED_MASS, LARGEST_PRED_MASS)); //Predators are bigger and have more mas
    int culLower = int(random(0, 200));
    c = color(255-culLower, 255-culLower,0); // set random shade of yellow
  }

  void display() {
    update();
   
     fill(c);
    stroke(c);
     rect(loc.x, loc.y, mass*2, mass*2, 10); //they are rectangles. More Mass, larger the shape
    stroke(0);
  
  }

  void update() { //Same as for boid, but with different vel.limit().
    //Calculate the next position of the boid.
    vel.add(acc);
    loc.add(vel);
    acc.mult(0); //Reset acc every time update() is called.
    vel.limit(BOID_VELOCITY_LIMIT); //Arbitrary limit on speed,
    //Make canvas doughnut-shaped.
    if (loc.x<=0) {
      loc.x = width;
    }
    if (loc.x>width) {
      loc.x = 0;
    }
    if (loc.y<=0) {
      loc.y = height;
    }
    if (loc.y>height) {
      loc.y = 0;
    }
  }

  void approachForce(ArrayList<Boid> boids) { //Same as for boid, but with bigger approachRadius.
    float count = 0;
    PVector locSum = new PVector();

    for (Boid other: boids) {

      int approachRadius = mass + (approchForce * 5);
      PVector dist = PVector.sub(other.getLoc(), loc);
      float d = dist.mag();

      if (d != 0 && d<approachRadius) {
        PVector otherLoc = other.getLoc();
        locSum.add(otherLoc);
        count ++;
      }
    }
    if (count>0) {
      locSum.div(count);
      PVector approachVec = PVector.sub(locSum, loc);
      approachVec.limit(maxForce);
      applyF(approachVec);
    }
  }
}
