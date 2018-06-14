//Kristoffer Pauly
//Game Project
//The Somewhat Possible Game

class enemy{
  //attributes (affected by arguments)
  int _enemyX; //x position of the enemy object
  int _enemyY; //y position of the enemy object
  int _enemySize; //size of the enemy object
  int _startY; //starting y position of the enemy object, used to determine where the "floor" is
  
  //attributes (not affected by arguments)
  int gravity = 6; //gravity that the enemy object is affected by
  int jumpCounter = 0; //counter used to determine how long the jump lasts
  int jumpCounterLimit = 20; //the limit for the jumpCounter
  boolean isJumping = false; //boolean used to trigger jump
  float jumpAngle = 0; //the angle at which enemy object is rotated
  float incrementAngle = PI/20; //the increment at which the jumpAngle will be changed when jumping
  boolean notInAir = true; //used to determine when enemy object is allowed to jump

  enemy(int x, int y, int size){ //the enemy object has three arguments x & y position and size
    //settings attributes to be equal to arguments that are passed in
    _enemyX = x;
    _enemyY = y;
    _enemySize = size;
    _startY = y; //used to determine when gravity is active
  }
  
  void jump(){ //makes the enemy jump, this will be controlled by the person playing the game
    if(notInAir){ //if the enemy is on the ground == true
      isJumping = true; //sets boolean to true, which triggers the jump in "physics()" 
    }
  }
  
  void physics(){ //is put into the "draw()" to constantly update
    //gravity
    if(_enemyY < _startY){ //if enemy object's y position is less than the starting y position
      _enemyY += gravity; //increment enemy object's y position by gravity
      notInAir = false; //enemy object is not in the air, stopping "jump()" from working
    }else{
      notInAir = true; //if enemy is on the "floor" = true, allowing "jump()" to work
    }
    
    //jump triggered by "jump()" method
    if(isJumping){
      _enemyY -= 12; //increments the y position of the enemy simulating a jump
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
      jumpAngle = 0; //reset the jumpAngle so that the enemy object is always even when on the "floor"
    }
  }
  
  //get methods to use when checking for collision with obstacles
  int getX(){ 
    return _enemyX + _enemySize/2; //returns the location of the enemy's front coordinate
  }
  int getY(){
    return _enemyY + _enemySize/2; //returns the location of the enemys's bottom coordinate
  }

  void display(){ //is put into "draw()" to constantly update
    pushMatrix(); //matrix necessary to contain the rotate transformation
    
    rectMode(CENTER); //set rectMode
    translate(_enemyX, _enemyY); //sets the 0,0 to be inside itself, used for rotating correctly
    rotate(jumpAngle); //is always rotating, but the jumpAngle is set to 0, which means no rotating
    
    //similar to the scenery function it has gradient colours
    strokeWeight(2);
    stroke(22, 85, 60);
    fill(53, 240, 165);
    rect(0, 0, _enemySize, _enemySize);
    noStroke();
    fill(56, 243, 168);
    ellipse(0, 0, _enemySize*0.9, _enemySize*0.9);
    fill(59, 246, 171);
    ellipse(0, 0, _enemySize*0.8, _enemySize*0.8);
    fill(62, 249, 174);
    ellipse(0, 0, _enemySize*0.7, _enemySize*0.7);
    fill(65, 252, 177);
    ellipse(0, 0, _enemySize*0.6, _enemySize*0.6);
    fill(68, 255, 180);
    ellipse(0, 0, _enemySize*0.5, _enemySize*0.5);
    
    popMatrix();//matrix necessary to contain the rotate transformation
  }
}
