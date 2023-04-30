import java.util.Random;
import java.util.ArrayList;

final class ExplorationHandler {
    // An array representing the contents of each tile in the manor.
    // 0 = unpopulated space
    // 1 = room space
    // 2 = wall space (used to draw the border around rooms)
    // 3 = interactable space
    private int[][] tile_map;
    private Player player;
    private ArrayList<Interactable> interactables;
    private Random rand;
    // A cooldown used to avoid accidentally repeating the interact action due to high framerate
    private float search_cooldown;

    // The size of each tile
    private int tile_size;
    private final int test_room_size = 10;

    ExplorationHandler(int tile_size, Random rand) {
        // Initialise the player
        this.player = new Player();
        this.tile_size = tile_size;
        this.rand = rand;
        generateMansion();
        this.search_cooldown = millis();
    }

    // Generate the dungeon level
    void generateMansion() {
        interactables = new ArrayList<Interactable>();
        tile_map = new int[test_room_size][test_room_size];
        // TODO actually implement rooms based on the tilemap
        // TODO spawn in interactables (characters and clues)
        interactables.add(new FrontDoor(1, 1));
        // TODO spawn in entry/exit door (also an interactable, used to end the game)
    }

    // Return the index of the first object which is close enough to interact with
    // -1 if none are close
    int checkInteractablessProximity() {
        for (int i = 0; i < interactables.size(); i++) {
            if (interactables.get(i).checkCollision(player)) {
                return i;
            }
        }
        return -1;
    }

    // Main method used to run the gameloop while the player is exploring a dungeon level.
    void run(boolean[] input_array, float frame_duration) {
        // Handle character Movement
        player.handleInput(input_array, frame_duration);
        // TODO Handle character collisions

        // Check if the player is trying to interact with an item
        // Impose a cooldown because the player doesn't need to search the same place several times
        if (input_array[6] && (millis() - search_cooldown) > 400) {
            search_cooldown = millis();
            // Check if any items are close
            int index = checkInteractablessProximity();
            if (index > -1) {
                // TODO implement interactions
                 interactables.get(index).interact();
            }
        }
        // draw level
        drawScreen();
    }

    void drawScreen() {
        background(0);
        pushMatrix();
        PVector player_location = player.getLocation();
        translate((displayWidth/2) - tile_size * player_location.x, (displayHeight/2) - tile_size * player_location.y);
        // TODO Draw the tile_map/mansion
        // Draw all interactables
        for (int i = 0; i < interactables.size(); i++) {
            if (interactables.get(i) != null) {
                interactables.get(i).drawComponent(tile_size);
            }
        }
        // Draw the player
        player.drawComponent(tile_size);
        popMatrix();
    }
}
