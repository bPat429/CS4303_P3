import java.util.ArrayList;

// Class used for handling accusing a character at the end of the game
final class AccusationHandler {
    private int current_selection;
    private CharacterCast cast;
    private boolean selection_made;
    private int victim_index;
    private String output_string;

    // A cooldown used to avoid accidentally repeating the interact action due to high framerate
    private float input_cooldown;

    AccusationHandler() {
        this.current_selection = 0;
    }

    public void resetAccusationScreen(CharacterCast cast, int victim_index) {
        current_selection = 0;
        this.cast = cast;
        this.selection_made = false;
        this.victim_index = victim_index;
        input_cooldown = millis();
    }

    int run(boolean[] input_array, int selection_index) {
        if (selection_made) {
            if ((millis() - input_cooldown) > 100) {
                if (input_array[4]) {
                    input_cooldown = millis();
                    return -4;
                }
            }
            drawScreen();
        } else {
            // Set a long cooldown to ensure no accidental guesses
            if ((millis() - input_cooldown) > 200) {

                if (input_array[2]) {
                    input_cooldown = millis();
                    current_selection = (current_selection == 0) ? current_selection : current_selection - 1;
                }

                if (input_array[3]) {
                    input_cooldown = millis();
                    current_selection = (current_selection == cast.len() - 1) ? current_selection : current_selection + 1;
                }

                if (input_array[4]) {
                    input_cooldown = millis();
                    if (current_selection < cast.len() - 1) {
                        int cast_index = (current_selection < victim_index) ? current_selection : current_selection + 1;
                        if (cast.getCharacter(cast_index).getRole() == 1) {
                            output_string = "Congratulations, you are correct! " + cast.getCharacter(cast_index).getName() + " was the murderer.";
                        } else {
                            String murderer_name = "";
                            for (int i = 0; i < cast.len(); i++) {
                                if (cast.getCharacter(i).getRole() == 1) {
                                    murderer_name = cast.getCharacter(i).getName();
                                }
                            }
                            output_string = "Incorrect. " + murderer_name + " was the murderer.";
                        }
                        selection_made = true;
                    } else {
                        // Return to the exploration screen
                        return -2;
                    }
                }
            }

            // draw level
            drawScreen();
        }
        return selection_index;
}

    void drawScreen() {
        int small_x = displayWidth/100;
        int small_y = displayHeight/100;
        // Draw the dialogue box background
        fill(0);
        rect(small_x * 12.5, displayHeight - small_y * 30, small_x * 75, small_y * 25, small_x);
        textSize(small_x);
        if (!selection_made) {
            textSize(small_x * 1.5);
            text("Accuse a character of murder. NOTE: Accusing a character will end the game.", small_x * 15, displayHeight - small_y * 25);
            textSize(small_x);
            // Use a second index which doesn't include the victim in the cast list
            int j = 0;
            for (int i = 0; i < cast.len(); i++) {
                Character character = cast.getCharacter(i);
                if (character.getRole() != 2) {
                    if (current_selection == j) {
                        fill(255);
                    } else {
                        fill(100);
                    }
                    text("Accuse " + character.getName(), small_x * 15, displayHeight - small_y * (22.5 - 2.5 * j));
                    j++;
                }
            }
            if (current_selection == j) {
                fill(255);
            } else {
                fill(100);
            }
            text("I'm not ready to accuse yet, go back.", small_x * 15, displayHeight - small_y * (22.5 - 2.5 * j));
        } else {
            fill(255);
            text(output_string, small_x * 15, displayHeight - small_y * 27.5, small_x * 72.5, small_y * 15);
            text("Press (F) to continue...", small_x * 15, displayHeight - small_y * 10);
        }
    }
}
