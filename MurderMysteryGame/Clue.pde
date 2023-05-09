class Clue extends Interactable {
  // Interaction text that comes up when interacting with an object
  // Add parameterised_hints in the Motives class when choosing how to give evidence for each motive
  private ArrayList<ParameterisedDialogue> parameterised_hints;
  // Index in all hints and descriptions
  private int hint_index;
  // Basic interaction text describing the object
  private ArrayList<String> clue_description;
  private boolean in_use;
  private String suspect;
  private String victim;

  Clue(int x_pos, int y_pos, String name, ArrayList<String> clue_description, ArrayList<ParameterisedDialogue> parameterised_hints, String image_loc) {
    super(x_pos, y_pos, 0, name);
    this.parameterised_hints = parameterised_hints;
    this.clue_description = clue_description;
    super.interactable_image = loadImage(image_loc);
    this.in_use = false;
  }

  public boolean inUse() {
    return this.in_use;
  }

  public void setUsed() {
    this.in_use = true;
  }

  public ArrayList<ParameterisedDialogue> getHints() {
    return parameterised_hints;
  }

  public void addHint(ParameterisedDialogue hint) {
    parameterised_hints.add(hint);
  }

  public String getNextHint() {
    String next_hint;
    if (this.in_use) {
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

  String getAllHints() {
      String all_hints = "";
      for (int i = 0; i < clue_description.size(); i++) {
        all_hints = all_hints + " " + clue_description.get(i);
      }
      if (in_use) {
        for (int i = 0; i < parameterised_hints.size(); i++) {
          all_hints = all_hints + " " + parameterised_hints.get(i).getDialogue(this.suspect, this.victim);
        }
      }
      return all_hints;
  }
  
  public String interact() {
    return getAllHints();
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
