class ClueObject extends Interactable {
  // Interaction text that comes up when interacting with an object
  // Text pool changes if the object is the murder weapon
  // e.g. if a knife is bloody have the hint: "This is covered in blood!"
  private ArrayList<String> hints;
  private ArrayList<String> clue_hints;
  private String clue_image_loc;
  private boolean is_relevant;

  ClueObject(int x_pos, int y_pos, int type, String name, ArrayList<String> hints, ArrayList<String> clue_hints, String image_loc, String clue_image_loc) {
    super(x_pos, y_pos, type, name);
    this.clue_hints = clue_hints;
    this.hints = hints;
    this.clue_image_loc = clue_image_loc;
    super.interactable_image = loadImage(image_loc);
    this.is_relevant = false;
  }

  public boolean isRelevant() {
    return this.is_relevant;
  }

  public void setRelevance(boolean is_relevant) {
    this.is_relevant = is_relevant;
    if (is_relevant) {
        for (int i = 0; i < clue_hints.size(); i++) {
            this.hints.add(clue_hints.get(i));
        }
        super.interactable_image = loadImage(clue_image_loc);
    }
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
}
