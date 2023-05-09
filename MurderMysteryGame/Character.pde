import java.util.Random;
import java.util.ArrayList;

// Class for Non player characters
// N.b. if we want to implement roaming we'll have to change this to extend Entity, not Interactable
class Character extends Entity {
    // keep a copy of rand so we can randomly choose between dialogue options etc.
    Random rand;
    private ArrayList<String> dialogue;
    private ArrayList<Character> alibi_list;
    // Set of indexes for weapons this character has access to
    private ArrayList<Weapon> accessable_weapons;
    private boolean has_motive;
    // The character's assigned role, e.g.
    // 0 = bystander
    // 1 = murderer
    // 2 = victim
    int role;
    // The character's job in the house, e.g.
    // 0 = butler
    // 1 = maid
    // 2 = owner
    // 3 = chef
    // 4 = guest
    int job;

    // Create an Character
    // Automatically set position to (0, 0) before moving them to their required position after generating the plot
    Character(String name, int job, Random rand, ArrayList<String> dialogue) {
        super(0, 0, name);
        this.dialogue = dialogue;
        super.entity_image = loadImage("NPC_placeholder.png");
        this.job = job;
        this.rand = rand;
        this.accessable_weapons = new ArrayList<Weapon>();
        this.alibi_list = new ArrayList<Character>();
        // Set role to bystander by default
        role = 0;
    }

    // Generic interact method to be overided
    // TODO show text in game
    // Currently prints to the terminal when interacted with
    public boolean interact() {
        for (int i = 0; i < dialogue.size(); i++) {
        print(dialogue.get(i));
        }
        return false;
    }
    
    void setImage (String image_loc) {
      super.entity_image = loadImage(image_loc);
    }
      

    void addDialogue(String s) {
        dialogue.add(s);
    }

    ArrayList<String> getDialogue() {
        return dialogue;
    }

    void setRole(int i) {
        this.role = i;
    }

    int getRole() {
        return this.role;
    }

    int getJob() {
        return this.job;
    }

    void setPosition(int x_pos, int y_pos) {
        super.setLocation(x_pos, y_pos);
    }

    boolean hasAlibi() {
        return (this.alibi_list.size() > 0);
    }

    ArrayList<Character> getAlibis() {
        return this.alibi_list;
    }

    void addAlibi(Character other_char) {
        this.alibi_list.add(other_char);
    }

    void addWeaponAccess(Weapon weapon) {
        accessable_weapons.add(weapon);
    }

    boolean checkWeaponAccess(Weapon weapon) {
        return accessable_weapons.contains(weapon);
    }

    void setHasMotive(boolean has_motive) {
        this.has_motive = has_motive;
    }

    boolean hasMotive() {
        return this.has_motive;
    }
}
