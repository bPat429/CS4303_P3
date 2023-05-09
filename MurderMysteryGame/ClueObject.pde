class ClueObject extends Interactable {
  // Interaction text that comes up when interacting with an object
  // Add parameterised_hints in the Motives class when choosing how to give evidence for each motive
  private ArrayList<ParameterisedDialogue> parameterised_hints;
  // Basic interaction text describing the object
  private ArrayList<String> clue_description;
  private boolean is_relevant;

  ClueObject(int x_pos, int y_pos, int type, String name, ArrayList<String> clue_description, String image_loc) {
    super(x_pos, y_pos, type, name);
    this.clue_description = clue_description;
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
