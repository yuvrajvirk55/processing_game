//Yuvraj Singh
class enemy{
  
  int _startX;
  int _spikeX;
  int _spikeY;
  int _squareX;
  int _squareY;
  int _speed;
  boolean _ignore;
  
  enemy(int x){ //has only one argument, which startX, squareX and spikeX are all set according to
    _startX = x;
    _squareX = _startX;
    _spikeX = _startX;
    _ignore = false;
  }
  
  void spike(int y){ //spike enemy (lethal from front and on top)
    _spikeY = y; //the y coordinate of the enemy, set according to the argument in the constructor
    strokeWeight(2);
    stroke(150);
    fill(0);
    triangle(_spikeX, _spikeY, _spikeX+30, _spikeY, _spikeX+15, _spikeY-70);
    rect(_spikeX+15, _spikeY-30,80,10);
    rect(_spikeX+25, _spikeY-10,10,50);
    rect(_spikeX+5, _spikeY-10,10,50);
    ellipse(_spikeX+15, _spikeY-25,30,50);
    ellipse(_spikeX+15, _spikeY-50,17,20);
    
    
    _spikeX -= _speed;
  }
  
  void square(int y){ //square enemy (lethal from the front, safe on top)
    _squareY = y; //the y coordinate of the enemy, set according to the argument in the constructor
    rectMode(CENTER);
    strokeWeight(2);
    stroke(150);
    fill(0);
    rect(_squareX, _squareY, 50, 50); 
    _squareX -= _speed;
  }
  
  void ignore(){ //used to make actor object able to jump on square enemy
    _ignore = true;
  }
  
//get methods to use when checking for collision with actor object
  //for the spike enemy
  int spikeGetX1(){
    return _spikeX+5; //returns front coordinate of the spike 
  }
  int spikeGetX2(){
    return _spikeX+75; //returns back coordinate of the spike 
  }
  int spikeGetY1(){
    return _spikeY-50; //returns top coordinate of the spike
  }
  int spikeGetY2(){
    return _spikeY; //returns bottom coordinate of the spike
  }
  
  //for the square enemy
  int squareGetX1(){ //returns front coordinate of the square
    return _squareX-25;
  }
  int squareGetX2(){ //returns back coordinate of the square
    return _squareX+75;
  }
  int squareGetY1(){ //returns top coordinate of the square
    return _squareY-25;
  }
  int squareGetY2(){ //returns bottom coordinate of the square
    return _squareY+25;
  }
  
  void move(int speed){ //determines the speed which the enemys move along the x-axis with
    _speed = speed;
  }
}
