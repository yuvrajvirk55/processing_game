//Yuvraj Singh


//actor
actor hero;

//delaring enemys
enemy[] enemys = new enemy[300]; //number of enemys

//declaring global variables
int timer = 0; //used for score and timing enemys
int deathCounter = 0; //used to track deaths (manually resetting counts as well)
int highScore = 0; //creating counter used to show the actor's highscore
int fade = 0; //used to fade to dark when actor wins

void setup(){
  size(1000, 600);
  //initialising background music

  //initialising hero
  hero = new actor(150, 524, 50); //has x, y, and size parameters, the y and size should be left untouched 
  //initialising enemys
  for(int i = 0; i < 300; i++){
    enemys[i] = new enemy(1000); //set to 1000, which is the right-most edge of the screen
  }
}

void draw(){
  //background
  scenery();
  
  //enemys
  for(int i = 0; i < 300; i++){
    enemys[i].move(4); //initialises the move speed for all enemys
  }
  enemySpawn(); //spawns the enemys (based on timer)
  collision(); //checks collisions between enemys and hero
  
  //hero
  hero.display();
  hero.physics();
  
  //timer, scoreboard and control display
  timer();
  scoreboard(); 
  displayControls();
}

void keyPressed(){
  switch(key){
    //jump (using W)
  case 'w': //when 'w' is pressed
    hero.jump();
    break;
    
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

void collision(){
  //collision with spike
  for(int i = 0; i < 300; i++){
    if(hero.getX() > enemys[i].spikeGetX1() && hero.getX() < enemys[i].spikeGetX2()){
      if(hero._actorY > enemys[i].spikeGetY1() && hero._actorY < enemys[i].spikeGetY2()){
        println("Death by Spike");

        delay(1000);
        reset();
      }
    }
    //collision with square
    if(hero.getX() > enemys[i].squareGetX1() && hero.getX() < enemys[i].squareGetX2()){
      //if actor hits the front of the square
      if(hero._actorY > enemys[i].squareGetY1() && hero._actorY < enemys[i].squareGetY2()){
        println("Death by Square");

        delay(1000);
        reset();
      }
      if(hero.getY() < enemys[i].squareGetY1()){ //if actor hits top of the square
        hero._startY = enemys[i].squareGetY1()-26;
      }
    }
    if(hero.getX() > enemys[i].squareGetX2() && !enemys[i]._ignore){ //resets the "floor" value
      hero._startY = 524;
      enemys[i].ignore(); //sets _ignore to true
    }
  }
}

void timer(){ //timer used to determine score and enemy spawning
//Note to self: song length is 12000 on the timer
  timer += 1;
  //println(timer); //print of the timer, useful for when you are adding enemys in the spawner
}

void reset(){ //resets the game back to the beginning
  //replays music from start

  //resets timer
  timer = 0;
  //resets enemys
  for(int i = 0; i < 300; i++){
    enemys[i] = new enemy(1000);
  }
  //resets "floor"
  hero._startY = 524;
  //increments death counter (used to track deaths)
  deathCounter += 1;
  //reset win fade
  fade = 0;
}

void scoreboard(){ //scoreboard that tracks longest travelled distance
  if(timer > highScore){
    highScore = timer;
  }
  textAlign(CENTER);
  //highscore display
  textSize(35);
  fill(0);
  text("Highscore: "+highScore/60, 800, 50); //highscore is divided by 60 so each second = 1 point
  //death counter display
  fill(255);
  textSize(45);
  text(deathCounter, 500, 60);
}

void displayControls(){
  //displays controls until the timer reaches 250, i.e. until encountering the first enemy
  if(timer < 250){
    textAlign(CENTER);
    textSize(35);
    fill(0);
    text("JUMP: UP, W or SPACE", 220, 50);
  }else{ //displays current score
    textAlign(CENTER);
    textSize(35);
    fill(0);
    text("Current score: "+timer/60, 200, 50);
  }
}

void scenery(){ //this covers up the entire window, making an actual "background()" unnessecary
  //background (has several colour changes and ellipses to imitate a setting sun)
  noStroke();
  fill(205, 120, 0);
  ellipse(500, 300, 1500, 1500);
  fill(210, 125, 5);
  ellipse(500, 600, 1400, 1400);
  fill(215, 130, 10);
  ellipse(500, 600, 1300, 1300);
  fill(220, 135, 15);
  ellipse(500, 600, 1200, 1200);
  fill(225, 140, 20);
  ellipse(500, 600, 1100, 1100);
  fill(230, 145, 25);
  ellipse(500, 600, 1000, 1000);
  fill(235, 150, 30);
  ellipse(500, 600, 900, 900);
  fill(240, 155, 35);
  ellipse(500, 600, 800, 800);
  fill(245, 160, 40);
  ellipse(500, 600, 700, 700);
  fill(250, 165, 45);
  ellipse(500, 600, 600, 600);
  fill(255, 170, 50);
  ellipse(500, 600, 500, 500);
  //ground
  strokeWeight(3);
  stroke(0);
  fill(255, 50, 50, 150);
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

void enemySpawn(){ //spawns the enemys based on the timer (this part of the code is incredibly long)
/*
Notes to self: 
- floor is 525 (square) and 550 (spike)
- good timer distance for linked objects 12 (square) and 8 (spike)
- nearly 1200 lines of code for this part D:
*/
  if(timer > 150){
    enemys[1].spike(550);
  }
  if(timer > 250){
    enemys[2].spike(550);
  }
  if(timer > 350){
    enemys[3].spike(550);
  }
  if(timer > 450){
    enemys[4].spike(550);
  }
  if(timer > 525){
    enemys[5].spike(550);
  }
  if(timer > 600){
    enemys[6].spike(550);
  }
  //===============(600 = 10s)===============
  if(timer > 675){
    enemys[7].spike(550);
  }
  if(timer > 682){
    enemys[8].spike(550);
  }
  if(timer > 750){
    enemys[1].square(525);
  }
  if(timer > 780){
    enemys[2].square(475);
  }
  if(timer > 810){
    enemys[3].square(425);
  }
  if(timer > 845){
    enemys[4].square(375);
  }
  if(timer > 850){
    enemys[9].spike(550);
  }
  if(timer > 858){
    enemys[10].spike(550);
  }
  if(timer > 866){
    enemys[11].spike(550);
  }
  if(timer > 874){
    enemys[12].spike(550);
  }
  if(timer > 880){
    enemys[5].square(375);
  }
  if(timer > 882){
    enemys[13].spike(550);
  }
  if(timer > 930){ 
    enemys[6].square(375);
  }
  if(timer > 965){
    enemys[14].spike(550);
  }
  if(timer > 1005){
    enemys[15].spike(550);
  }
  if(timer > 1080){ 
    enemys[7].square(525);
  }
  if(timer > 1120){ 
    enemys[8].square(475);
  }
  if(timer > 1160){ 
    enemys[9].square(525);
  }
  if(timer > 1200){ 
    enemys[10].square(475);
  }
  //===============(1200 = 20s)===============
  if(timer > 1240){ 
    enemys[11].square(525);
  }
  if(timer > 1276){ 
    enemys[16].spike(450);
  }
  if(timer > 1280){ 
    enemys[12].square(475);
  }
  if(timer > 1330){ 
    enemys[13].square(525);
  }
  if(timer > 1338){
    enemys[17].spike(550);
  }
  if(timer > 1346){
    enemys[18].spike(550);
  }
  if(timer > 1354){
    enemys[19].spike(550);
  }
  if(timer > 1362){
    enemys[20].spike(550);
  }
  if(timer > 1450){ 
    enemys[14].square(525);
  }
  if(timer > 1500){ 
    enemys[15].square(475);
  }
  if(timer > 1524){ 
    enemys[16].square(525);
  }
  if(timer > 1572){
    enemys[21].spike(550);
  }
  if(timer > 1650){
    enemys[22].spike(550);
  }
  if(timer > 1658){
    enemys[23].spike(550);
  }
  if(timer > 1690){
    enemys[24].spike(550);
  }
  if(timer > 1698){
    enemys[25].spike(550);
  }
  if(timer > 1730){
    enemys[26].spike(550);
  }
  if(timer > 1738){
    enemys[27].spike(550);
  }
  if(timer > 1775){
    enemys[28].spike(550);
  }
  //===============(1800 = 30s)===============
  if(timer > 1830){
    enemys[29].spike(550);
  }
  if(timer > 1838){
    enemys[30].spike(550);
  }
  if(timer > 1870){
    enemys[31].spike(550);
  }
  if(timer > 1878){
    enemys[32].spike(550);
  }
  if(timer > 1940){
    enemys[33].spike(550);
  }
  if(timer > 2000){
    enemys[34].spike(550);
  }
  if(timer > 2008){
    enemys[35].spike(550);
  }
  if(timer > 2040){
    enemys[36].spike(550);
  }
  if(timer > 2048){
    enemys[37].spike(550);
  }
  if(timer > 2080){
    enemys[38].spike(550);
  }
  if(timer > 2088){
    enemys[39].spike(550);
  }
  if(timer > 2160){ 
    enemys[17].square(525);
  }
  if(timer > 2200){ 
    enemys[18].square(475);
  }
  if(timer > 2220){
    enemys[40].spike(500);
    enemys[41].spike(550);
  }
  if(timer > 2240){ 
    enemys[19].square(475);
  }
  if(timer > 2275){ 
    enemys[20].square(425);
  }
  if(timer > 2310){ 
    enemys[21].square(375);
  }
  if(timer > 2345){ 
    enemys[22].square(325);
  }
  if(timer > 2365){ 
    enemys[23].square(375);
  }
  if(timer > 2400){ 
    enemys[24].square(325);
  }
  //===============(2400 = 40s)===============
  if(timer > 2414){ 
    enemys[42].spike(550);
  }
  if(timer > 2422){ 
    enemys[43].spike(550);
  }
  if(timer > 2430){ 
    enemys[44].spike(550);
  }
  if(timer > 2438){ 
    enemys[45].spike(550);
  }
  if(timer > 2550){ 
    enemys[25].square(525);
  }
  if(timer > 2590){ 
    enemys[26].square(475);
  }
  if(timer > 2630){ 
    enemys[27].square(525);
  }
  if(timer > 2670){ 
    enemys[28].square(475);
  }
  if(timer > 2706){ 
    enemys[46].spike(550);
  }
  if(timer > 2714){ 
    enemys[47].spike(550);
  }
  if(timer > 2760){ 
    enemys[29].square(525);
  }
  if(timer > 2800){ 
    enemys[30].square(475);
  }
  if(timer > 2840){ 
    enemys[31].square(525);
  }
  if(timer > 2880){ 
    enemys[32].square(475);
  }
  if(timer > 2916){ 
    enemys[48].spike(550);
  }
  if(timer > 2924){ 
    enemys[49].spike(550);
  }
  if(timer > 2970){ 
    enemys[33].square(525);
  }
  //===============(3000 = 50s)===============
  if(timer > 3010){ 
    enemys[34].square(475);
  }
  if(timer > 3050){ 
    enemys[35].square(525);
  }
  if(timer > 3090){ 
    enemys[36].square(475);
  }
  if(timer > 3125){ 
    enemys[37].square(425);
  }
  if(timer > 3130){ 
    enemys[50].spike(550);
  }
  if(timer > 3138){ 
    enemys[51].spike(550);
  }
  if(timer > 3146){ 
    enemys[52].spike(550);
  }
  if(timer > 3154){ 
    enemys[53].spike(550);
  }
  if(timer > 3160){ 
    enemys[38].square(375);
  }
  if(timer > 3210){ 
    enemys[54].spike(550);
  }
  if(timer > 3250){ 
    enemys[55].spike(550);
  }
  if(timer > 3258){ 
    enemys[56].spike(550);
  }
  if(timer > 3274){ 
    enemys[39].square(525);
  }
  if(timer > 3282){ 
    enemys[57].spike(550);
  }
  if(timer > 3290){ 
    enemys[58].spike(550);
  }
  if(timer > 3350){ 
    enemys[59].spike(550);
  }
  if(timer > 3358){ 
    enemys[60].spike(550);
  }
  if(timer > 3374){ 
    enemys[40].square(525);
  }
  if(timer > 3382){ 
    enemys[61].spike(550);
  }
  if(timer > 3390){ 
    enemys[62].spike(550);
  }
  if(timer > 3450){ 
    enemys[63].spike(550);
  }
  if(timer > 3458){ 
    enemys[64].spike(550);
  }
  if(timer > 3474){ 
    enemys[41].square(525);
  }
  if(timer > 3482){ 
    enemys[65].spike(550);
  }
  if(timer > 3490){ 
    enemys[66].spike(550);
  }
  if(timer > 3540){ 
    enemys[67].spike(550);
  }
  if(timer > 3548){ 
    enemys[68].spike(550);
  }
  if(timer > 3564){ 
    enemys[42].square(525);
  }
  if(timer > 3572){ 
    enemys[69].spike(550);
  }
  if(timer > 3580){ 
    enemys[70].spike(550);
  }
  //===============(3600 = 60s)===============
  if(timer > 3650){ 
    enemys[43].square(525);
  }
  if(timer > 3690){ 
    enemys[44].square(475);
  }
  if(timer > 3725){ 
    enemys[45].square(425);
  }
  if(timer > 3760){ 
    enemys[46].square(375);
  }
  if(timer > 3795){ 
    enemys[47].square(325);
  }  
  if(timer > 3830){ 
    enemys[48].square(275);
  }
  if(timer > 3838){ 
    enemys[71].spike(550);
  }
  if(timer > 3846){ 
    enemys[72].spike(550);
  }
  if(timer > 3854){ 
    enemys[73].spike(550);
  }
  if(timer > 3862){ 
    enemys[74].spike(550);
  }
  if(timer > 4000){ 
    enemys[49].square(525);
  }
  if(timer > 4040){ 
    enemys[50].square(475);
  }
  if(timer > 4075){ 
    enemys[51].square(425);
  }
  if(timer > 4110){ 
    enemys[52].square(375);
  }
  if(timer > 4145){ 
    enemys[53].square(325);
  }  
  if(timer > 4180){ 
    enemys[54].square(275);
  }
  if(timer > 4188){ 
    enemys[75].spike(550);
  }
  if(timer > 4196){ 
    enemys[76].spike(550);
  }
  //===============(4200 = 70s)===============
  if(timer > 4204){ 
    enemys[77].spike(550);
  }
  if(timer > 4212){ 
    enemys[78].spike(550);
  }
  if(timer > 4300){ 
    enemys[55].square(525);
  }
  if(timer > 4340){ 
    enemys[56].square(475);
  }
  if(timer > 4375){ 
    enemys[57].square(425);
  }
  if(timer > 4410){ 
    enemys[58].square(375);
  }
  if(timer > 4445){ 
    enemys[59].square(325);
  }  
  if(timer > 4480){ 
    enemys[60].square(275);
  }
  if(timer > 4488){ 
    enemys[79].spike(550);
  }
  if(timer > 4496){ 
    enemys[80].spike(550);
  }
  if(timer > 4504){ 
    enemys[81].spike(550);
  }
  if(timer > 4512){ 
    enemys[82].spike(550);
  }
  if(timer > 4600){ 
    enemys[83].spike(550);
  }
  if(timer > 4650){ 
    enemys[84].spike(500);
  }
  if(timer > 4700){ 
    enemys[85].spike(550);
  }
  if(timer > 4750){ 
    enemys[86].spike(515);
    enemys[87].spike(550);
  }
  if(timer > 4800){ 
    enemys[88].spike(550);
  }
  //===============(4800 = 80s)===============
  if(timer > 4850){ 
    enemys[89].spike(500);
  }
  if(timer > 4900){ 
    enemys[90].spike(550);
  }
  if(timer > 4950){ 
    enemys[91].spike(515);
    enemys[92].spike(550);
  }
  if(timer > 5000){ 
    enemys[93].spike(550);
  }
  if(timer > 5008){ 
    enemys[94].spike(550);
  }
  if(timer > 5046){ 
    enemys[95].spike(550);
  }
  if(timer > 5100){ 
    enemys[96].spike(515);
    enemys[97].spike(550);
  }
  if(timer > 5170){ 
    enemys[98].spike(515);
    enemys[99].spike(550);
  }
  if(timer > 5230){ 
    enemys[100].spike(515);
    enemys[101].spike(550);
  }
  if(timer > 5280){ 
    enemys[102].spike(515);
    enemys[103].spike(550);
  }
  if(timer > 5330){ 
    enemys[104].spike(515);
    enemys[105].spike(550);
  }
  if(timer > 5380){ 
    enemys[106].spike(515);
    enemys[107].spike(550);
  }
  //===============(5400 = 90s)===============
  if(timer > 5500){
    enemys[61].square(525);
  }
  if(timer > 5540){
    enemys[62].square(475);
  }
  if(timer > 5575){
    enemys[63].square(425);
  }
  if(timer > 5605){
    enemys[64].square(375);
  }
  if(timer > 5625){
    enemys[65].square(425);
  }
  if(timer > 5640){ 
    enemys[108].spike(550);
  }
  if(timer > 5648){ 
    enemys[109].spike(400);
    enemys[110].spike(550);
  }
  if(timer > 5656){ 
    enemys[111].spike(400);
    enemys[112].spike(550);
  }
  if(timer > 5750){
    enemys[66].square(525);
  }
  if(timer > 5790){
    enemys[67].square(475);
  }
  if(timer > 5825){
    enemys[68].square(425);
  }
  if(timer > 5860){
    enemys[69].square(375);
  }
  if(timer > 5860){ 
    enemys[113].spike(515);
    enemys[114].spike(550);
  }
  if(timer > 5876){ 
    enemys[115].spike(515);
    enemys[116].spike(550);
  }
  if(timer > 5950){
    enemys[70].square(525);
  }
  if(timer > 5990){
    enemys[71].square(475);
  }
  //===============(6000 = 100s)===============
  if(timer > 6025){
    enemys[72].square(425);
    enemys[117].spike(550);
  }
  if(timer > 6060){
    enemys[73].square(375);
  }
  if(timer > 6068){ 
    enemys[118].spike(350);
  }
  if(timer > 6076){ 
    enemys[119].spike(350);
  }
  if(timer > 6084){ 
    enemys[120].spike(350);
  }
  if(timer > 6092){ 
    enemys[121].spike(350);
  }
  if(timer > 6200){
    enemys[74].square(525);
  }
  if(timer > 6240){
    enemys[75].square(475);
  }
  if(timer > 6275){
    enemys[76].square(425);
  }
  if(timer > 6310){
    enemys[77].square(375);
  }
  if(timer > 6318){ 
    enemys[122].spike(350);
  }
  if(timer > 6326){ 
    enemys[123].spike(350);
  }
  if(timer > 6334){ 
    enemys[124].spike(350);
  }
  if(timer > 6342){ 
    enemys[125].spike(350);
  }
  if(timer > 6450){
    enemys[78].square(525);
  }
  if(timer > 6490){
    enemys[79].square(475);
  }
  if(timer > 6525){
    enemys[80].square(425);
  }
  if(timer > 6560){
    enemys[81].square(375);
  }
  if(timer > 6560){ 
    enemys[126].spike(515);
    enemys[127].spike(550);
  }
  if(timer > 6576){ 
    enemys[128].spike(515);
    enemys[129].spike(550);
  }
  //===============(6600 = 110s)===============
  if(timer > 6700){ 
    enemys[82].square(525);
  }
  if(timer > 6740){ 
    enemys[83].square(475);
  }
  if(timer > 6775){ 
    enemys[84].square(425);
  }
  if(timer > 6791){ 
    enemys[130].spike(400);
  }
  if(timer > 6799){ 
    enemys[131].spike(400);
  }
  if(timer > 6820){ 
    enemys[85].square(425);
  }
  if(timer > 6836){ 
    enemys[132].spike(400);
  }
  if(timer > 6844){ 
    enemys[133].spike(400);
  }
  if(timer > 6865){ 
    enemys[86].square(425);
  }
  if(timer > 6881){ 
    enemys[134].spike(400);
  }
  if(timer > 6889){ 
    enemys[135].spike(400);
  }
  if(timer > 6910){ 
    enemys[87].square(425);
  }
  if(timer > 6945){ 
    enemys[88].square(375);
  }
  if(timer > 6980){ 
    enemys[89].square(325);
  }
  if(timer > 6996){ 
    enemys[136].spike(300);
  }
  if(timer > 7004){ 
    enemys[137].spike(300);
  }
  if(timer > 7025){ 
    enemys[90].square(325);
  }
  if(timer > 7041){ 
    enemys[138].spike(300);
  }
  if(timer > 7049){ 
    enemys[139].spike(300);
  }
  if(timer > 7070){ 
    enemys[91].square(325);
  }
  if(timer > 7086){ 
    enemys[140].spike(300);
  }
  if(timer > 7094){ 
    enemys[141].spike(300);
  }
  if(timer > 7115){ 
    enemys[92].square(325);
  }
  if(timer > 7135){ 
    enemys[93].square(375);
  }
  if(timer > 7155){ 
    enemys[94].square(425);
  }
  if(timer > 7175){ 
    enemys[95].square(475);
  }
  if(timer > 7191){ 
    enemys[142].spike(450);
  }
  if(timer > 7199){ 
    enemys[143].spike(450);
  }
  //===============(7200 = 120s)===============
  if(timer > 7220){ 
    enemys[96].square(475);
  }
  if(timer > 7236){ 
    enemys[144].spike(450);
  }
  if(timer > 7244){ 
    enemys[145].spike(450);
  }
  if(timer > 7265){ 
    enemys[97].square(475);
  }
  if(timer > 7281){ 
    enemys[146].spike(450);
    enemys[147].spike(550);
  }
  if(timer > 7289){ 
    enemys[148].spike(450);
    enemys[149].spike(550);
  }
  if(timer > 7310){ 
    enemys[98].square(475);
  }
  if(timer > 7335){ 
    enemys[99].square(525);
  }
  if(timer > 7380){ 
    enemys[150].spike(550);
  }
  if(timer > 7388){ 
    enemys[151].spike(550);
  }
  if(timer > 7433){ 
    enemys[152].spike(550);
  }
  if(timer > 7441){ 
    enemys[153].spike(550);
  }
  if(timer > 7536){ 
    enemys[154].spike(550);
  }
  if(timer > 7550){ 
    enemys[100].square(525);
  }
  if(timer > 7571){ 
    enemys[155].spike(500);
  }
  if(timer > 7585){ 
    enemys[101].square(475);
  }
  if(timer > 7606){ 
    enemys[156].spike(450);
  }
  if(timer > 7620){ 
    enemys[102].square(425);
  }
  if(timer > 7641){ 
    enemys[157].spike(400);
  }
  if(timer > 7655){ 
    enemys[103].square(375);
  }
  if(timer > 7680){ 
    enemys[104].square(425);
  }
  if(timer > 7715){ 
    enemys[105].square(375);
  }
  if(timer > 7750){ 
    enemys[106].square(325);
  }
  if(timer > 7775){ 
    enemys[107].square(375);
  }
  //===============(7800 = 130s)===============
  if(timer > 7810){ 
    enemys[108].square(325);
  }
  if(timer > 7835){ 
    enemys[109].square(375);
  }
  if(timer > 7860){ 
    enemys[110].square(425);
    enemys[158].spike(550);
  }
  if(timer > 7868){ 
    enemys[159].spike(550);
  }
  if(timer > 7885){ 
    enemys[111].square(475);
  }
  if(timer > 7910){ 
    enemys[112].square(525);
  }
  if(timer > 7945){ 
    enemys[113].square(475);
  }
  if(timer > 7970){ 
    enemys[114].square(525);
  }
  if(timer > 8005){ 
    enemys[115].square(475);
  }
  if(timer > 8040){ 
    enemys[116].square(425);
  }
  if(timer > 8065){ 
    enemys[117].square(475);
  }
  if(timer > 8100){ 
    enemys[118].square(425);
  }
  if(timer > 8135){ 
    enemys[119].square(375);
  }
  if(timer > 8160){ 
    enemys[120].square(425);
  }
  if(timer > 8195){ 
    enemys[121].square(375);
  }
  if(timer > 8220){ 
    enemys[122].square(425);
  }
  if(timer > 8255){ 
    enemys[123].square(375);
  }
  if(timer > 8290){ 
    enemys[124].square(325);
  }
  if(timer > 8315){ 
    enemys[125].square(375);
  }
  if(timer > 8350){ 
    enemys[126].square(325);
  }
  if(timer > 8375){ 
    enemys[127].square(375);
  }
  if(timer > 8400){ 
    enemys[128].square(425);
  }
  //===============(8400 = 140s)===============
  if(timer > 8408){ 
    enemys[160].spike(550);
  }
  if(timer > 8416){ 
    enemys[161].spike(550);
  }
  if(timer > 8424){ 
    enemys[162].spike(550);
  }
  if(timer > 8432){ 
    enemys[163].spike(550);
  }
  if(timer > 8445){ 
    enemys[129].square(425);
  }
  if(timer > 8470){ 
    enemys[130].square(475);
  }
  if(timer > 8495){ 
    enemys[131].square(525);
  }
  if(timer > 8600){ 
    enemys[132].square(525);
  }
  if(timer > 8640){ 
    enemys[133].square(475);
  }
  if(timer > 8648){ 
    enemys[164].spike(450);
  }
  if(timer > 8656){ 
    enemys[165].spike(450);
  }
  if(timer > 8664){ 
    enemys[166].spike(450);
  }
  if(timer > 8750){ 
    enemys[134].square(525);
  }
  if(timer > 8790){ 
    enemys[135].square(475);
  }
  if(timer > 8798){ 
    enemys[167].spike(550);
  }
  if(timer > 8806){ 
    enemys[168].spike(550);
  }
  if(timer > 8814){ 
    enemys[169].spike(550);
  }
  if(timer > 8900){ 
    enemys[136].square(525);
  }
  if(timer > 8940){ 
    enemys[137].square(475);
  }
  if(timer > 8948){ 
    enemys[170].spike(550);
  }
  if(timer > 8956){ 
    enemys[171].spike(550);
  }
  if(timer > 8964){ 
    enemys[172].spike(550);
  }
  //===============(9000 = 150s)===============
  if(timer > 9050){ 
    enemys[138].square(525);
  }
  if(timer > 9058){ 
    enemys[173].spike(550);
  }
  if(timer > 9066){ 
    enemys[174].spike(550);
  }
  if(timer > 9074){ 
    enemys[175].spike(550);
  }
  if(timer > 9090){ 
    enemys[139].square(525);
  }
  if(timer > 9130){ 
    enemys[140].square(475);
  }
  if(timer > 9165){ 
    enemys[141].square(425);
  }
  if(timer > 9205){ 
    enemys[142].square(425);
  }
  if(timer > 9230){ 
    enemys[143].square(475);
  }
  if(timer > 9275){ 
    enemys[144].square(475);
  }
  if(timer > 9305){ 
    enemys[145].square(425);
  }
  if(timer > 9340){ 
    enemys[146].square(375);
  }
  if(timer > 9385){ 
    enemys[147].square(375);
  }
  if(timer > 9410){ 
    enemys[148].square(425);
  }
  if(timer > 9455){ 
    enemys[149].square(425);
  }
  if(timer > 9490){ 
    enemys[150].square(375);
  }
  if(timer > 9535){ 
    enemys[151].square(375);
  }
  if(timer > 9560){ 
    enemys[152].square(425);
  }
  if(timer > 9560){ 
    enemys[176].spike(550);
  }
  if(timer > 9568){ 
    enemys[177].spike(550);
  }
  if(timer > 9585){ 
    enemys[153].square(475);
  }
  if(timer > 9610){ 
    enemys[154].square(525);
  }
  //===============(9600 = 160s)===============
  if(timer > 9655){ 
    enemys[155].square(525);
  }
  if(timer > 9690){ 
    enemys[156].square(475);
  }
  if(timer > 9725){ 
    enemys[157].square(425);
  }
  if(timer > 9760){ 
    enemys[158].square(375);
  }
  if(timer > 9795){ 
    enemys[159].square(325);
  }
  if(timer > 9830){ 
    enemys[160].square(275);
  }
  if(timer > 9865){ 
    enemys[161].square(225);
  }
  if(timer > 9900){ 
    enemys[162].square(175);
  }
  if(timer > 9960){ 
    enemys[163].square(475);
  }
  if(timer > 9985){ 
    enemys[164].square(525);
  }
  if(timer > 9990){ 
    enemys[165].square(425);
  }
  if(timer > 9993){ 
    enemys[178].spike(550);
  }
  if(timer > 10001){ 
    enemys[179].spike(550);
  }
  if(timer > 10035){ 
    enemys[166].square(425);
  }
  if(timer > 10070){ 
    enemys[167].square(375);
  }
  if(timer > 10105){ 
    enemys[168].square(325);
  }
  if(timer > 10130){ 
    enemys[169].square(375);
  }
  if(timer > 10165){ 
    enemys[170].square(325);
  }
  if(timer > 10190){ 
    enemys[171].square(375);
  }
  //===============(10200 = 170s)===============
  if(timer > 10235){ 
    enemys[172].square(325);
  }
  if(timer > 10260){ 
    enemys[173].square(375);
  }
  if(timer > 10305){ 
    enemys[174].square(325);
  }
  if(timer > 10330){ 
    enemys[175].square(375);
  }
  if(timer > 10355){ 
    enemys[176].square(425);
  }
  if(timer > 10363){ 
    enemys[180].spike(550);
  }
  if(timer > 10371){ 
    enemys[181].spike(550);
  }
  if(timer > 10380){ 
    enemys[177].square(475);
  }
  if(timer > 10425){ 
    enemys[178].square(475);
  }
  if(timer > 10470){ 
    enemys[179].square(475);
  }
  if(timer > 10495){ 
    enemys[180].square(525);
  }
  if(timer > 10600){ 
    enemys[181].square(525);
  }
  if(timer > 10635){ 
    enemys[182].square(475);
  }
  if(timer > 10670){ 
    enemys[183].square(425);
  }
  if(timer > 10705){ 
    enemys[184].square(375);
  }
  if(timer > 10740){ 
    enemys[185].square(325);
  }
  if(timer > 10775){ 
    enemys[186].square(275);
  }
  //===============(10800 = 180s)===============
  if(timer > 10810){ 
    enemys[187].square(225);
  }
  if(timer > 10845){ 
    enemys[188].square(175);
  }
  if(timer > 10870){ 
    enemys[189].square(225);
  }
  if(timer > 10895){ 
    enemys[190].square(275);
  }
  if(timer > 10920){ 
    enemys[191].square(325);
  }
  if(timer > 10945){ 
    enemys[192].square(375);
  }
  if(timer > 10970){ 
    enemys[193].square(425);
  }
  if(timer > 10995){ 
    enemys[194].square(475);
  }
  if(timer > 11020){ 
    enemys[195].square(525);
  }
  if(timer > 11100){ 
    enemys[182].spike(550);
  }
  if(timer > 11116){ 
    enemys[183].spike(450);
  }
  if(timer > 11132){ 
    enemys[184].spike(350);
  }
  if(timer > 11150){ 
    enemys[196].square(525);
    enemys[185].spike(300);
  }
  if(timer > 11166){ 
    enemys[186].spike(350);
  }
  if(timer > 11184){ 
    enemys[187].spike(450);
  }
  if(timer > 11200){ 
    enemys[188].spike(550);
  }
  if(timer > 11350){ 
    enemys[197].square(525);
  }
  if(timer > 11385){ 
    enemys[198].square(475);
  }
  //===============(11400 = 190s)===============
  if(timer > 11420){ 
    enemys[199].square(425);
  }
  if(timer > 11455){ 
    enemys[200].square(375);
  }
  if(timer > 11490){ 
    enemys[201].square(325);
  }
  if(timer > 11525){ 
    enemys[202].square(275);
  }
  if(timer > 11560){ 
    enemys[203].square(225);
  }
  if(timer > 11595){ 
    enemys[204].square(175);
  }
  if(timer > 11620){ 
    enemys[205].square(225);
  }
  if(timer > 11645){ 
    enemys[206].square(275);
  }
  if(timer > 11670){ 
    enemys[207].square(325);
  }
  if(timer > 11695){ 
    enemys[208].square(375);
  }
  if(timer > 11720){ 
    enemys[209].square(425);
  }
  if(timer > 11745){ 
    enemys[210].square(475);
  }
  if(timer > 11770){ 
    enemys[211].square(525);
  }
  //===============(END)===============
  if(timer > 11800){ //completed the game
    gameComplete();
  }
  //===============(12000 = 200s)===============
}
