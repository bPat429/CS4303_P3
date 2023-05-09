import java.util.Random;
import java.util.ArrayList;

// Class used for handling interaction with characters, clues and weapons.
// Interaction with characters gives access to a dialogue tree.
// Interaction with clues and weapons prints all information at once.
final class DialogueHandler {
    private Random rand;
    private int current_selection;
    // 0 = Greeting
    // 1 = What can you tell me about the murder
    // 2 = What weapons do you have access to
    // 3 = Do you have an alibi
    // 4 = Goodbye.
    private boolean in_menu;
    // true = main interaction screen
    // false = mid-dialogue
    private Player player;
    private String current_text;
    private CharacterCast cast;

    // A cooldown used to avoid accidentally repeating the interact action due to high framerate
    private float input_cooldown;

    DialogueHandler(Random rand) {
        this.rand = rand;
        this.current_selection = 0;
    }

    public void resetDialogueScreen(Player player, CharacterCast cast) {
        in_menu = true;
        current_selection = 0;
        this.player = player;
        this.cast = cast;
        input_cooldown = millis();
    }

    public void setText(String text) {
        in_menu = false;
        this.current_text = text;
    }

    int run(boolean[] input_array, int selection_index) {
        if (selection_index >= cast.len()) {
            if ((millis() - input_cooldown) > 100) {
                if (input_array[4]) {
                    input_cooldown = millis();
                    return -2;
                }
            }
            drawScreen();
        } else {
            Character current_char = cast.getCharacter(selection_index);
            // Check if the player is trying to interact with an item
            // Impose a cooldown because the player doesn't need to search the same place several times
            if ((millis() - input_cooldown) > 100) {
                input_cooldown = millis();
                
                if (input_array[2]) {
                    current_selection = (current_selection == 0) ? current_selection : current_selection - 1;
                }

                if (input_array[3]) {
                    current_selection = (current_selection == 4) ? current_selection : current_selection + 1;
                }
                if (input_array[4]) {
                    if (in_menu) {
                        if (current_selection == 0) {
                            current_text = current_char.getGreeting();
                        } else if (current_selection == 1) {
                            current_text = current_char.getDialogueHints();
                        } else if (current_selection == 2) {
                            current_text = current_char.getWeaponAccessString();
                        } else if (current_selection == 3) {
                            current_text = current_char.getAlibiDialogue();
                        } else {
                            // Return to the exploration screen
                            return -2;
                        }
                    }
                    in_menu = !in_menu;
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
        if (in_menu) {
            if (current_selection == 0) {
                fill(255);
            } else {
                fill(100);
            }
            text("Greetings.", small_x * 15, displayHeight - small_y * 22.5);
            if (current_selection == 1) {
                fill(255);
            } else {
                fill(100);
            }
            text("What can you tell me about the murder?", small_x * 15, displayHeight - small_y * 20);

            if (current_selection == 2) {
                fill(255);
            } else {
                fill(100);
            }
            text("What weapons do you have access to?", small_x * 15, displayHeight - small_y * 17.5);

            if (current_selection == 3) {
                fill(255);
            } else {
                fill(100);
            }
            text("Do you have an alibi?", small_x * 15, displayHeight - small_y * 15);

            if (current_selection == 4) {
                fill(255);
            } else {
                fill(100);
            }
            text("Goodbye.", small_x * 15, displayHeight - small_y * 12.5);
        } else {
            fill(255);
            text(current_text, small_x * 15, displayHeight - small_y * 27.5, small_x * 72.5, small_y * 15);
            text("Press (F) to continue...", small_x * 15, displayHeight - small_y * 10);
        }
    }
}
