// The objects for each interactable item which can be a clue (excluding the murder weapon)
// For each clue (e.g. a safe) define a method creating that clue.
// Each clue object can be used to prove a specific motive, e.g. a diary can
// describe how one chacter desparately wanted something from the victim.
// n.b. Not all of these are relevant to the motives, some are just for decoration

final class ClueObjects {
    private ArrayList<ClueObject> clues;
    // Clue indexes:
    // 0 = body
    // 1 = notebook
    // 2 = cloth
    // 3 = safe
    
    ClueObjects(Random rand) {
        clues = new ArrayList<ClueObject>();
        clues.add(createBody());
        clues.add(createNotebook());
        clues.add(createCloth());
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
    // n.b. Always add a clue about which weapon type was used
    private ClueObject createBody() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "body_outline.png";
        description.add("The victim's body.");
        return new ClueObject(-1, -1, 0, "body", description, image_loc);
    }
    private ClueObject createNotebook() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "notebook.png";
        description.add("A small notebook.");
        return new ClueObject(-1, -1, 0, "notebook", description, image_loc);
    }
    
    private ClueObject createCloth() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "cloth.png";
        description.add("A small piece of cloth.");
        return new ClueObject(-1, -1, 0, "cloth", description, image_loc);
    }
    private ClueObject createSafe() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "safe.png";
        description.add("A locked safe.");
        return new ClueObject(-1, -1, 0, "safe", description, image_loc);
    }
}
