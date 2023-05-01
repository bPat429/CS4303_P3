import java.util.Random;
import java.util.ArrayList;

// Class for Non player characters
// N.b. if we want to implement roaming we'll have to change this to extend Entity, not Interactable
class NPC extends Interactable {
    // keep a copy of rand so we can randomly choose between dialogue options etc.
    Random rand;
    private ArrayList<String> dialogue;
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


    // Create an NPC
    // Automatically set position to (0, 0) before moving them to their required position after generating the plot
    NPC(String name, int job, Random rand, ArrayList<String> dialogue, String image_loc) {
        super(0, 0, 1, name);
        this.dialogue = dialogue;
        super.interactable_image = loadImage(image_loc);
        this.job = job;
        this.rand = rand;
        // Set role to bystander by default
        role = "bystander";
    }

    void addDialobue(String s) {
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
        super.setLocation(x_pos, y_pos)
    }
}
