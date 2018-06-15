//Yuvraj Singh

class actor{
  
  int _x_coo_actor; //x position 
  int _y_coo_actor; //y position
  int _size_actor; //size o
  int _startY; 
  
  
  int gravity = 6; 
  int jumpCounter = 0; 
  int jumpCounterLimit = 20; 
  boolean isJumping = false; 
  float jumpAngle = 0; 
  float incrementAngle = PI/20;
  boolean notInAir = true; 

  actor(int x, int y, int size){ 
    
    _x_coo_actor = x;
    _y_coo_actor = y;
    _size_actor = size;
    _startY = y; 
  }
  
  void jump(){ 
    if(notInAir){ 
      isJumping = true; //sets boolean to true, which triggers the jump 
    }
  }
  
  void physics(){ 
    //gravity
    if(_y_coo_actor < _startY){ 
      _y_coo_actor += gravity; //increment actor object's y position by gravity
      notInAir = false; //actor object is not in the air
    }else{
      notInAir = true; 
    }
    
  
    if(isJumping){
      _y_coo_actor -= 12; //increments the y position o
      jumpCounter += 1; //increments the jumpCounter
    }
    if(jumpCounter >= jumpCounterLimit){ 
      isJumping = false;
      jumpCounter = 0; 
    }
    //spin while in air
    if(!notInAir){
      jumpAngle += incrementAngle; 
    }
    if(notInAir){
      jumpAngle = 0; 
    }
  }
  
  
  int getX(){ 
    return _x_coo_actor + _size_actor/2; // location of the actor's front coordinate
  }
  int getY(){
    return _y_coo_actor + _size_actor/2; // location of the actors's bottom coordinate
  }

  void display(){ 
    pushMatrix(); 
    
    rectMode(CENTER); 
    translate(_x_coo_actor, _y_coo_actor); 
    rotate(jumpAngle); 
    
  
    strokeWeight(2);
    stroke(22, 85, 60);
    
    fill(53, 240, 165);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _size_actor+15, _size_actor);
    
    fill(0);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
    ellipse(0, 0, 5, 5);
    
    noStroke();
    fill(56, 243, 168);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _size_actor*0.9, _size_actor*0.9);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(59, 246, 171);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _size_actor*0.8, _size_actor*0.8);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(62, 249, 174);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _size_actor*0.7, _size_actor*0.7);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(65, 252, 177);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _size_actor*0.6, _size_actor*0.6);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
   
    fill(68, 255, 180);
     fill(random(10,340),random(0,340),random(30,340));line(0,0,5,-50);line(0,0,-5,-50);line(0,0,10,-50);line(0,0,-10,-50);line(0,0,10,-50);line(0,0,-15,-50);line(0,0,15,-50);line(0,0,-20,-50);line(0,0,20,-50);line(0,-25,5,-50);line(0,0,25,-50);line(0,0,-30,-50);line(0,0,30,-50);line(0,0,-35,-50);line(0,0,35,-50);line(0,0,-40,-50);line(0,0,40,-50);line(0,0,-45,-50);line(0,0,45,-50);line(0,0,-50,-50);line(0,0,50,-50);line(0,0,-55,-50);line(0,0,55,-50);line(0,0,-60,-50);line(0,0,60,-50);line(0,0,-65,-50);line(0,0,65,-50);line(0,0,-70,-50);
    ellipse(0, 0, _size_actor*0.5, _size_actor*0.5);
    
     fill(0);
    ellipse(0, 0, 5, 5);
   ellipse(8, 0, 5, 5);ellipse(2, 0+10, 25, 8);
    
    popMatrix();//matrix necessary to contain the rotate transformation
  }
}
