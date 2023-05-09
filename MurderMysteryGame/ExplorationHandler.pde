import java.util.Random;
import java.util.ArrayList;

final class ExplorationHandler {
    // The class used for generating a plot for the murder mystery
    PlotGenerator plot_gen;
    // An array representing the contents of each tile in the manor.
    // 0 = unpopulated space
    // 1 = room space
    // 2 = wall space (used to draw the border around rooms)
    // 3 = interactable space
    private int[][] tile_map;
    private Player player;
    private ClueObjects clues;
    // The class used for handling the cast of the murder mystery
    private CharacterCast cast;
    private WeaponObjects weapons;
    private ArrayList<Interactable> interactables;
    private Random rand;
    // A cooldown used to avoid accidentally repeating the interact action due to high framerate
    private float search_cooldown;
 PImage tile1, tile0, tile2, tile3,tile4,tile5,tile6,tile7,tile8, tile9;
    // The size of each tile
    private int tile_size;
    private final int test_room_size = 10;

   ExplorationHandler(int tile_size, Random rand) {
    // Initialise the player
    this.player = new Player();
    this.tile_size = tile_size;
    this.rand = rand;
    // Initialise the character cast
    tile1 = loadImage("tile1.png");
    tile1.resize(tile_size, tile_size);
      // Initialise the character cast
    tile0 = loadImage("tile0.png");
    tile0.resize(tile_size, tile_size);
    
    tile2 = loadImage("tile2.png");
    tile2.resize(tile_size, tile_size);

    tile3 = loadImage("tile3.png");
    tile3.resize(tile_size, tile_size);
    
     tile4 = loadImage("tile4.png");
    tile4.resize(tile_size, tile_size);
 
     tile5 = loadImage("tile5.png");
    tile5.resize(tile_size, tile_size);
    
     tile6 = loadImage("tile6.png");
    tile6.resize(tile_size, tile_size);

    tile7 = loadImage("tile7.png");
    tile7.resize(tile_size, tile_size);
 
    tile8 = loadImage("tile8.png");
    tile8.resize(tile_size, tile_size);
    
    tile9 = loadImage("tile9.png");
    tile9.resize(tile_size, tile_size);
    
    // Generate the plot
    plot_gen = new PlotGenerator(rand);
    cast = plot_gen.getCast();
    weapons = plot_gen.getWeapons();

    // Add physical clues
    clues = plot_gen.getClues();
    interactables = new ArrayList<Interactable>();
    // Spawn in exit door for game over
    interactables.add(new FrontDoor(30, 0));
    interactables.add(new FrontDoor(31, 0));

    ClueObjects clues = plot_gen.getClues();
    for (int i = 0; i < clues.len(); i++) {
      interactables.add(clues.getClue(i));
    }
    WeaponObjects weapons = plot_gen.getWeapons();
    for (int i = 0; i < weapons.len(); i++) {
      interactables.add(weapons.getWeapon(i));
    }

    generateMansion(); // call the method to generate the mansion/tile map
    this.search_cooldown = millis();
}



    // Generate the dungeon level
    void generateMansion() {
  
      String[] tilemap_lines = loadStrings("data/txt/Tilemap.txt");
      int map_width = tilemap_lines[0].length();
      int map_height = tilemap_lines.length;

      // create the tile map
      tile_map = new int[map_width][map_height];

      // read the tile map from the text file
      for (int y = 0; y < map_height; y++) {
          String line = tilemap_lines[y];
          //System.out.println("line=" + line);
          for (int x = 0; x < map_width; x++) {
              char tile_char = line.charAt(x);
              if (tile_char == '0') {
                  tile_map[x][y] = 0; // floor
              } else if (tile_char == '1') {
                  tile_map[x][y] = 1; // wall
              }
              
              else if (tile_char == '2') {
                  tile_map[x][y] = 2; // pillow
              }
               else if (tile_char == '3') {
                  tile_map[x][y] = 3; 
              }
                else if (tile_char == '4') {
                  tile_map[x][y] = 4; // table
              }
               else if (tile_char == '5') {
                  tile_map[x][y] = 5; // table
              }
              else if (tile_char == '6') {
                  tile_map[x][y] = 6; // table
              }
              else if (tile_char == '7') {
                  tile_map[x][y] = 7; // rug
              }
                else if (tile_char == '8') {
                  tile_map[x][y] = 8; // lamp
              }
                else if (tile_char == '9') {
                  tile_map[x][y] = 9; // bookshelf
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
        player.handleWallCollisions(tile_map);

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
   //translate((displayWidth/2) - tile_size * player_location.x, (displayHeight/2) - tile_size * player_location.y);


  for (int y = 0; y < tile_map.length; y++) {
  
    for (int x = 0; x < tile_map[0].length; x++) {
      if (tile_map[y][x] == 0) {
       
        // Show tile1a image for unpopulated spaces
      image(tile0, y * tile_size, x * tile_size);
      } 
      else if (tile_map[y][x] == 1) {
       
       image(tile1, y * tile_size, x * tile_size);

      }
      
        else if (tile_map[y][x] == 2) {
       
      
       image(tile2, y * tile_size, x * tile_size);
      
        }

      else if (tile_map[y][x] == 3) {
       
      image(tile3, y * tile_size, x * tile_size);

      }
      
      else if (tile_map[y][x] == 4 ){
       
      image(tile4, y * tile_size, x * tile_size);

      } 
      
      else if (tile_map[y][x] == 5) {
       
      image(tile5, y * tile_size, x * tile_size);

      } 
      
      else if (tile_map[y][x] == 6) {
       
      image(tile6, y * tile_size, x * tile_size);

      } 
      
      else if (tile_map[y][x] == 7) {
       
      image(tile7, y * tile_size, x * tile_size);

      }
      
       else if (tile_map[y][x] == 7) {
       
      image(tile7, y * tile_size, x * tile_size);

      }
         
   else if (tile_map[y][x] == 8) {
        fill(0);
      image(tile0, y * tile_size, x * tile_size);
      image(tile8, y * tile_size, x * tile_size); 
      
        }
        
          else if (tile_map[y][x] == 9) {
        fill(0);
      image(tile0, y * tile_size, x * tile_size);
      image(tile9, y * tile_size, x * tile_size); 
      
        }
        
        
      else {
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
    if (i != plot_gen.getVictimIndex() && cast.getCharacter(i) != null) {
      cast.getCharacter(i).drawComponent(tile_size);
    }
  }
  
  // Draw the player
  player.drawComponent(tile_size);
  
  popMatrix();
}

 


}
