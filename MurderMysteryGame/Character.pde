import java.util.Random;
import java.util.ArrayList;

// Class for Non player characters
// N.b. if we want to implement roaming we'll have to change this to extend Entity, not Interactable
class Character extends Entity {
    // keep a copy of rand so we can randomly choose between dialogue options etc.
    Random rand;
    private ArrayList<String> dialogue;
    // index 0 = standard greeting
    // index > 0 = clues and hints
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

    // Create an Character, default method for development
    // Automatically set position to (0, 0) before moving them to their required position after generating the plot
    Character(String name, int job, Random rand, ArrayList<String> dialogue) {
        super(5, 5, name);
        this.dialogue = dialogue;
        super.entity_image = loadImage("NPC_placeholder.png");
        this.job = job;
        this.rand = rand;
        this.accessable_weapons = new ArrayList<Weapon>();
        this.alibi_list = new ArrayList<Character>();
        // Set role to bystander by default
        role = 0;
    }

    // Create an Character with an image
    // Automatically set position to (0, 0) before moving them to their required position after generating the plot
    Character(int x_pos, int y_pos, String name, int job, Random rand, ArrayList<String> dialogue, String image_loc) {
        super(x_pos, y_pos, name);
        this.dialogue = dialogue;
        super.entity_image = loadImage(image_loc);
        // super.entity_image = loadImage("NPC_placeholder.png");
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
        if (!dialogue.contains(s)) {
            dialogue.add(s);
        }
    }

    ArrayList<String> getDialogue() {
        return dialogue;
    }

    String getDialogueHints() {
        String dialogue_hints = "";
        if (dialogue.size() == 1) {
            return "Sorry, I don't think I know anything useful.";
        } else {
            dialogue_hints = dialogue.get(1);
            for (int i = 2; i < dialogue.size(); i++) {
                dialogue_hints = dialogue_hints + " " + dialogue.get(i);
            }
        }
        return dialogue_hints;
    }

    String getGreeting() {
        return dialogue.get(0);
    }

    String getClueDialogue() {
        return dialogue.get(1);
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

    // Return dialogue about who the character was with
    // The characters are always truthful
    // TODO flesh this out
    public String getAlibiDialogue() {
        if (this.alibi_list.size() == 0) {
            return "I was on my own last night.";
        } else if (this.alibi_list.size() == 1) {
            return "I was with " + this.alibi_list.get(0).getName() + ". They can vouch for me!";
        } else {
            String alibi_string = "I wasn't alone, I was actually with " + this.alibi_list.get(0).getName();
            for (int i = 1; i < this.alibi_list.size() - 1; i++) {
                alibi_string = ", " + this.alibi_list.get(i).getName();
            }
            alibi_string = " and " + this.alibi_list.get(this.alibi_list.size() - 1).getName() + ".";
            return alibi_string;
        }
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

    // Simple sentence stating which weapons this character has access to
    String getWeaponAccessString() {
        String access_string = "";
        // n.b. in SatFileWriter we guarantee that every character has access to at least one weapon
        if (accessable_weapons.size() == 1) {
            access_string = "The only weapon I have access to is the " + accessable_weapons.get(0).getName();
        } else {
            access_string = "I have access to the " + accessable_weapons.get(0).getName();
            for (int i = 1; i < accessable_weapons.size() - 1; i++) {
                access_string = access_string + ", the " + accessable_weapons.get(i).getName();
            }
            access_string = access_string + " and the " + accessable_weapons.get(accessable_weapons.size() - 1).getName() + ".";
        }
        return access_string;
    }

    void setHasMotive(boolean has_motive) {
        this.has_motive = has_motive;
    }

    boolean hasMotive() {
        return this.has_motive;
    }
}
