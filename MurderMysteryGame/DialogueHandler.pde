import java.util.Random;
import java.util.ArrayList;

final class DialogueHandler {
    private Random rand;
    private int current_selection;
    // 0 = Greeting
    // 1 = What can you tell me about the murder
    // 2 = What weapons do you have access to
    // 3 = Do you have an alibi
    // 4 = Goodbye.
    private int current_state;
    // 0 = main interaction screen
    // 1 = mid-dialogue
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
        current_state = 0;
        current_selection = 0;
        this.player = player;
        this.cast = cast;
    }

    int run(boolean[] input_array, int character_index) {
        Character current_char = cast.getCharacter(character_index);
        // Check if the player is trying to interact with an item
        // Impose a cooldown because the player doesn't need to search the same place several times
        if ((millis() - input_cooldown) > 400) {
            input_cooldown = millis();
            
            if (input_array[0]) {
                current_selection = (current_selection == 0) ? current_selection : current_selection - 1;
            }

            if (input_array[1]) {
                current_selection = (current_selection == 4) ? current_selection : current_selection + 1;
            }
            // TODO replace these with wasdf
            if (input_array[4]) {
                current_state = (current_state == 0) ? 1 : 0;
                if (current_state == 1) {
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
            }
        }

        // draw level
        drawScreen(player);
        return character_index;
}

    void drawScreen(Player player) {
        int small_x = displayWidth/100;
        int small_y = displayHeight/100;
        // Draw the dialogue box background
        fill(0);
        rect(small_x * 12.5, displayHeight - small_y * 30, small_x * 75, small_y * 25, small_x);
        textSize(small_x);
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
            fill(0);
        } else {
            fill(100);
        }
        text("Goodbye.", small_x * 15, displayHeight - small_y * 12.5);
        // Draw the player
        player.drawComponent(tile_size);
    }
}
