class Clue extends Interactable {
  // Interaction text that comes up when interacting with an object
  // Add parameterised_hints in the Motives class when choosing how to give evidence for each motive
  private ArrayList<ParameterisedDialogue> parameterised_hints;
  // Index in all hints and descriptions
  private int hint_index;
  // Basic interaction text describing the object
  private ArrayList<String> clue_description;
  private boolean is_relevant;
  private String name;
  private String suspect;

  Clue(int x_pos, int y_pos, String name, ArrayList<String> clue_description, String image_loc) {
    super(x_pos, y_pos, 0, name);
    this.parameterised_hints = new ArrayList<ParameterisedDialogue>();
    this.clue_description = clue_description;
    super.interactable_image = loadImage(image_loc);
    this.is_relevant = false;
  }
  
  public String getName() {
    return name;
  }

  public boolean isRelevant() {
    return is_relevant;
  }

  public void setRelevance(boolean is_relevant) {
    this.is_relevant = is_relevant;
  }

  public ArrayList<ParameterisedDialogue> getHints() {
    return parameterised_hints;
  }

  public void addHint(ParameterisedDialogue hint) {
    parameterised_hints.add(hint);
  }

  public String getNextHint(String suspect, String victim) {
    String next_hint;
    if (hint_index >= clue_description.size() && parameterised_hints.size() > 0) {
      // ParameterisedDialogue parameterised_hint = parameterised_hints.get(hint_index - clue_description.size());
      ParameterisedDialogue parameterised_hint = new ParameterisedDialogue("", "", "", 0);
      next_hint = parameterised_hint.getDialogue(suspect, victim);
    } else {
      next_hint = clue_description.get(hint_index % clue_description.size());
    }
    hint_index++;
    hint_index = (hint_index > clue_description.size() + parameterised_hints.size()) ? 0 : hint_index;
    return next_hint;
  }
  
  // Generic interact method to be overided
  // TODO show text in game
  // Currently prints to the terminal when interacted with
  // Consider printing onto a 'notepad' which acts as a log
  // for all player interactions in order of interaction?
  public boolean interact() {
    for (int i = 0; i < clue_description.size(); i++) {
      print(clue_description.get(i));
    }
    for (int i = 0; i < parameterised_hints.size(); i++) {
      print(parameterised_hints.get(i));
    }
    return false;
  }

  void setPosition(int x_pos, int y_pos) {
      super.setLocation(x_pos, y_pos);
  }

  void setSuspect(String suspect) {
    this.suspect = suspect;
  }
}
