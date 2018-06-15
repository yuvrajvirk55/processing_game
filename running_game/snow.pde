class snow{
  
 float x = random(1,500);
 float y = random(-1000,-50);
 float ht= random (7,15);
 float wt= random (7,15);
 
 
void snowfall(){
 
  y = y + 5;
  
  if (y >= 430)
  {
    y = random(-50,-25);
  }
}
  
void snowappear()
{
  fill(40,235,251);
  ellipse(x+random(1,12),y,ht,wt);
  
}
  
  
}
