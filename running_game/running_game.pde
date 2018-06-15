//Yuvraj Singh

//actor
actor hero;

//delaring enemys
enemy[] enemys = new enemy[300]; //number of enemys

int timer_timer_clock = 0; //used for score 
int deathClock_count = 0; 
int maxScore = 0; 
int fade = 0; 

void setup(){
  size(1000, 600);
   //initialising hero
  hero = new actor(150, 524, 50); 
  
  //enemys
  for(int i = 0; i < 300; i++){
    enemys[i] = new enemy(1000); 
  }
}

void draw(){
  //background
  scenery();
  
  //enemys
  for(int i = 0; i < 300; i++){
    enemys[i].move(4); 
  }
  enemySpawn(); 
  collision_with_human();
  
  //hero
  hero.display();
  hero.physics();
  
  //timer_timer_clock, scoreboard and control display
  timer_timer_clock();
  scoreboard_to_display(); 
  display_actor_Controls();
}

void keyPressed(){
  switch(key){
   //jump (using Spacebar)
  case ' ': //when spacebar is pressed
    hero.jump();
    break;
    
    //reset button
  case 'r': //when 'r' is pressed
    reset();
    break;
  }
  switch(keyCode){
    //jump (using Up Arrow key)
  case UP: //when 'Up arrow' is pressed
    hero.jump();
    break;
  }
}

void collision_with_human(){
  //collision with spike
  for(int i = 0; i < 300; i++){
    if(hero.getX() > enemys[i].spikeGetX1() && hero.getX() < enemys[i].spikeGetX2()){
      if(hero._y_coo_actor > enemys[i].spikeGetY1() && hero._y_coo_actor < enemys[i].spikeGetY2()){
        println("Dead");

        delay(1000);
        reset();
      }
    }
    //collision with square
    if(hero.getX() > enemys[i].squareGetX1() && hero.getX() < enemys[i].squareGetX2()){
      if(hero._y_coo_actor > enemys[i].squareGetY1() && hero._y_coo_actor < enemys[i].squareGetY2()){
        println("Death");

        delay(1000);
        reset();
      }
      if(hero.getY() < enemys[i].squareGetY1()){ 
        hero._startY_actor = enemys[i].squareGetY1()-26;
      }
    }
    if(hero.getX() > enemys[i].squareGetX2() && !enemys[i]._ignore){ //resets the "floor" value
      hero._startY_actor = 524;
      enemys[i].ignore(); //sets _ignore to true
    }
  }
}

void timer_timer_clock(){ 
  timer_timer_clock += 1;
  
}

void reset(){ 
  timer_timer_clock = 0;

  for(int i = 0; i < 300; i++){
    enemys[i] = new enemy(1000);
  }
  //resets "floor"
  hero._startY_actor = 524;
  //increments death counter (used to track deaths)
  deathClock_count += 1;
  //reset win fade
  fade = 0;
}

void scoreboard_to_display(){ //scoreboard that tracks longest travelled distance
  if(timer_timer_clock > maxScore){
    maxScore = timer_timer_clock;
  }
  textAlign(CENTER);
  //maxScore display
  textSize(35);
  fill(0);
  text("maxScore: "+maxScore/60, 800, 50); //maxScore is divided by 60 so each second = 1 point
  //death counter display
  fill(255);
  textSize(45);
  text(deathClock_count, 500, 60);
}

void display_actor_Controls(){
  //displays controls until the timer_timer_clock reaches 250, i.e. until encountering the first enemy
  if(timer_timer_clock < 250){
    textAlign(CENTER);
    textSize(35);
    fill(0);
    text("JUMP: UP, W or SPACE", 220, 50);
  }else{ //displays current score
    textAlign(CENTER);
    textSize(35);
    fill(0);
    text("Current score: "+timer_timer_clock/60, 200, 50);
  }
}

void scenery(){
  noStroke();
  fill(205, 120-mouseX/2, 0+mouseX);
  rect(500, 300, 1500, 1500);
  fill(210, 125-mouseX/2, 5+mouseX);
  rect(500, 600, 1400, 1400);
  fill(215, 130-mouseX/2, 10+mouseX);
  rect(500, 600, 1300, 1300);
  fill(220, 135-mouseX/2, 15+mouseX);
  rect(500, 600, 1200, 1200);
  fill(225, 140-mouseX/2, 20+mouseX);
  rect(500, 600, 1100, 1100);
  fill(230, 145-mouseX/2, 25+mouseX);
  rect(500, 600, 1000, 1000);
  fill(235, 150-mouseX/2, 30+mouseX);
  rect(500, 600, 900, 900);
  fill(240, 155-mouseX/2, 35+mouseX);
  rect(500, 600, 800, 800);
  fill(245, 160-mouseX/2, 40+mouseX);
  rect(500, 600, 700, 700);
  fill(250, 165-mouseX/2, 45+mouseX);
  rect(500, 600, 600, 600);
  fill(255, 170-mouseX/2, 50+mouseX);
  rect(500, 600, 500, 500);
  //ground
  strokeWeight(3);
  stroke(0);
  fill(255-mouseX, 50+mouseX, 50+mouseX, 150);
  rect(500, 600, 1050, 100);
}

void gameComplete(){
  //fades to black by acting as an increasing alpha for the rect that covers the screen
  noStroke();
  fill(0, 0, 0, fade);
  rectMode(CENTER);
  rect(500, 300, 1000, 600);
  fade += 1;
  //you win text
  textAlign(CENTER);
  textSize(50);
  fill(random(255), random(255), random(255));
  text("You Win!", 500, 300);
}

void enemySpawn(){ //spawns the enemys based on the timer_timer_clock (this part of the code is incredibly long)
/*
Notes to self: 
- floor is 525 (square) and 550 (spike)
- good timer_timer_clock distance for linked objects 12 (square) and 8 (spike)
- nearly 1200 lines of code for this part D:
*/
  if(timer_timer_clock > 150){
    enemys[1].spike(550);
  }
  if(timer_timer_clock > 250){
    enemys[2].spike(550);
  }
  if(timer_timer_clock > 350){
    enemys[3].spike(550);
  }
  if(timer_timer_clock > 450){
    enemys[4].spike(550);
  }
  if(timer_timer_clock > 525){
    enemys[5].spike(550);
  }
  if(timer_timer_clock > 600){
    enemys[6].spike(550);
  }
  //===============(600 = 10s)===============
  if(timer_timer_clock > 675){
    enemys[7].spike(550);
  }
  if(timer_timer_clock > 682){
    enemys[8].spike(550);
  }
  if(timer_timer_clock > 750){
    enemys[1].square(525);
  }
  if(timer_timer_clock > 780){
    enemys[2].square(475);
  }
  if(timer_timer_clock > 810){
    enemys[3].square(425);
  }
  if(timer_timer_clock > 845){
    enemys[4].square(375);
  }
  if(timer_timer_clock > 850){
    enemys[9].spike(550);
  }
  if(timer_timer_clock > 858){
    enemys[10].spike(550);
  }
  if(timer_timer_clock > 866){
    enemys[11].spike(550);
  }
  if(timer_timer_clock > 874){
    enemys[12].spike(550);
  }
  if(timer_timer_clock > 880){
    enemys[5].square(375);
  }
  if(timer_timer_clock > 882){
    enemys[13].spike(550);
  }
  if(timer_timer_clock > 930){ 
    enemys[6].square(375);
  }
  if(timer_timer_clock > 965){
    enemys[14].spike(550);
  }
  if(timer_timer_clock > 1005){
    enemys[15].spike(550);
  }
  if(timer_timer_clock > 1080){ 
    enemys[7].square(525);
  }
  if(timer_timer_clock > 1120){ 
    enemys[8].square(475);
  }
  if(timer_timer_clock > 1160){ 
    enemys[9].square(525);
  }
  if(timer_timer_clock > 1200){ 
    enemys[10].square(475);
  }
  //===============(1200 = 20s)===============
  if(timer_timer_clock > 1240){ 
    enemys[11].square(525);
  }
  if(timer_timer_clock > 1276){ 
    enemys[16].spike(450);
  }
  if(timer_timer_clock > 1280){ 
    enemys[12].square(475);
  }
  if(timer_timer_clock > 1330){ 
    enemys[13].square(525);
  }
  if(timer_timer_clock > 1338){
    enemys[17].spike(550);
  }
  if(timer_timer_clock > 1346){
    enemys[18].spike(550);
  }
  if(timer_timer_clock > 1354){
    enemys[19].spike(550);
  }
  if(timer_timer_clock > 1362){
    enemys[20].spike(550);
  }
  if(timer_timer_clock > 1450){ 
    enemys[14].square(525);
  }
  if(timer_timer_clock > 1500){ 
    enemys[15].square(475);
  }
  if(timer_timer_clock > 1524){ 
    enemys[16].square(525);
  }
  if(timer_timer_clock > 1572){
    enemys[21].spike(550);
  }
  if(timer_timer_clock > 1650){
    enemys[22].spike(550);
  }
  if(timer_timer_clock > 1658){
    enemys[23].spike(550);
  }
  if(timer_timer_clock > 1690){
    enemys[24].spike(550);
  }
  if(timer_timer_clock > 1698){
    enemys[25].spike(550);
  }
  if(timer_timer_clock > 1730){
    enemys[26].spike(550);
  }
  if(timer_timer_clock > 1738){
    enemys[27].spike(550);
  }
  if(timer_timer_clock > 1775){
    enemys[28].spike(550);
  }
  //===============(1800 = 30s)===============
  if(timer_timer_clock > 1830){
    enemys[29].spike(550);
  }
  if(timer_timer_clock > 1838){
    enemys[30].spike(550);
  }
  if(timer_timer_clock > 1870){
    enemys[31].spike(550);
  }
  if(timer_timer_clock > 1878){
    enemys[32].spike(550);
  }
  if(timer_timer_clock > 1940){
    enemys[33].spike(550);
  }
  if(timer_timer_clock > 2000){
    enemys[34].spike(550);
  }
  if(timer_timer_clock > 2008){
    enemys[35].spike(550);
  }
  if(timer_timer_clock > 2040){
    enemys[36].spike(550);
  }
  if(timer_timer_clock > 2048){
    enemys[37].spike(550);
  }
  if(timer_timer_clock > 2080){
    enemys[38].spike(550);
  }
  if(timer_timer_clock > 2088){
    enemys[39].spike(550);
  }
  if(timer_timer_clock > 2160){ 
    enemys[17].square(525);
  }
  if(timer_timer_clock > 2200){ 
    enemys[18].square(475);
  }
  if(timer_timer_clock > 2220){
    enemys[40].spike(500);
    enemys[41].spike(550);
  }
  if(timer_timer_clock > 2240){ 
    enemys[19].square(475);
  }
  if(timer_timer_clock > 2275){ 
    enemys[20].square(425);
  }
  if(timer_timer_clock > 2310){ 
    enemys[21].square(375);
  }
  if(timer_timer_clock > 2345){ 
    enemys[22].square(325);
  }
  if(timer_timer_clock > 2365){ 
    enemys[23].square(375);
  }
  if(timer_timer_clock > 2400){ 
    enemys[24].square(325);
  }
  //===============(2400 = 40s)===============
  if(timer_timer_clock > 2414){ 
    enemys[42].spike(550);
  }
  if(timer_timer_clock > 2422){ 
    enemys[43].spike(550);
  }
  if(timer_timer_clock > 2430){ 
    enemys[44].spike(550);
  }
  if(timer_timer_clock > 2438){ 
    enemys[45].spike(550);
  }
  if(timer_timer_clock > 2550){ 
    enemys[25].square(525);
  }
  if(timer_timer_clock > 2590){ 
    enemys[26].square(475);
  }
  if(timer_timer_clock > 2630){ 
    enemys[27].square(525);
  }
  if(timer_timer_clock > 2670){ 
    enemys[28].square(475);
  }
  if(timer_timer_clock > 2706){ 
    enemys[46].spike(550);
  }
  if(timer_timer_clock > 2714){ 
    enemys[47].spike(550);
  }
  if(timer_timer_clock > 2760){ 
    enemys[29].square(525);
  }
  if(timer_timer_clock > 2800){ 
    enemys[30].square(475);
  }
  if(timer_timer_clock > 2840){ 
    enemys[31].square(525);
  }
  if(timer_timer_clock > 2880){ 
    enemys[32].square(475);
  }
  if(timer_timer_clock > 2916){ 
    enemys[48].spike(550);
  }
  if(timer_timer_clock > 2924){ 
    enemys[49].spike(550);
  }
  if(timer_timer_clock > 2970){ 
    enemys[33].square(525);
  }
  //===============(3000 = 50s)===============
  if(timer_timer_clock > 3010){ 
    enemys[34].square(475);
  }
  if(timer_timer_clock > 3050){ 
    enemys[35].square(525);
  }
  if(timer_timer_clock > 3090){ 
    enemys[36].square(475);
  }
  if(timer_timer_clock > 3125){ 
    enemys[37].square(425);
  }
  if(timer_timer_clock > 3130){ 
    enemys[50].spike(550);
  }
  if(timer_timer_clock > 3138){ 
    enemys[51].spike(550);
  }
  if(timer_timer_clock > 3146){ 
    enemys[52].spike(550);
  }
  if(timer_timer_clock > 3154){ 
    enemys[53].spike(550);
  }
  if(timer_timer_clock > 3160){ 
    enemys[38].square(375);
  }
  if(timer_timer_clock > 3210){ 
    enemys[54].spike(550);
  }
  if(timer_timer_clock > 3250){ 
    enemys[55].spike(550);
  }
  if(timer_timer_clock > 3258){ 
    enemys[56].spike(550);
  }
  if(timer_timer_clock > 3274){ 
    enemys[39].square(525);
  }
  if(timer_timer_clock > 3282){ 
    enemys[57].spike(550);
  }
  if(timer_timer_clock > 3290){ 
    enemys[58].spike(550);
  }
  if(timer_timer_clock > 3350){ 
    enemys[59].spike(550);
  }
  if(timer_timer_clock > 3358){ 
    enemys[60].spike(550);
  }
  if(timer_timer_clock > 3374){ 
    enemys[40].square(525);
  }
  if(timer_timer_clock > 3382){ 
    enemys[61].spike(550);
  }
  if(timer_timer_clock > 3390){ 
    enemys[62].spike(550);
  }
  if(timer_timer_clock > 3450){ 
    enemys[63].spike(550);
  }
  if(timer_timer_clock > 3458){ 
    enemys[64].spike(550);
  }
  if(timer_timer_clock > 3474){ 
    enemys[41].square(525);
  }
  if(timer_timer_clock > 3482){ 
    enemys[65].spike(550);
  }
  if(timer_timer_clock > 3490){ 
    enemys[66].spike(550);
  }
  if(timer_timer_clock > 3540){ 
    enemys[67].spike(550);
  }
  if(timer_timer_clock > 3548){ 
    enemys[68].spike(550);
  }
  if(timer_timer_clock > 3564){ 
    enemys[42].square(525);
  }
  if(timer_timer_clock > 3572){ 
    enemys[69].spike(550);
  }
  if(timer_timer_clock > 3580){ 
    enemys[70].spike(550);
  }
  //===============(3600 = 60s)===============
  if(timer_timer_clock > 3650){ 
    enemys[43].square(525);
  }
  if(timer_timer_clock > 3690){ 
    enemys[44].square(475);
  }
  if(timer_timer_clock > 3725){ 
    enemys[45].square(425);
  }
  if(timer_timer_clock > 3760){ 
    enemys[46].square(375);
  }
  if(timer_timer_clock > 3795){ 
    enemys[47].square(325);
  }  
  if(timer_timer_clock > 3830){ 
    enemys[48].square(275);
  }
  if(timer_timer_clock > 3838){ 
    enemys[71].spike(550);
  }
  if(timer_timer_clock > 3846){ 
    enemys[72].spike(550);
  }
  if(timer_timer_clock > 3854){ 
    enemys[73].spike(550);
  }
  if(timer_timer_clock > 3862){ 
    enemys[74].spike(550);
  }
  if(timer_timer_clock > 4000){ 
    enemys[49].square(525);
  }
  if(timer_timer_clock > 4040){ 
    enemys[50].square(475);
  }
  if(timer_timer_clock > 4075){ 
    enemys[51].square(425);
  }
  if(timer_timer_clock > 4110){ 
    enemys[52].square(375);
  }
  if(timer_timer_clock > 4145){ 
    enemys[53].square(325);
  }  
  if(timer_timer_clock > 4180){ 
    enemys[54].square(275);
  }
  if(timer_timer_clock > 4188){ 
    enemys[75].spike(550);
  }
  if(timer_timer_clock > 4196){ 
    enemys[76].spike(550);
  }
  //===============(4200 = 70s)===============
  if(timer_timer_clock > 4204){ 
    enemys[77].spike(550);
  }
  if(timer_timer_clock > 4212){ 
    enemys[78].spike(550);
  }
  if(timer_timer_clock > 4300){ 
    enemys[55].square(525);
  }
  if(timer_timer_clock > 4340){ 
    enemys[56].square(475);
  }
  if(timer_timer_clock > 4375){ 
    enemys[57].square(425);
  }
  if(timer_timer_clock > 4410){ 
    enemys[58].square(375);
  }
  if(timer_timer_clock > 4445){ 
    enemys[59].square(325);
  }  
  if(timer_timer_clock > 4480){ 
    enemys[60].square(275);
  }
  if(timer_timer_clock > 4488){ 
    enemys[79].spike(550);
  }
  if(timer_timer_clock > 4496){ 
    enemys[80].spike(550);
  }
  if(timer_timer_clock > 4504){ 
    enemys[81].spike(550);
  }
  if(timer_timer_clock > 4512){ 
    enemys[82].spike(550);
  }
  if(timer_timer_clock > 4600){ 
    enemys[83].spike(550);
  }
  if(timer_timer_clock > 4650){ 
    enemys[84].spike(500);
  }
  if(timer_timer_clock > 4700){ 
    enemys[85].spike(550);
  }
  if(timer_timer_clock > 4750){ 
    enemys[86].spike(515);
    enemys[87].spike(550);
  }
  if(timer_timer_clock > 4800){ 
    enemys[88].spike(550);
  }
  //===============(4800 = 80s)===============
  if(timer_timer_clock > 4850){ 
    enemys[89].spike(500);
  }
  if(timer_timer_clock > 4900){ 
    enemys[90].spike(550);
  }
  if(timer_timer_clock > 4950){ 
    enemys[91].spike(515);
    enemys[92].spike(550);
  }
  if(timer_timer_clock > 5000){ 
    enemys[93].spike(550);
  }
  if(timer_timer_clock > 5008){ 
    enemys[94].spike(550);
  }
  if(timer_timer_clock > 5046){ 
    enemys[95].spike(550);
  }
  if(timer_timer_clock > 5100){ 
    enemys[96].spike(515);
    enemys[97].spike(550);
  }
  if(timer_timer_clock > 5170){ 
    enemys[98].spike(515);
    enemys[99].spike(550);
  }
  if(timer_timer_clock > 5230){ 
    enemys[100].spike(515);
    enemys[101].spike(550);
  }
  if(timer_timer_clock > 5280){ 
    enemys[102].spike(515);
    enemys[103].spike(550);
  }
  if(timer_timer_clock > 5330){ 
    enemys[104].spike(515);
    enemys[105].spike(550);
  }
  if(timer_timer_clock > 5380){ 
    enemys[106].spike(515);
    enemys[107].spike(550);
  }
  //===============(5400 = 90s)===============
  if(timer_timer_clock > 5500){
    enemys[61].square(525);
  }
  if(timer_timer_clock > 5540){
    enemys[62].square(475);
  }
  if(timer_timer_clock > 5575){
    enemys[63].square(425);
  }
  if(timer_timer_clock > 5605){
    enemys[64].square(375);
  }
  if(timer_timer_clock > 5625){
    enemys[65].square(425);
  }
  if(timer_timer_clock > 5640){ 
    enemys[108].spike(550);
  }
  if(timer_timer_clock > 5648){ 
    enemys[109].spike(400);
    enemys[110].spike(550);
  }
  if(timer_timer_clock > 5656){ 
    enemys[111].spike(400);
    enemys[112].spike(550);
  }
  if(timer_timer_clock > 5750){
    enemys[66].square(525);
  }
  if(timer_timer_clock > 5790){
    enemys[67].square(475);
  }
  if(timer_timer_clock > 5825){
    enemys[68].square(425);
  }
  if(timer_timer_clock > 5860){
    enemys[69].square(375);
  }
  if(timer_timer_clock > 5860){ 
    enemys[113].spike(515);
    enemys[114].spike(550);
  }
  if(timer_timer_clock > 5876){ 
    enemys[115].spike(515);
    enemys[116].spike(550);
  }
  if(timer_timer_clock > 5950){
    enemys[70].square(525);
  }
  if(timer_timer_clock > 5990){
    enemys[71].square(475);
  }
  //===============(6000 = 100s)===============
  if(timer_timer_clock > 6025){
    enemys[72].square(425);
    enemys[117].spike(550);
  }
  if(timer_timer_clock > 6060){
    enemys[73].square(375);
  }
  if(timer_timer_clock > 6068){ 
    enemys[118].spike(350);
  }
  if(timer_timer_clock > 6076){ 
    enemys[119].spike(350);
  }
  if(timer_timer_clock > 6084){ 
    enemys[120].spike(350);
  }
  if(timer_timer_clock > 6092){ 
    enemys[121].spike(350);
  }
  if(timer_timer_clock > 6200){
    enemys[74].square(525);
  }
  if(timer_timer_clock > 6240){
    enemys[75].square(475);
  }
  if(timer_timer_clock > 6275){
    enemys[76].square(425);
  }
  if(timer_timer_clock > 6310){
    enemys[77].square(375);
  }
  if(timer_timer_clock > 6318){ 
    enemys[122].spike(350);
  }
  if(timer_timer_clock > 6326){ 
    enemys[123].spike(350);
  }
  if(timer_timer_clock > 6334){ 
    enemys[124].spike(350);
  }
  if(timer_timer_clock > 6342){ 
    enemys[125].spike(350);
  }
  if(timer_timer_clock > 6450){
    enemys[78].square(525);
  }
  if(timer_timer_clock > 6490){
    enemys[79].square(475);
  }
  if(timer_timer_clock > 6525){
    enemys[80].square(425);
  }
  if(timer_timer_clock > 6560){
    enemys[81].square(375);
  }
  if(timer_timer_clock > 6560){ 
    enemys[126].spike(515);
    enemys[127].spike(550);
  }
  if(timer_timer_clock > 6576){ 
    enemys[128].spike(515);
    enemys[129].spike(550);
  }
  //===============(6600 = 110s)===============
  if(timer_timer_clock > 6700){ 
    enemys[82].square(525);
  }
  if(timer_timer_clock > 6740){ 
    enemys[83].square(475);
  }
  if(timer_timer_clock > 6775){ 
    enemys[84].square(425);
  }
  if(timer_timer_clock > 6791){ 
    enemys[130].spike(400);
  }
  if(timer_timer_clock > 6799){ 
    enemys[131].spike(400);
  }
  if(timer_timer_clock > 6820){ 
    enemys[85].square(425);
  }
  if(timer_timer_clock > 6836){ 
    enemys[132].spike(400);
  }
  if(timer_timer_clock > 6844){ 
    enemys[133].spike(400);
  }
  if(timer_timer_clock > 6865){ 
    enemys[86].square(425);
  }
  if(timer_timer_clock > 6881){ 
    enemys[134].spike(400);
  }
  if(timer_timer_clock > 6889){ 
    enemys[135].spike(400);
  }
  if(timer_timer_clock > 6910){ 
    enemys[87].square(425);
  }
  if(timer_timer_clock > 6945){ 
    enemys[88].square(375);
  }
  if(timer_timer_clock > 6980){ 
    enemys[89].square(325);
  }
  if(timer_timer_clock > 6996){ 
    enemys[136].spike(300);
  }
  if(timer_timer_clock > 7004){ 
    enemys[137].spike(300);
  }
  if(timer_timer_clock > 7025){ 
    enemys[90].square(325);
  }
  if(timer_timer_clock > 7041){ 
    enemys[138].spike(300);
  }
  if(timer_timer_clock > 7049){ 
    enemys[139].spike(300);
  }
  if(timer_timer_clock > 7070){ 
    enemys[91].square(325);
  }
  if(timer_timer_clock > 7086){ 
    enemys[140].spike(300);
  }
  if(timer_timer_clock > 7094){ 
    enemys[141].spike(300);
  }
  if(timer_timer_clock > 7115){ 
    enemys[92].square(325);
  }
  if(timer_timer_clock > 7135){ 
    enemys[93].square(375);
  }
  if(timer_timer_clock > 7155){ 
    enemys[94].square(425);
  }
  if(timer_timer_clock > 7175){ 
    enemys[95].square(475);
  }
  if(timer_timer_clock > 7191){ 
    enemys[142].spike(450);
  }
  if(timer_timer_clock > 7199){ 
    enemys[143].spike(450);
  }
  //===============(7200 = 120s)===============
  if(timer_timer_clock > 7220){ 
    enemys[96].square(475);
  }
  if(timer_timer_clock > 7236){ 
    enemys[144].spike(450);
  }
  if(timer_timer_clock > 7244){ 
    enemys[145].spike(450);
  }
  if(timer_timer_clock > 7265){ 
    enemys[97].square(475);
  }
  if(timer_timer_clock > 7281){ 
    enemys[146].spike(450);
    enemys[147].spike(550);
  }
  if(timer_timer_clock > 7289){ 
    enemys[148].spike(450);
    enemys[149].spike(550);
  }
  if(timer_timer_clock > 7310){ 
    enemys[98].square(475);
  }
  if(timer_timer_clock > 7335){ 
    enemys[99].square(525);
  }
  if(timer_timer_clock > 7380){ 
    enemys[150].spike(550);
  }
  if(timer_timer_clock > 7388){ 
    enemys[151].spike(550);
  }
  if(timer_timer_clock > 7433){ 
    enemys[152].spike(550);
  }
  if(timer_timer_clock > 7441){ 
    enemys[153].spike(550);
  }
  if(timer_timer_clock > 7536){ 
    enemys[154].spike(550);
  }
  if(timer_timer_clock > 7550){ 
    enemys[100].square(525);
  }
  if(timer_timer_clock > 7571){ 
    enemys[155].spike(500);
  }
  if(timer_timer_clock > 7585){ 
    enemys[101].square(475);
  }
  if(timer_timer_clock > 7606){ 
    enemys[156].spike(450);
  }
  if(timer_timer_clock > 7620){ 
    enemys[102].square(425);
  }
  if(timer_timer_clock > 7641){ 
    enemys[157].spike(400);
  }
  if(timer_timer_clock > 7655){ 
    enemys[103].square(375);
  }
  if(timer_timer_clock > 7680){ 
    enemys[104].square(425);
  }
  if(timer_timer_clock > 7715){ 
    enemys[105].square(375);
  }
  if(timer_timer_clock > 7750){ 
    enemys[106].square(325);
  }
  if(timer_timer_clock > 7775){ 
    enemys[107].square(375);
  }
  //===============(7800 = 130s)===============
  if(timer_timer_clock > 7810){ 
    enemys[108].square(325);
  }
  if(timer_timer_clock > 7835){ 
    enemys[109].square(375);
  }
  if(timer_timer_clock > 7860){ 
    enemys[110].square(425);
    enemys[158].spike(550);
  }
  if(timer_timer_clock > 7868){ 
    enemys[159].spike(550);
  }
  if(timer_timer_clock > 7885){ 
    enemys[111].square(475);
  }
  if(timer_timer_clock > 7910){ 
    enemys[112].square(525);
  }
  if(timer_timer_clock > 7945){ 
    enemys[113].square(475);
  }
  if(timer_timer_clock > 7970){ 
    enemys[114].square(525);
  }
  if(timer_timer_clock > 8005){ 
    enemys[115].square(475);
  }
  if(timer_timer_clock > 8040){ 
    enemys[116].square(425);
  }
  if(timer_timer_clock > 8065){ 
    enemys[117].square(475);
  }
  if(timer_timer_clock > 8100){ 
    enemys[118].square(425);
  }
  if(timer_timer_clock > 8135){ 
    enemys[119].square(375);
  }
  if(timer_timer_clock > 8160){ 
    enemys[120].square(425);
  }
  if(timer_timer_clock > 8195){ 
    enemys[121].square(375);
  }
  if(timer_timer_clock > 8220){ 
    enemys[122].square(425);
  }
  if(timer_timer_clock > 8255){ 
    enemys[123].square(375);
  }
  if(timer_timer_clock > 8290){ 
    enemys[124].square(325);
  }
  if(timer_timer_clock > 8315){ 
    enemys[125].square(375);
  }
  if(timer_timer_clock > 8350){ 
    enemys[126].square(325);
  }
  if(timer_timer_clock > 8375){ 
    enemys[127].square(375);
  }
  if(timer_timer_clock > 8400){ 
    enemys[128].square(425);
  }
  //===============(8400 = 140s)===============
  if(timer_timer_clock > 8408){ 
    enemys[160].spike(550);
  }
  if(timer_timer_clock > 8416){ 
    enemys[161].spike(550);
  }
  if(timer_timer_clock > 8424){ 
    enemys[162].spike(550);
  }
  if(timer_timer_clock > 8432){ 
    enemys[163].spike(550);
  }
  if(timer_timer_clock > 8445){ 
    enemys[129].square(425);
  }
  if(timer_timer_clock > 8470){ 
    enemys[130].square(475);
  }
  if(timer_timer_clock > 8495){ 
    enemys[131].square(525);
  }
  if(timer_timer_clock > 8600){ 
    enemys[132].square(525);
  }
  if(timer_timer_clock > 8640){ 
    enemys[133].square(475);
  }
  if(timer_timer_clock > 8648){ 
    enemys[164].spike(450);
  }
  if(timer_timer_clock > 8656){ 
    enemys[165].spike(450);
  }
  if(timer_timer_clock > 8664){ 
    enemys[166].spike(450);
  }
  if(timer_timer_clock > 8750){ 
    enemys[134].square(525);
  }
  if(timer_timer_clock > 8790){ 
    enemys[135].square(475);
  }
  if(timer_timer_clock > 8798){ 
    enemys[167].spike(550);
  }
  if(timer_timer_clock > 8806){ 
    enemys[168].spike(550);
  }
  if(timer_timer_clock > 8814){ 
    enemys[169].spike(550);
  }
  if(timer_timer_clock > 8900){ 
    enemys[136].square(525);
  }
  if(timer_timer_clock > 8940){ 
    enemys[137].square(475);
  }
  if(timer_timer_clock > 8948){ 
    enemys[170].spike(550);
  }
  if(timer_timer_clock > 8956){ 
    enemys[171].spike(550);
  }
  if(timer_timer_clock > 8964){ 
    enemys[172].spike(550);
  }
  //===============(9000 = 150s)===============
  if(timer_timer_clock > 9050){ 
    enemys[138].square(525);
  }
  if(timer_timer_clock > 9058){ 
    enemys[173].spike(550);
  }
  if(timer_timer_clock > 9066){ 
    enemys[174].spike(550);
  }
  if(timer_timer_clock > 9074){ 
    enemys[175].spike(550);
  }
  if(timer_timer_clock > 9090){ 
    enemys[139].square(525);
  }
  if(timer_timer_clock > 9130){ 
    enemys[140].square(475);
  }
  if(timer_timer_clock > 9165){ 
    enemys[141].square(425);
  }
  if(timer_timer_clock > 9205){ 
    enemys[142].square(425);
  }
  if(timer_timer_clock > 9230){ 
    enemys[143].square(475);
  }
  if(timer_timer_clock > 9275){ 
    enemys[144].square(475);
  }
  if(timer_timer_clock > 9305){ 
    enemys[145].square(425);
  }
  if(timer_timer_clock > 9340){ 
    enemys[146].square(375);
  }
  if(timer_timer_clock > 9385){ 
    enemys[147].square(375);
  }
  if(timer_timer_clock > 9410){ 
    enemys[148].square(425);
  }
  if(timer_timer_clock > 9455){ 
    enemys[149].square(425);
  }
  if(timer_timer_clock > 9490){ 
    enemys[150].square(375);
  }
  if(timer_timer_clock > 9535){ 
    enemys[151].square(375);
  }
  if(timer_timer_clock > 9560){ 
    enemys[152].square(425);
  }
  if(timer_timer_clock > 9560){ 
    enemys[176].spike(550);
  }
  if(timer_timer_clock > 9568){ 
    enemys[177].spike(550);
  }
  if(timer_timer_clock > 9585){ 
    enemys[153].square(475);
  }
  if(timer_timer_clock > 9610){ 
    enemys[154].square(525);
  }
  //===============(9600 = 160s)===============
  if(timer_timer_clock > 9655){ 
    enemys[155].square(525);
  }
  if(timer_timer_clock > 9690){ 
    enemys[156].square(475);
  }
  if(timer_timer_clock > 9725){ 
    enemys[157].square(425);
  }
  if(timer_timer_clock > 9760){ 
    enemys[158].square(375);
  }
  if(timer_timer_clock > 9795){ 
    enemys[159].square(325);
  }
  if(timer_timer_clock > 9830){ 
    enemys[160].square(275);
  }
  if(timer_timer_clock > 9865){ 
    enemys[161].square(225);
  }
  if(timer_timer_clock > 9900){ 
    enemys[162].square(175);
  }
  if(timer_timer_clock > 9960){ 
    enemys[163].square(475);
  }
  if(timer_timer_clock > 9985){ 
    enemys[164].square(525);
  }
  if(timer_timer_clock > 9990){ 
    enemys[165].square(425);
  }
  if(timer_timer_clock > 9993){ 
    enemys[178].spike(550);
  }
  if(timer_timer_clock > 10001){ 
    enemys[179].spike(550);
  }
  if(timer_timer_clock > 10035){ 
    enemys[166].square(425);
  }
  if(timer_timer_clock > 10070){ 
    enemys[167].square(375);
  }
  if(timer_timer_clock > 10105){ 
    enemys[168].square(325);
  }
  if(timer_timer_clock > 10130){ 
    enemys[169].square(375);
  }
  if(timer_timer_clock > 10165){ 
    enemys[170].square(325);
  }
  if(timer_timer_clock > 10190){ 
    enemys[171].square(375);
  }
  //===============(10200 = 170s)===============
  if(timer_timer_clock > 10235){ 
    enemys[172].square(325);
  }
  if(timer_timer_clock > 10260){ 
    enemys[173].square(375);
  }
  if(timer_timer_clock > 10305){ 
    enemys[174].square(325);
  }
  if(timer_timer_clock > 10330){ 
    enemys[175].square(375);
  }
  if(timer_timer_clock > 10355){ 
    enemys[176].square(425);
  }
  if(timer_timer_clock > 10363){ 
    enemys[180].spike(550);
  }
  if(timer_timer_clock > 10371){ 
    enemys[181].spike(550);
  }
  if(timer_timer_clock > 10380){ 
    enemys[177].square(475);
  }
  if(timer_timer_clock > 10425){ 
    enemys[178].square(475);
  }
  if(timer_timer_clock > 10470){ 
    enemys[179].square(475);
  }
  if(timer_timer_clock > 10495){ 
    enemys[180].square(525);
  }
  if(timer_timer_clock > 10600){ 
    enemys[181].square(525);
  }
  if(timer_timer_clock > 10635){ 
    enemys[182].square(475);
  }
  if(timer_timer_clock > 10670){ 
    enemys[183].square(425);
  }
  if(timer_timer_clock > 10705){ 
    enemys[184].square(375);
  }
  if(timer_timer_clock > 10740){ 
    enemys[185].square(325);
  }
  if(timer_timer_clock > 10775){ 
    enemys[186].square(275);
  }
  //===============(10800 = 180s)===============
  if(timer_timer_clock > 10810){ 
    enemys[187].square(225);
  }
  if(timer_timer_clock > 10845){ 
    enemys[188].square(175);
  }
  if(timer_timer_clock > 10870){ 
    enemys[189].square(225);
  }
  if(timer_timer_clock > 10895){ 
    enemys[190].square(275);
  }
  if(timer_timer_clock > 10920){ 
    enemys[191].square(325);
  }
  if(timer_timer_clock > 10945){ 
    enemys[192].square(375);
  }
  if(timer_timer_clock > 10970){ 
    enemys[193].square(425);
  }
  if(timer_timer_clock > 10995){ 
    enemys[194].square(475);
  }
  if(timer_timer_clock > 11020){ 
    enemys[195].square(525);
  }
  if(timer_timer_clock > 11100){ 
    enemys[182].spike(550);
  }
  if(timer_timer_clock > 11116){ 
    enemys[183].spike(450);
  }
  if(timer_timer_clock > 11132){ 
    enemys[184].spike(350);
  }
  if(timer_timer_clock > 11150){ 
    enemys[196].square(525);
    enemys[185].spike(300);
  }
  if(timer_timer_clock > 11166){ 
    enemys[186].spike(350);
  }
  if(timer_timer_clock > 11184){ 
    enemys[187].spike(450);
  }
  if(timer_timer_clock > 11200){ 
    enemys[188].spike(550);
  }
  if(timer_timer_clock > 11350){ 
    enemys[197].square(525);
  }
  if(timer_timer_clock > 11385){ 
    enemys[198].square(475);
  }
  //===============(11400 = 190s)===============
  if(timer_timer_clock > 11420){ 
    enemys[199].square(425);
  }
  if(timer_timer_clock > 11455){ 
    enemys[200].square(375);
  }
  if(timer_timer_clock > 11490){ 
    enemys[201].square(325);
  }
  if(timer_timer_clock > 11525){ 
    enemys[202].square(275);
  }
  if(timer_timer_clock > 11560){ 
    enemys[203].square(225);
  }
  if(timer_timer_clock > 11595){ 
    enemys[204].square(175);
  }
  if(timer_timer_clock > 11620){ 
    enemys[205].square(225);
  }
  if(timer_timer_clock > 11645){ 
    enemys[206].square(275);
  }
  if(timer_timer_clock > 11670){ 
    enemys[207].square(325);
  }
  if(timer_timer_clock > 11695){ 
    enemys[208].square(375);
  }
  if(timer_timer_clock > 11720){ 
    enemys[209].square(425);
  }
  if(timer_timer_clock > 11745){ 
    enemys[210].square(475);
  }
  if(timer_timer_clock > 11770){ 
    enemys[211].square(525);
  }
  //===============(END)===============
  if(timer_timer_clock > 11800){ //completed the game
    gameComplete();
  }
  //===============(12000 = 200s)===============
}
