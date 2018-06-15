//Yuvraj Singh
class enemy{
  
  int _startpoint;
  int _sp_pointx;
  int _sp_pointy;
  int _squareX;
  int _squareY;
  int _speed;
  boolean _ignore;
  
  enemy(int x){ //has only one argument, which startX, squareX and spikeX are all set according to
    _startpoint = x;
    _squareX = _startpoint;
    _sp_pointx = _startpoint;
    _ignore = false;
  }
  
  void spike(int y){ //spike enemy (lethal from front and on top)
    _sp_pointy = y; //the y coordinate of the enemy, set according to the argument in the constructor
    strokeWeight(2);
    stroke(150);
    fill(random(0,355));
    triangle(_sp_pointx, _sp_pointy, _sp_pointx+30, _sp_pointy, _sp_pointx+15, _sp_pointy-70);
        fill(0,random(0,355),random(0,355));
    rect(_sp_pointx+15, _sp_pointy-30,80,10);
       fill(random(0,355),0,random(0,355));
    rect(_sp_pointx+25, _sp_pointy-10,10,50);
    rect(_sp_pointx+5, _sp_pointy-10,10,50);
       fill(random(0,355),random(0,355),0);
    ellipse(_sp_pointx+15, _sp_pointy-25,30,50);
    fill(random(0,355),random(0,355),random(0,355));
    ellipse(_sp_pointx+15, _sp_pointy-50,17,20);
    
    
    _sp_pointx -= _speed;
  }
  
  void square(int y){ //square enemy (lethal from the front, safe on top)
    _squareY = y; //the y coordinate of the enemy, set according to the argument in the constructor
    rectMode(CENTER);
    strokeWeight(2);
    stroke(150);
    fill(0,random(10,300),random(30,340));
   // rect(_squareX, _squareY, 50, 50); 
    ellipse(_squareX, _squareY, 100, 30);
    _squareX -= _speed;
  }
  
  void ignore(){ //used to make actor object able to jump on square enemy
    _ignore = true;
  }
  
//get methods to use when checking for collision with actor object
  //for the spike enemy
  int spikeGetX1(){
    return _sp_pointx+5; //returns front coordinate of the spike 
  }
  int spikeGetX2(){
    return _sp_pointx+75; //returns back coordinate of the spike 
  }
  int spikeGetY1(){
    return _sp_pointy-50; //returns top coordinate of the spike
  }
  int spikeGetY2(){
    return _sp_pointy; //returns bottom coordinate of the spike
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
