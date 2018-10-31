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

class Swarm
{
  private ArrayList<Boid> boids = new ArrayList<Boid>(); //To store all boids in.
  private ArrayList<Predator> preds = new ArrayList<Predator>(); //To store all predators in.

  private boolean flocking = true; //Toggle flocking.
  private boolean predBool = true; //toggle avoid predator

public Swarm(int number_of_boids, int number_of_pred)
{

  if(number_of_boids <= 0) number_of_boids = 20;
  if(number_of_pred <= 0) number_of_pred = 2;
  
  for (int i=0; i<number_of_boids; i++)//Make boidNum boids.
      boids.add(new Boid(new PVector(random(0, width), random(0, height))));
      
  for (int i=0; i<number_of_pred; i++)//Make boidNum boids.
      preds.add(new Predator(new PVector(random(0, width), random(0, height))));
}
//-------------------------------------------------------------------------------------------------
public void addBoidAtLocation(int x, int y)
{
   if(x < 0) x = 0;
   if(y < 0) y = 0;
   
    boids.add(new Boid(new PVector(x, y)));  
}

//-------------------------------------------------------------------------------------------------
public void addPredAtLocation(int x, int y)
{
   if(x < 0) x = 0;
   if(y < 0) y = 0;
   
    preds.add(new Predator(new PVector(x, y)));  
}
//-------------------------------------------------------------------------------------------------
 public void addBoidRandomWithColor(color c)
   {
    

      boids.add(new Boid(new PVector(random(0, width), random(0, height)), c));
   }
   
 //-------------------------------------------------------------------------------------------------
 public void addPredRandom()
  {
     preds.add(new Predator(new PVector(random(0, width), random(0, height))));
   }
//-------------------------------------------------------------------------------------------------

public void addPredatorAtLocation(int x, int y)
{
   if(x < 0) x = 0;
   if(y < 0) y = 0;
   
    preds.add(new Predator(new PVector(x, y)));  
}

//-------------------------------------------------------------------------------------------------
public int BOIDCount() { return preds.size() + boids.size(); }

public void toggleFlockBoids() { flocking = !flocking;    }
public void toggleAvoidPredator() { predBool = !predBool; }

//-------------------------------------------------------------------------------------------------
public void update()
{
 updateBoids(); 
 updatePredators(); 
}
//-------------------------------------------------------------------------------------------------
public Boid getBoid(int i) 
{ 
if(i < boids.size() && i >= 0)
   return boids.get(i); 
else
   return null;
}
  
//-------------------------------------------------------------------------------------------------
  public void removeRandomBoid(int num)
  {
    for(int i =0; i < num; i++)
    {
      int index = (int) random(0, boids.size());
      boids.remove(index);
    }
  }
  //-------------------------------------------------------------------------------------------------
  public void removeRandomPred(int num)
  {
    for(int i =0; i < num; i++)
    {
      int index = (int) random(0, preds.size());
      preds.remove(index);
    }
  }
  
//-------------------------------------------------------------------------------------------------
public void updateBoids()
{
   for (Boid boid: boids) { //Cycle through all the boids and to the following for each:
    
    if (predBool) { //Flee from each predator.
      for (Predator pred: preds) { 
        PVector predBoid = pred.getLoc();
        boid.repelForce(predBoid, repelForce_boid);
      }
    }
    
    
    if (flocking) { //Execute flocking rules.
      boid.flockForce(boids);
    }
    
    boid.display(); //Draw to screen.
    
  }
  
}

//-------------------------------------------------------------------------------------------------
public void updatePredators()
{
   for (Predator pred: preds) {
    //Predators use the same flocking behaviour as boids, but they use it to chase rather than flock.
    if (flocking) { 
      pred.flockForce(boids);
      for (Predator otherpred: preds){ //Predators should not run into other predators.
        if (otherpred.getLoc() != pred.getLoc()){
          pred.repelForce(otherpred.getLoc(), repelForce_pred);
        }
      }
    }
    pred.display();
   }
 }

}
