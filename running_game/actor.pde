//Yuvraj Singh

class actor{
  //attributes (affected by arguments)
  int _actorX; //x position of the actor object
  int _actorY; //y position of the actor object
  int _actorSize; //size of the actor object
  int _startY; //starting y position of the actor object, used to determine where the "floor" is
  
  //attributes (not affected by arguments)
  int gravity = 6; //gravity that the actor object is affected by
  int jumpCounter = 0; //counter used to determine how long the jump lasts
  int jumpCounterLimit = 20; //the limit for the jumpCounter
  boolean isJumping = false; //boolean used to trigger jump
  float jumpAngle = 0; //the angle at which actor object is rotated
  float incrementAngle = PI/20; //the increment at which the jumpAngle will be changed when jumping
  boolean notInAir = true; //used to determine when actor object is allowed to jump

  actor(int x, int y, int size){ //the actor object has three arguments x & y position and size
    //settings attributes to be equal to arguments that are passed in
    _actorX = x;
    _actorY = y;
    _actorSize = size;
    _startY = y; //used to determine when gravity is active
  }
  
  void jump(){ //makes the actor jump, this will be controlled by the person playing the game
    if(notInAir){ //if the actor is on the ground == true
      isJumping = true; //sets boolean to true, which triggers the jump in "physics()" 
    }
  }
  
  void physics(){ //is put into the "draw()" to constantly update
    //gravity
    if(_actorY < _startY){ //if actor object's y position is less than the starting y position
      _actorY += gravity; //increment actor object's y position by gravity
      notInAir = false; //actor object is not in the air, stopping "jump()" from working
    }else{
      notInAir = true; //if actor is on the "floor" = true, allowing "jump()" to work
    }
    
    //jump triggered by "jump()" method
    if(isJumping){
      _actorY -= 12; //increments the y position of the actor simulating a jump
      jumpCounter += 1; //increments the jumpCounter, which determines when to stop jumping 
    }
    if(jumpCounter >= jumpCounterLimit){ //when the counter reaches the limit the jump stops
      isJumping = false;
      jumpCounter = 0; //the counter is reset
    }
    //spin while in air
    if(!notInAir){
      jumpAngle += incrementAngle; //increments the jumpAngle, activating the rotate in "display()"
    }
    if(notInAir){
      jumpAngle = 0; //reset the jumpAngle so that the actor object is always even when on the "floor"
    }
  }
  
  //get methods to use when checking for collision with enemys
  int getX(){ 
    return _actorX + _actorSize/2; //returns the location of the actor's front coordinate
  }
  int getY(){
    return _actorY + _actorSize/2; //returns the location of the actors's bottom coordinate
  }

  void display(){ //is put into "draw()" to constantly update
    pushMatrix(); //matrix necessary to contain the rotate transformation
    
    rectMode(CENTER); //set rectMode
    translate(_actorX, _actorY); //sets the 0,0 to be inside itself, used for rotating correctly
    rotate(jumpAngle); //is always rotating, but the jumpAngle is set to 0, which means no rotating
    
    //similar to the scenery function it has gradient colours
    strokeWeight(2);
    stroke(22, 85, 60);
    
    fill(53, 240, 165);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _actorSize+15, _actorSize);
    
    fill(0);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
    ellipse(0, 0, 5, 5);
    
    noStroke();
    fill(56, 243, 168);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _actorSize*0.9, _actorSize*0.9);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(59, 246, 171);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _actorSize*0.8, _actorSize*0.8);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(62, 249, 174);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _actorSize*0.7, _actorSize*0.7);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(65, 252, 177);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _actorSize*0.6, _actorSize*0.6);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(68, 255, 180);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _actorSize*0.5, _actorSize*0.5);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
    
    popMatrix();//matrix necessary to contain the rotate transformation
  }
}
