// Class used for all interactable objects which may be clues
class ClueObject extends Interactable {
  // Hints about the object
  // e.g. if a knife is bloody have the hint: "This is covered in blood!"
  private ArrayList<String> hints;

  ClueObject(int x_pos, int y_pos, int type, String name, ArrayList<String> hints, String image_loc) {
    super(x_pos, y_pos, type, name);
    super.interactable_image = loadImage(image_loc);
    this.hints = hints;
  }
  
  // Generic interact method to be overided
  // TODO show text in game
  // Currently prints to the terminal when interacted with
  // Consider printing onto a 'notepad' which acts as a log
  // for all player interactions in order of interaction?
  public boolean interact() {
    for (int i = 0; i < hints.size(); i++) {
      print(hints.get(i));
    }
    return false;
  }

  void setPosition(int x_pos, int y_pos) {
      super.setLocation(x_pos, y_pos);
  }

  // Generic interact method to be overided
  // This represents interacting with the object while in the inventory screen
  // Return true if consumable
  public boolean use() {
    print("Error, use not implemented yet");
    return false;
  }
}
