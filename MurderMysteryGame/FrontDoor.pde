// Front door class
// Interact with this to make an accusation and end the game
class FrontDoor extends Interactable {

 FrontDoor(int x_pos, int y_pos) {
    super(x_pos, y_pos, 2);
    super.interactable_image = loadImage("door_placeholder.png");
  }
  
  public boolean interact() {
    System.out.println("TODO");
    return false;
  }
  
  void drawComponent(int tile_size) {
    image(super.interactable_image, tile_size * super.location[0], tile_size * super.location[1], tile_size , tile_size);
  }
}
