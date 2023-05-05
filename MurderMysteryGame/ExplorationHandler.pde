import java.util.Random;
import java.util.ArrayList;

final class ExplorationHandler {
    // The class used for handling the cast of the murder mystery
    CharacterCast cast;
    // The class used for generating a plot for the murder mystery
    PlotGenerator plot_gen;
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
 PImage tile1a = loadImage("tile1a.png");

    // The size of each tile
    private int tile_size;
    private final int test_room_size = 10;

   ExplorationHandler(int tile_size, Random rand) {
    // Initialise the player
    this.player = new Player();
    this.tile_size = tile_size;
    this.rand = rand;
    // Initialise the character cast
    cast = new CharacterCast(rand);
    
    // Generate the plot
    plot_gen = new PlotGenerator(cast, rand);

    // Add physical clues
    interactables = plot_gen.getInteractables();

    // Spawn in exit door for game over
    interactables.add(new FrontDoor(1, 1));
    
    generateMansion(); // call the method to generate the mansion/tile map
    this.search_cooldown = millis();
}





    // Generate the dungeon level
    void generateMansion() {
 
       String[] tilemap_lines = loadStrings("data/txt/Tilemap.txt");
   int map_height = tilemap_lines.length;
  int map_width = tilemap_lines[0].length();

  // create the tile map
  tile_map = new int[map_height][map_width];

  // read the tile map from the text file
for (int y = 0; y < map_height; y++) {
    String line = tilemap_lines[y];
    System.out.println("line=" + line);
    for (int x = 0; x < map_width; x++) {
        char tile_char = line.charAt(x);
        if (tile_char == '0') {
            tile_map[y][x] = 0; // floor
        } else if (tile_char == '1') {
            tile_map[y][x] = 1; // wall
        }
    }
}
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

    // Return the index of the first character who is close enough to interact
    // -1 if none are close
    int checkCharacterProximity() {
        PVector player_location = player.getLocation();
        for (int i = 0; i < cast.len(); i++) {
            float d = cast.getCharacter(i).getDistance(player);
            float sum_radius = cast.getCharacter(i).getInteractRadius() + player.getInteractRadius();
            // Make it easier to collide with the player
            if (sum_radius + 0.25 >= d) {
                return i;
            }
        }
        return -1;
    }

    // Main method used to run the gameloop while the player is exploring a dungeon level.
    // Return Return -2 to continue, -1 to go to the ending screen, or the character index
    // to go to the dialogue screen
    int run(boolean[] input_array, float frame_duration) {
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
                // If the front door then trigger the final screen
                if(interactables.get(index).getType() == 2) {
                    // TODO
                }
                // TODO implement interactions
                interactables.get(index).interact();
            } else {
                // Check if any characters are close
                index = checkCharacterProximity();
                if (index > -1) {
                    cast.getCharacter(index).interact();
                    // TODO check for index >= 0, then go to dialogue screen with (index) character
                    return index;
                }
            }
        }
        
        // draw level
        drawScreen();
        return -2;
}




      


     void drawScreen() {
  background(255);
  pushMatrix();
  PVector player_location = player.getLocation();
  translate((displayWidth/2) - tile_size * player_location.x, (displayHeight/2) - tile_size * player_location.y);

  for (int y = 0; y < tile_map.length; y++) {
    for (int x = 0; x < tile_map[0].length; x++) {
      if (tile_map[y][x] == 0) {
        // Show tile1a image for unpopulated spaces
 fill(128);
        rect(x * tile_size, y * tile_size, tile_size, tile_size);     
      } 
      else if (tile_map[y][x] == 1) {
       
                image(tile1a, x * tile_size, y * tile_size, tile_size, tile_size);

      } else {
        fill(0);
        rect(x * tile_size, y * tile_size, tile_size, tile_size);
      }
    }
  }

  // Draw all interactables
  for (int i = 0; i < interactables.size(); i++) {
    if (interactables.get(i) != null) {
      interactables.get(i).drawComponent(tile_size);
    }
  }
  
  // Draw all NPCs
  for (int i = 0; i < cast.len(); i++) {
    if (cast.getCharacter(i) != null) {
      cast.getCharacter(i).drawComponent(tile_size);
    }
  }
  
  // Draw the player
  player.drawComponent(tile_size);
  
  popMatrix();
}

 


}
