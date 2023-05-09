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
  private String victim;

  Clue(int x_pos, int y_pos, String name, ArrayList<String> clue_description, ArrayList<ParameterisedDialogue> parameterised_hints, String image_loc) {
    super(x_pos, y_pos, 0, name);
    this.parameterised_hints = parameterised_hints;
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

  public String getNextHint() {
    String next_hint;
    if (this.is_relevant) {
      if (hint_index >= clue_description.size()) {
        next_hint = parameterised_hints.get(hint_index - clue_description.size()).getDialogue(this.suspect, this.victim);
      } else {
        next_hint = clue_description.get(hint_index);
      }
      hint_index++;
      hint_index = (hint_index >= parameterised_hints.size() + clue_description.size()) ? 0 : hint_index;
      return next_hint;
    }    
    next_hint = clue_description.get(hint_index);
    hint_index++;
    hint_index = (hint_index >= clue_description.size()) ? 0 : hint_index;
    return next_hint;
  }
  
  // Generic interact method to be overided
  // TODO show text in game
  // Currently prints to the terminal when interacted with
  // Consider printing onto a 'notepad' which acts as a log
  // for all player interactions in order of interaction?
  public boolean interact() {
    getNextHint();
    return false;
  }

  void setPosition(int x_pos, int y_pos) {
      super.setLocation(x_pos, y_pos);
  }

  // If this hints at a suspects motive we need to record which suspect
  // Each clue may hint at exactly one suspect
  void setSuspectName(String suspect) {
    this.suspect = suspect;
  }

  // If this hints at a suspects motive we need to record which suspect
  // Each clue may hint at exactly one suspect
  void setVictimName(String victim) {
    this.victim = victim;
  }
}
