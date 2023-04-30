


// Game constants
final int tile_size = 50;


// Screen handlers
ExplorationHandler exploration_handler;


// Current screen
int current_screen;

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
    current_screen = 0;
    exploration_handler = new ExplorationHandler(tile_size, rand);
}

void enterExplorationScreen() {
    prev_frame_millis = millis();
    current_screen = 1;
}

void draw() {
    switch (current_screen) {
        case 0:
            // Intro screen
            current_screen = 1;
            break;
        case 1:
            frame_duration = (millis() - prev_frame_millis)/1000;
            // Exploration screen
            exploration_handler.run(input_array, frame_duration);
            break;
        case 2:
            // Ending screen
            break;
        default:
            // TODO
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
