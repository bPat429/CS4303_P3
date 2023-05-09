


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

void setup() {
    fullScreen();
    rand = new Random();
    current_screen = -1;
    exploration_handler = new ExplorationHandler(tile_size, rand);
    dialogue_handler = new DialogueHandler(rand);
}

void enterExplorationScreen() {
    prev_frame_millis = millis();
    current_screen = -2;
}

void draw() {
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
            if (current_screen > -1) {
                dialogue_handler.resetDialogueScreen(exploration_handler.getPlayer(), exploration_handler.getCharacters());
            }
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
            // Drawn as a large box over the bottom of the exploration screen
            // current_screen = character index
            current_screen = dialogue_handler.run(input_array, current_screen);
            if (current_screen < 0) {
                enterExplorationScreen();
            }
    }
    prev_frame_millis = millis();
}
void keyPressed() {
    if (keyCode == LEFT) {
        input_array[0] = true;
    }
    if (keyCode == RIGHT) {
        input_array[1] = true;
    }
    if (keyCode == UP) {
        input_array[2] = true;
    }
    if (keyCode == DOWN) {
        input_array[3] = true;
    }
    
        if (key == 'q' || key == 'Q') {
        input_array[4] = true;
    }
    if (key == 'e' || key == 'E') {
        input_array[5] = true;
    }
    if (key == 'f' || key == 'F') {
        input_array[6] = true;
    }
    if (key == 'r' || key == 'R') {
        input_array[7] = true;
    }
}

void keyReleased() {
    if (keyCode == LEFT) {
        input_array[0] = false;
    }
    if (keyCode == RIGHT) {
        input_array[1] = false;
    }
    if (keyCode == UP) {
        input_array[2] = false;
    }
    if (keyCode == DOWN) {
        input_array[3] = false;
    }
        if (key == 'q' || key == 'Q') {
        input_array[4] = false;
    }
    if (key == 'e' || key == 'E') {
        input_array[5] = false;
    }
    if (key == 'f' || key == 'F') {
        input_array[6] = false;
    }
    if (key == 'r' || key == 'R') {
        input_array[7] = false;
    }
}
