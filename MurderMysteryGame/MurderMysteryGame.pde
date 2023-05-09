
// Game constants
final int tile_size = 50;

// Screen handlers
ExplorationHandler exploration_handler;
DialogueHandler dialogue_handler;

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
    rand = new Random();
    current_screen = -1;
    exploration_handler = new ExplorationHandler(tile_size, rand);
    dialogue_handler = new DialogueHandler(rand);
    backgroundImage = loadImage("menu_background.png");
    backgroundImage.resize(width, height);
}

void enterExplorationScreen() {
  prev_frame_millis = millis();
  current_screen = -2;
  exploration_handler.resetInteractCooldown();
}

void draw() { 
    switch (current_screen) {
        case -1:
            image(backgroundImage, 0, 0);
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
            text("'a' or LEFT to move left", 40, 110); // add spacing here
            text("'s' or DOWN to move down", 40, 140); // add spacing here
            text("'w' or UP to move up", 40, 170); // add spacing here
            text("'d' or RIGHT to move right", 40, 200); // add spacing here
            
            textSize(25);
            text("Press 'f' or ENTER to interact with objects and characters.", 20, 250); // add spacing here
            text("Press 'f' or ENTER to start the game.", 20, 280); // add spacing here
            // Intro screen
            // TODO
            if (input_array[4]) {
              enterExplorationScreen();
            }
            break;
        case -2:
            frame_duration = (millis() - prev_frame_millis)/1000;
            // Exploration screen
            current_screen = exploration_handler.run(input_array, frame_duration);
            if (current_screen > -1) {
                dialogue_handler.resetDialogueScreen(exploration_handler.getPlayer(), exploration_handler.getCharacters());
                if (current_screen >= exploration_handler.getCharacters().len()) {
                    dialogue_handler.setText(exploration_handler.getInteractables().get(current_screen - exploration_handler.getCharacters().len()).interact());
                }
            }
            break;
        case -3:
            // Character accusation screen TODO
            current_screen = -4;
            // TODO
            break;
        case -4:
            // Ending screen
            // TODO
            break;
        default:
            // Conversation screen
            // Drawn as a large box over the bottom of the exploration screen
            // current_screen = character index
            current_screen = dialogue_handler.run(input_array, current_screen);
            if (current_screen < 0) {
                System.out.println("x");
                enterExplorationScreen();
            }
    }
    prev_frame_millis = millis();
}

void keyPressed() {
  if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
        input_array[0] = true;
    }
    if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
        input_array[1] = true;
    }
    if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
        input_array[2] = true;
    }
    if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
        input_array[3] = true;
    }
    if (key == 'f' || key == 'F' || (key == ENTER)) {
        input_array[4] = true;
    }
}

void keyReleased() {
  if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
        input_array[0] = false;
    }
    if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
        input_array[1] = false;
    }
    if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
        input_array[2] = false;
    }
    if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
        input_array[3] = false;
    }
  if (key == 'f' || key == 'F' || (key == ENTER)) {
    input_array[4] = false;
  }
    
}
