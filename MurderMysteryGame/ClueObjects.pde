// The objects for each interactable item which can be a clue (excluding the murder weapon)
// For each clue (e.g. a safe) define a method creating that clue.
// Each clue object can be used to prove a specific motive, e.g. a diary can
// describe how one chacter desparately wanted something from the victim.
// n.b. Not all of these are relevant to the motives, some are just for decoration

final class ClueObjects {
    private ArrayList<Clue> clues;
    // Clue indexes:
    // 0 = body
    // 1 = notebook
    // 2 = cloth
    // 3 = safe
    
    ClueObjects(Random rand) {
        clues = new ArrayList<Clue>();
        clues.add(createBody());
        clues.add(createNotebook());
        //clues.add(createCloth());
        clues.add(createSafe());
    }

    public ArrayList<Clue> getClues() {
        return clues;
    }

    public Clue getClue(int i) {
        return clues.get(i);
    }

    // Get the body of the victim
    public Clue getBody() {
        return clues.get(0);
    }

    public int len() {
        return clues.size();
    }
    // n.b. Always add a clue about which weapon type was used
    private Clue createBody() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "body_outline.png";
        description.add("The victim's body.");
        return new Clue(-1, -1, "body", description, image_loc);
    }
    private Clue createNotebook() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "notebook.png";
        description.add("A small notebook.");
        return new Clue(-1, -1, "notebook", description, image_loc);
    }
    
    private Clue createCloth() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "cloth.png";
        description.add("A small piece of cloth.");
        return new Clue(-1, -1, "cloth", description, image_loc);
    }
    private Clue createSafe() {
        ArrayList<String> description = new ArrayList<String>();
        String image_loc = "safe.png";
        description.add("A locked safe.");
        return new Clue(-1, -1, "safe", description, image_loc);
    }
}
