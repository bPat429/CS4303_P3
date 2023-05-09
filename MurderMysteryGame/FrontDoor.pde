// Front door class
// Interact with this to go to the end game screen (make an accusation then end the game)
class FrontDoor extends Interactable {

 FrontDoor(int x_pos, int y_pos) {
    super(x_pos, y_pos, 2, "Front Door");
    // TODO make a better door image
    super.interactable_image = loadImage("door.png");
    super.interact_radius = 1;
  }
  
  void drawComponent(int tile_size) {
    image(super.interactable_image, tile_size * super.location[0], tile_size * super.location[1], tile_size , tile_size);
  }
}
