/*************
 **  BOHN_Semester_Project.pde
 **  Richard Ho, Mark Nay, Sriram Batchu, Daivd Onwonga
 **  12/4/2020
 **  Section: Innovation 
 **  Email: fj08732@umbc.edu
 **  UMBC LIFE SIM 2020 - QUARANTINE EDITION
 **  The player can choose what he/she wants to do within 7 days of the week
 **  scores are calculated base on what action he/she choose to do
 **  at the end of the 15 weeks, the player have finish the game
 */

  /* We streamlined our game since the demo. It includes fewer screens with 
  more pictures. We also now have a fully functional scoring system and a game that
  lasts a whole semester. 
  */
//All the images we use
PImage img;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
//set press,press2,press3 false so buttons dont over lap
boolean press = false;
boolean press2 = false;
boolean press3 = false;
//set dropOut to be true on the start screen
boolean dropOut = true;
//set maxDay to true so the player can click only 7 different option though out the week
boolean maxDay = true;
//set stop to true, until it turns false all the buttons stop working
boolean stop = true;
//set eraseButton to false so the continue button dont overlap on weeklevel screen
boolean eraseButton = false;
//Varibale level to 1 since start game on week 1
int level = 1;
//starting score values
int gradesScore = 48;
int wealthScore = 0;
int stressScore = 10;
int happinessScore = 65;
int totalGameScore = 0;
//Variable numDay to 0 so players can have 7 attempts during the week
int numDay = 0;

/*
* setup - prepares environment size
* put a blackbackground and the startscreen
* where players start at when logging in the game
  */
void setup() {
  background (0);
  size (1200, 700);
  startScreen();
}

/*
* draw - allow instruction screen to pop up
* if press becomes true function mainScreen runs
* if press2 beomces true function endWeek runs
* if press3 beocmes true function weekLevel runs
* skipGame allows designers to skip to the endScreen by clicking 1
* sets a maxinum of 7 actions during a week 
* if level reaches 16 int stop turns false, which stops
* the buttons in mousePressed and endscreen runs
  */
void draw() {
  //keyControl - allows intructionScreen to pop up if key "h" or "H" are press
  //if key "b" or "B" are press startScreen pop ups
  keyControls();
  //press becomes true when start game is clicked
  if (press == true) {
    mainScreen();
  }
  //press2 becomes true if Next Week button is clicked
  if (press2 == true) {
    endWeek();
  }
  //press3 becomes true if continue button is clicked
  if(press3 == true) {
    weekLevel();
  }
  // if key 1 is pressed endscreen runs; if key 2 is pressed endweek runs
  skipGame();  
  // sets maxinum attempts to be 7 during a week
  limitAttempts();
  // if level equal to 16 endscreen runs and stop becomes false
  if (level == 16) {
    endScreen();
    stop = false;
  }
}

/*
* mousePressed - allows players to engaged the buttons named
* "Start Game", "Exit", "Zoom with Friends", "Office Hours",
* "Play Video Games", "Go To Class", "Study", "Party",
* " Work Your Job", "Next Week", "Continue", and "Start Next Week"
  */
void mousePressed() {
  //press Start Game makes press equal true
  if(stop == true) {
    if (mouseX>950 && mouseX<1150 && mouseY>550 && mouseY<650) {
      press = true;
      dropOut = false;
    }
  }
  //Exit screen dropOut is true unless player clicked on Start Game makes dropOut equal false
  if(dropOut == true) {
    if (mouseX>50 && mouseX<250 && mouseY>550 && mouseY<650) {
      dropOutScreen();
    }
  }
  //Stop is true until level equal 16, then stop becomes false
  if(stop == true) {
    // maxDay is true until numDay equal 7; maxDay equal true again only after numDay is back to 0 
    // this function happens in limitAttempt()
    if(maxDay == true) {
      //when clicking on Zoom with Friends button; decrease stress score, increase happiness score
      if (mouseX>50 && mouseX<250 && mouseY>140 && mouseY<220) {
        happinessScore = happinessScore + 1;
        stressScore = stressScore - 1;
        numDay = numDay + 1;
      }
      //when clicking Office Hours button; increase grades score, decrease stress score
      if (mouseX>50 && mouseX<250 && mouseY>340 && mouseY<420) {
        gradesScore = gradesScore + 3/2;
        stressScore = stressScore - 1;
        numDay = numDay + 1;
      }
      //when click Play Video Games button; increase happiness score, decrease stress and game score
      if (mouseX>50 && mouseX<250 && mouseY>567 && mouseY<647) {
        happinessScore = happinessScore + 5;
        stressScore = stressScore - 3;
        gradesScore = gradesScore - 4;
        numDay = numDay + 1;
      }
      //when click Go To Class button; increase grades score, increase stress score
      if (mouseX>450 && mouseX<650 && mouseY>567 && mouseY<647) {
        gradesScore = gradesScore + 1;
        stressScore = stressScore + 1/2;
        numDay = numDay + 1;
      }
      //when click Study button; increase grades score, increase stress score
      if (mouseX>890 && mouseX<1090 && mouseY>567 && mouseY<647) {
        gradesScore = gradesScore + 2;
        stressScore = stressScore + 3/2;
        numDay = numDay + 1;
      }
      //when click Party button; decrease grade score, increase happiness score
      if (mouseX>890 && mouseX<1090 && mouseY>340 && mouseY<420) {
        gradesScore = gradesScore - 3;
        happinessScore = happinessScore + 3;
        numDay = numDay + 1;
      }  
      //when click Work your Job button; increase wealth score, decrease grade score, increase stress score
      if (mouseX>890 && mouseX<1090 && mouseY>140 && mouseY<220) {
        wealthScore = wealthScore + 7;
        gradesScore = gradesScore - 2;
        stressScore = stressScore + 4;
        numDay = numDay + 1;
      }
    }
  }
  //Stop is true until level equal 16, then stop becomes false
  if(stop == true) {
    //When click on the Next Week button; takes to the break screen only if numDay equal 7
    if(numDay == 7){
      if (mouseX>1000 && mouseX<1190 && mouseY>466 && mouseY<516) {
        press2 = true;
        press = false;
        eraseButton = true;
      }
    }
    //eraseButton equal true after clicking on "Next Week button"
    if(eraseButton == true) {
      //when click on the continue button; takes to weekLevel,
      if (mouseX>950 && mouseX<1150 && mouseY>395 && mouseY<440) {
          press2 = false;
          press3 = true;
          eraseButton = false;
          //Allows the week level to add 1 each time continue button is clicked
          level = level + 1;
      }
    }
    //When click on the Start Next Week button; takes to the main screen
     if (mouseX>510 && mouseX<710 && mouseY>430 && mouseY<480) {
       press = true;
       press2 = false;
       press3 = false;
       eraseButton = false;
       //set numDay equal 0 so maxDay can equal true
       numDay = 0;
     }
   }
}

/*
* startScreen - The screen where player start in the beginning
  */
void startScreen() {
  //print "UMBC LIFE SIM 2020 - QUARANTINE EDITION" on the screen
  background(0);
  textSize(32);
  fill(255, 223, 0); 
  text("UMBC LIFE SIM 2020 - QUARANTINE EDITION", 255, 70);
  //print "Campus life has never been so lonely" on the screen 
  textSize(16);
  fill(255);
  textSize(26);
  text("Campus life has never been so lonely", 350, 120);
  img = loadImage("Online Learning.jpg");
  image(img, 450, 250);
  //print "Press H on your keyboard for how to play the game" on the screen
  textSize(24);
  fill(255, 0, 0);
  text("Press H on your keyboard for how to play the game", 300, 500); 
  //delcares button1 and button2 as a new int
  Buttons buttons1 = new Buttons ();
  Buttons buttons2 = new Buttons ();
  //Exit button
  fill(255, 223, 0);
  rect(buttons1.x, buttons1.y, buttons1.buttonSizeX, buttons1.buttonSizeY);
  fill(0);
  textSize(32);
  text("Exit Game", 75, 615);
  fill(255, 223, 0);
  //start button
  rect(buttons2.x + 900, buttons2.y, buttons1.buttonSizeX, buttons1.buttonSizeY);
  fill(0);
  textSize(32);
  text("Start Game", 970, 615);
}

/*
* instructionScreen - 
  */
void instructionScreen() {
  background(0);
  textSize(32);
  fill(255, 223, 0);
  text("How to play the game", 430, 50);
  textSize(24);
  fill(255);
  text("Welcome to UMBC Life Sim 2020. This game is designed for college students to help improve", 50, 100);
  text("their decision making and realize the opportunity costs which come with the game. To get started", 48, 125);
  text(" please read the instructions below.", 40, 150);
  textSize(32);
  fill(255, 0, 0);
  text("Instructions:", 500, 250);
  textSize(24);
  fill(0, 0, 255);
  text("1. On the start screen, press the start button using your mouse", 48, 300);
  text("2. Once you clicked the start button, you will notice that there are multiple buttons around the", 48, 325);
  text("screen. You can click each button up to 7 times as a representaion for what you have done for one", 48, 350);
  text("day.", 48, 375);
  text("3. Point values for stress, weath, happiness and grades will change for each activity clicked.", 48, 400);
  text("4. After clicking a button for what activity you have done each day, click the next week button", 48, 425);
  text("after 7 days is up and take you to the next week", 48, 450);
  text("After 15 weeks, the game ends displaying your final score.", 48, 475);
  textSize(32);
  fill(0, 255, 0);
  text("Press B on your keyboard to return to the start screen", 190, 600);
}

/*
* mainScreen - loads up all the button use on this screen and postions
* the boxes/buttons and an image
  */
void mainScreen() {
  background(0);
  img3 = loadImage("Working.png");
  image(img3, 325, 130);
  textSize(32);
  //Track the number of days
  fill(255, 255, 150);
  rect(600, 65, 150, 60, 7);
  fill(0);
  text("Day:" + numDay, 630, 105);
  //Track the week goes by
  fill(255, 255, 150);
  rect(400, 65, 150, 60, 7);
  fill(0);
  text("Week:" + level, 420, 105);
  //work job button
  fill(255, 255, 150);
  rect(890, 140, 200, 80, 7);
  fill(0, 0, 255);
  text("Work your", 900, 170);
  text("job", 960, 210);
  fill(0, 0, 255);
  //study button
  fill(255, 255, 150);
  rect(890, 567, 200, 80, 7);
  fill(0, 0, 255);
  text("Study", 945, 620);
  //go to class button
  fill(255, 255, 150);
  rect(450, 567, 200, 80, 7);
  fill(0, 0, 255);
  text("Go to Class", 461, 617);
  //recreation box (video games for now)
  fill(255, 255, 150);
  rect(50, 567, 200, 80, 7);
  fill(0, 0, 255);
  text("Play Video", 68, 605);
  text("Games", 68, 635);
  //zoom with friends button
  fill(255, 255, 150);
  rect(50, 140, 200, 80, 7);
  fill(0, 0, 255);
  text("Zoom with", 65, 170);
  text("Friends", 65, 210);
  //office hours buttton
  fill(255, 255, 150);
  rect(50, 340, 200, 80, 7);
  fill(0, 0, 255);
  text("Office Hours", 54, 390);
  //party button
  fill(255, 255, 150);
  rect(890, 340, 200, 80, 7);
  fill(0, 0, 255);
  text("Party", 950, 390);
  //Next Week button
  fill(255, 223, 0);
  rect(1000, 466, 190, 50, 7);
  fill(0);
  text("Next Week", 1015, 500);
  //run scoreBoard when mainScreen is called
  scoreBoard();
}

/*
* endWeek - shows the end of the week screen and the continue button 
*/
void endWeek() {
  //studying screen
  background(0);
  img4 = loadImage("Weekend Picture 1.jpg");
  image(img4, 10, 130);
  scoreBoard();
  //Calculate total score by adding the others scores together
  totalGameScore = (gradesScore + wealthScore + happinessScore) - stressScore;
  //Print out the words "Take a Breather!" and 
  //"Are you Ready for Next Week?"
  textSize(50);
  fill(0,0,255);
  text("Take a Breather!", 700, 170);
  text("Are you Ready for Next Week?", 450, 600);
  // delcaring button1 and button3 as new int
  Buttons buttons1 = new Buttons ();
  Buttons buttons3 = new Buttons ();
  //Continue button location and size
  fill(255, 223, 0);
  textSize(16);
  rect(buttons3.x + 900, buttons3.y-155, buttons1.buttonSizeX, buttons1.buttonSizeY-55);
  fill(0);
  text("Continue", 970, 425);
}

/*
* dropOutScreen - shows the a screen when Exit button is clicked 
  */
void dropOutScreen() {
  background(0);
  noLoop();
  fill(255, 223, 0);
  textSize(55);
  text("YOU ARE NOW A DROPOUT, GOODLUCK!", CENTER + 67, 350);
}

/*
* endScreen - shows the finish game screen
  */
void endScreen() {
  background(0);
  img5 = loadImage("End Screen Image.png");
  image(img5, 10, 230);
  rect(555, 350, 560, 45);
  fill(0, 0, 255);
  textSize(100);
  text("You Survived", 500, 270);
  text("the Semester!", 500, 380);
  scoreBoard();
}

/*
* ScoreBoard - Shows the scores of total points, stress,
* wealth, happiness, and grades
  */
void scoreBoard() {
  //Total Points' location and size
  fill(255, 223, 0);
  rect(50, 10, 200, 95, 7);
  textSize(24);
  fill(0);
  text("Total Points: " + totalGameScore, 52, 65);
  //Stress box's location and size
  fill(255, 223, 0);
  rect(300, 20, 200, 45);
  fill(0);
  text("Stress: " + stressScore, 310, 50);
  //Wealth box's location and size
  fill(255, 223, 0);
  rect(500, 20, 200, 45);
  fill(0);
  text("Wealth: " + wealthScore, 510, 50);
  //Happiness box's location and size
  fill(255, 223, 0);
  rect(700, 20, 200, 45);
  fill(0);
  text("Happiness: " + happinessScore, 710, 50);
  //Grades box's location and size
  fill(255, 223, 0);
  rect(900, 20, 200, 45);
  fill(0);
  text("Grades: " + gradesScore, 910, 50);
}

/*
* weekLevel - allows a black screen to pop up with 
* words Week: + level to show and button Start Next Week
  */
void weekLevel() {
  //Print Week + level in blue and background black
  background (0);
  textSize(100);
  fill(0,0,255);
  text("Week:" + level, 450, 350);
  //Button Start Next Week
  fill(255, 223, 0);
  rect(510, 430, 200, 50, 7);
  textSize(20);
  fill(255);
  text("Start Next Week", 535, 460);
}

/*
* SkipGame - allows endScreen to run if key 1 is pressed
* endweek runs if key 2 is pressed
  */
void skipGame() {
  if (key == '1') {
    endScreen();
  }
  if(key == '2') {
    endWeek();
  }
}

/*
* keyControl - allows intructionScreen to pop up if key "h" or "H" are press
* if key "b" or "B" are press startScreen pop ups
  */
void keyControls() {
  if (key == 'h' || key == 'H') {
    instructionScreen();
  }
  if (key == 'b' || key == 'B') {
    startScreen();
  }
}

/*
* limitAttempts - sets maxinum attempts to be 7 during a week
  */
void limitAttempts() {
  if (numDay == 7) {
    maxDay = false;
  }
  if (numDay == 0) {
    maxDay = true;
  }
}
