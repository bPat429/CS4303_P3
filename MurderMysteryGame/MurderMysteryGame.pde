
// Game constants
final int tile_size = 50;

// Screen handlers
ExplorationHandler exploration_handler;

// Current screen
int current_screen;
// -1 = Intro screen
// -2 = Exploration screen
// -3 = Character accusation screen
// -4 = Ending screen
// (x > -1) = Conversation screen (x = character index)

// Global variables
float prev_frame_millis;
float frame_duration;
Random rand;
// Array of Booleans used to track user inputs
// corresponding to:
// a pressed, d pressed, w pressed, s pressed, q pressed, e pressed, f pressed
boolean[] input_array = new boolean[]{false, false, false, false, false, false, false, false};
PImage backgroundImage;

void setup() {
  fullScreen();
    backgroundImage = loadImage("menu_background.png");
  backgroundImage.resize(width, height);
  
  
  rand = new Random();
  current_screen = -1;
  exploration_handler = new ExplorationHandler(tile_size, rand);
  
    // Add characters to the list
  characters.add(new Character(0, height-tile_size, loadImage(""), tile_size));
  characters.add(new Character(tile_size, height-tile_size, loadImage("characters/alicia.png"), tile_size));
  characters.add(new Character(tile_size*2, height-tile_size, loadImage("characters/andrew.png"), tile_size));
  characters.add(new Character(tile_size*3, height-tile_size, loadImage(" characters/elisabeth.png"), tile_size));
    characters.add(new Character(tile_size*4, height-tile_size, loadImage(" characters/elisabeth.png"), tile_size));

 characters/jane.png
  characters/john.png
 characters/lawrence.png
  
}

void enterExplorationScreen() {
  prev_frame_millis = millis();
  current_screen = -2;
}

void draw() {
    image(backgroundImage, 0, 0);

  // Start screen menu
  if (current_screen == -1) { 
   
  textAlign(LEFT);
  textSize(32);
  fill(0);
  text("Instructions:", 20, 40);
  stroke(0);
  strokeWeight(2);
  line(20, 50, 200, 50);
  textSize(25);
  text("Use the following keys to move the player:", 20, 80); // add spacing here
  textSize(20);
  text("'a' to move left", 40, 110); // add spacing here
  text("'s' to move down", 40, 140); // add spacing here
  text("'w' to move up", 40, 170); // add spacing here
  text("'e' to move right", 40, 200); // add spacing here
  
  textSize(25);
  text("Press 's' to start the game.", 20, 250); // add spacing here
  text("Press 'f' to interact with objects and characters.", 20, 280); // add spacing here
  
  for (Character character : characters) {
      character.draw();
}
 

 
  else
    switch (current_screen) {
        case -1:
            // Intro screen
            // TODO
            enterExplorationScreen();
            break;
        case -2:
            frame_duration = (millis() - prev_frame_millis)/1000;
            // Exploration screen
            current_screen = exploration_handler.run(input_array, frame_duration);
            break;
        case -3:
            // Character accusation screen
            // TODO
            break;
        case -4:
            // Ending screen
            // TODO
            break;
        default:
            // Conversation screen
            // TODO
            // current_screen = character index
    }
    prev_frame_millis = millis();
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
        input_array[0] = true;
    }
    if (key == 'd' || key == 'D') {
        input_array[1] = true;
    }
    if (key == 'w' || key == 'W') {
        input_array[2] = true;
    }
    if (key == 's' || key == 'S') {
        input_array[3] = true;
    }
  if (key == 'f' || key == 'F') {
    input_array[4] = true;
  }
  if (key == 's' || key == 'S') {
    input_array[5] = true;
    current_screen = -2; // start the game
  }
}

void keyReleased() {
  if (key == 'a' || key == 'A') {
        input_array[0] = false;
    }
    if (key == 'd' || key == 'D') {
        input_array[1] = false;
    }
    if (key == 'w' || key == 'W') {
        input_array[2] = false;
    }
    if (key == 's' || key == 'S') {
        input_array[3] = false;
    }
  if (key == 'f' || key == 'F') {
    input_array[4] = false;
  }
  if (key == 's' || key == 'S') {
    input_array[5] = false;
    }
    
}
