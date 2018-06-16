//Yuvraj Singh
class enemy{
  
  int _startpoint;
  int _sp_pointx;
  int _sp_pointy;
  int _squre_pointx;
  int _squre_pointy;
  int _race;
  boolean _ignore;
  
  enemy(int x){
    _startpoint = x;
    _squre_pointx = _startpoint;
    _sp_pointx = _startpoint;
    _ignore = false;
  }
  
  void spike(int y){ //spike enemy
    _sp_pointy = y; //the y coordinate of the enemy
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
    
    
    _sp_pointx -= _race;
  }
  
  void square(int y){ 
    _squre_pointy = y; //the y coordinate of the enemy
    rectMode(CENTER);
    strokeWeight(2);
    stroke(150);
    fill(0,random(10,300),random(30,340));
    ellipse(_squre_pointx, _squre_pointy, 200, 30);
    _squre_pointx -= _race;
  }
  
  void ignore(){ 
    _ignore = true;
  }
  

  int spikeGetX1(){
    return _sp_pointx+5; //returns front coordinate
  }
  int spikeGetX2(){
    return _sp_pointx+75; //returns back coordinate
  }
  int spikeGetY1(){
    return _sp_pointy-50; //returns top coordinate
  }
  int spikeGetY2(){
    return _sp_pointy; //returns bottom coordinate 
  }
  
  //for the square enemy
  int squareGetX1(){ //returns front coordinate
    return _squre_pointx-25;
  }
  int squareGetX2(){ //returns back 
    return _squre_pointx+75;
  }
  int squareGetY1(){ //returns top coordinate
    return _squre_pointy-25;
  }
  int squareGetY2(){ //returns bottom coordinate
    return _squre_pointy+25;
  }
  
  void move(int speed){ 
    _race = speed;
  }
}
