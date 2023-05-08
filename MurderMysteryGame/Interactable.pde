// Superclass for all items and staircases
class Interactable {
  // The tile on which this is placed
  private int[] location;
  // Type of the interactable
  // 0 = clue
  // 1 = weapon
  // 2 = exit door
  private int type;
  private PImage interactable_image;
  // Radius used to tune how far the player may be and still interact
  private float interact_radius;
  private String name;

  Interactable(int x_pos, int y_pos, int type, String name) {
    this.name = name;
    this.location = new int[]{x_pos, y_pos};
    // Set default interact_radius to slightly smaller than a tile
    this.interact_radius = 0.4;
    this.type = type;
  }

  float getInteractRadius() {
      return interact_radius;
  }

  int getType() {
    return type;
  }

  int[] getLocation() {
    return location;
  }

  void setLocation(int x_pos, int y_pos) {
    this.location = new int[]{x_pos, y_pos};
  }

  PImage getImage() {
    return interactable_image;
  }

  // Check if the player is colliding with an object, and therefore if they can interact
  public boolean checkCollision(Player player) {
    PVector player_location = player.getLocation();
    float d = (float) Math.sqrt(Math.pow(player_location.x - location[0], 2) + Math.pow(player_location.y - location[1], 2));
    float sum_radius = this.getInteractRadius() + player.getInteractRadius();
    return (sum_radius >= d);
  }
  
  // Generic interact method to be overided
  // This represents interacting with the object while in the dungeon level screen
  // Returns true if the item should be removed from the interactables list.
  public boolean interact() {
    print("Error, interaction not implemented yet");
    return false;
  }

  // Generic interact method to be overided
  // This represents interacting with the object while in the inventory screen
  // Return true if consumable
  public boolean use() {
    print("Error, use not implemented yet");
    return false;
  }
  
  public void drawComponent(int tile_size) {
        float obj_x = tile_size * location[0];
        float obj_y = tile_size * location[1];
        pushMatrix();
        translate(obj_x + tile_size/2, obj_y + tile_size/2);
        if (interactable_image != null) {
            image(interactable_image, -tile_size/2, -tile_size/2, tile_size , tile_size);
        } else {
            // Default to a green square in case of no image
            fill(0, 255, 0);
            rect(location[0] * tile_size, location[1] * tile_size, tile_size, tile_size);
        }
        popMatrix();
    }
}
