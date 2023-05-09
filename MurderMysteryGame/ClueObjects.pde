// The objects for each interactable item which can be a clue (excluding the murder weapon)
// For each clue (e.g. a safe) define a method creating that clue.
// That method must allow the clue to be relevant, or irrelevant using a boolean
// Each clue relates to the murder motive

final class ClueObjects {
    private ArrayList<ClueObject> clues;
    
    ClueObjects(Random rand) {
        clues = new ArrayList<ClueObject>();
        clues.add(createNotebook());
        //clues.add(createCloth());
        clues.add(createSafe());
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
    
    // Creates a knife clue
    private ClueObject createNotebook() {
        ArrayList<String> hints = new ArrayList<String>();
        ArrayList<String> clue_hints = new ArrayList<String>();
        String image_loc = "notebook.png";
        String clue_image_loc = "bloodstained_notebook.png";
        clue_hints.add("This notebook is covered in blood!");
        clue_hints.add("There's a note in here that says 'I know what you did'");
        hints.add("A small notebook.");
        hints.add("It looks like it belongs to someone.");
        // TODO figure out positioning of clues in the mansion
        return new ClueObject(-1, -1, 0, "notebook", hints, clue_hints, image_loc, clue_image_loc);
    }
    
    /**private ClueObject createCloth() {
        ArrayList<String> hints = new ArrayList<String>();
        ArrayList<String> clue_hints = new ArrayList<String>();
        String image_loc = "cloth.png";
        String clue_image_loc = "bloody_cloth.png";
        clue_hints.add("This cloth is covered in blood!");
        clue_hints.add("It seems to have come from a torn piece of clothing.");
        hints.add("A small piece of cloth.");
        hints.add("It's too small to be of much use.");
        // TODO figure out positioning of clues in the mansion
        return new ClueObject(-1, -1, 0, "cloth", hints, clue_hints, image_loc, clue_image_loc);
    }**/
    
    private ClueObject createSafe() {
        ArrayList<String> hints = new ArrayList<String>();
        ArrayList<String> clue_hints = new ArrayList<String>();
        String image_loc = "safe.png";
        String clue_image_loc = "open_safe.png";
        clue_hints.add("This safe is empty.");
        clue_hints.add("There's an impression in the dust, as if something has been recently removed.");
        hints.add("A locked safe.");
        hints.add("There's no signs of disturbance here.");
        return new ClueObject(-1, -1, 0, "safe", hints, clue_hints, image_loc, clue_image_loc);
    }
}
