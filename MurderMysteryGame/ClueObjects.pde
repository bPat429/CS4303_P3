import java.util.ArrayList;
// The objects for each interactable item which can be a clue
// Add new clues here
// For each clue (e.g. a knife) define a method creating that clue.
// That method must allow the clue to be relavant, or irrelevant using a boolean

final class ClueObjects {
    private ArrayList<ClueObject> clues;
    
    ClueObjects(Random rand, boolean[] clues_used) {
        clues = new ArrayList<ClueObject>();

        // Add John the Butler
        clues.add(createKnife(clues_used[0]));
    }

    public ArrayList<ClueObject> getClues() {
        return clues;
    }

    public ClueObject getClue(int i) {
        return clues.get(i);
    }

    public int len() {
        return clues.size();
    }

    private ClueObject createKnife(boolean is_relevant) {
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc;
        if (is_relevant) {
            image_loc = "bloody_knife.png";
            hints.add("This knife is covered in blood!");
            hints.add("The blade is chipped.");
        } else {
            image_loc = "knife.png";
            hints.add("A kitchen knife, razor sharp.");
            hints.add("There are no nicks on the blade, it's owner uses it well.");
        }
        // TODO figure out positioning of clues in the mansion
        return new ClueObject(-1, -1, 0, "knife", hints, image_loc);
    }
}
