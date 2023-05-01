import java.util.Random;
import java.util.ArrayList;

// Class used for handling plot generation, and the creation of interactables required for the plot
class PlotGenerator {
    private ArrayList<Interactable> interactables;
    private CharacterCast cast;
    private Random rand;

    PlotGenerator(CharacterCast cast, Random rand) {
        interactables = new ArrayList<Interactable>();

        // Randomly select a murderer from the cast
        NPC murderer = cast.getCharacter(rand.nextInt(cast.len()));
        boolean victim_chosen = false;
        NPC victim = null;
        // TODO include the possibility of suicide
        while (!victim_chosen) {
            // Randomly select a victim from the cast, avoid choosing the murderer
            victim = cast.getCharacter(rand.nextInt(cast.len()));
            victim_chosen = (victim != murderer);
        }

        // TODO Plug the cast into SAT and generate a murder mystery

        // TODO get rid of this filler method

        // Apply changes to the cast of characters according to the generated pla
        // TODO stop this from being hard-coded
        murderer = cast.getCharacter(0);
        murderer.setRole(1);
        victim = cast.getCharacter(1);
        victim.setRole(2);
        NPC bystander = cast.getCharacter(2);
        bystander.addDialogue("John hated Alistar, they argued frequently");
        
        for (int i = 0; i < cast.len(); i++) {
            // TODO properly place characters
            cast.getCharacter(i).setPosition(i + 1, i + 2);
        }


        ClueObjects clues = new ClueObjects(rand, new boolean[]{true});
        
        // TODO handle physical clues
        for (int i = 0; i < clues.len(); i++) {
            // TODO properly place clues in the mansion
            clues.getClue(i).setPosition(-i - 1, -i - 2);
            interactables.add(clues.getClue(i));
        }
    }
    
    ArrayList<Interactable> getInteractables() {
      return interactables;
    }
}
