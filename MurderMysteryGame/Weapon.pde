class Weapon extends Interactable {
  // Index in all hints and descriptions
  private int hint_index;
  // Basic interaction text describing the object
  private ArrayList<String> weapon_description;
  // Relevant hints, only displayed if the weapon has been used
  private ArrayList<String> weapon_hints;
  private String relevant_image_loc;
  private boolean is_relevant;
  private String name;
  private int weapon_type;
  // 0 = poison
  // 1 = blade
  // 2 = blunt

  Weapon(int x_pos, int y_pos, String name, int weapon_type, ArrayList<String> weapon_description, ArrayList<String> weapon_hints, String image_loc, String relevant_image_loc) {
    super(x_pos, y_pos, 1, name);
    this.name = name;
    this.weapon_type = weapon_type;
    this.weapon_description = weapon_description;
    this.weapon_hints = weapon_hints;
    this.relevant_image_loc = relevant_image_loc;
    this.hint_index = 0;
    super.interactable_image = loadImage(image_loc);
    this.is_relevant = false;
  }
  
  public String getName() {
    return name;
  }

  public int getType() {
    return weapon_type;
  }

  public boolean isRelevant() {
    return is_relevant;
  }

  public void setRelevance(boolean is_relevant) {
    this.is_relevant = is_relevant;
  }

  public ArrayList<String> getHints() {
    return weapon_hints;
  }

  public void addHint(String hint) {
    weapon_hints.add(hint);
  }

  public String getNextHint() {
    String next_hint;
    if (this.is_relevant) {
      if (hint_index >= weapon_description.size()) {
        next_hint = weapon_hints.get(hint_index - weapon_description.size());
      } else {
        next_hint = weapon_description.get(hint_index);
      }
      hint_index++;
      hint_index = (hint_index >= weapon_hints.size() + weapon_description.size()) ? 0 : hint_index;
      return next_hint;
    }    
    next_hint = weapon_description.get(hint_index);
    hint_index++;
    hint_index = (hint_index >= weapon_description.size()) ? 0 : hint_index;
    return next_hint;
  }
  
  // Generic interact method to be overided
  // TODO show text in game
  // Currently prints to the terminal when interacted with
  // Consider printing onto a 'notepad' which acts as a log
  // for all player interactions in order of interaction?
  public boolean interact() {
    System.out.println(getNextHint());
    return false;
  }

  void setPosition(int x_pos, int y_pos) {
      super.setLocation(x_pos, y_pos);
  }
}
