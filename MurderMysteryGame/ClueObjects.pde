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
    // 2 = safe
    // 3 = family photo
    // 4 = discarded letter

    // TODO clue images
    
    ClueObjects(Random rand) {
        clues = new ArrayList<Clue>();
        clues.add(createBody());
        clues.add(createNotebook());
        clues.add(createSafe());
        clues.add(createFamilyPhoto());
        clues.add(createDiscardedLetter());
        //clues.add(createCloth());
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
        ArrayList<ParameterisedDialogue> parameterised_hints = new ArrayList<ParameterisedDialogue>();
        String image_loc = "body_outline.png";
        description.add("The victim's body.");
        return new Clue(-1, -1, "body", description, parameterised_hints, image_loc);
    }
    private Clue createNotebook() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<ParameterisedDialogue> parameterised_hints = new ArrayList<ParameterisedDialogue>();
        String image_loc = "notebook.png";
        description.add("A small notebook.");
        parameterised_hints.add(new ParameterisedDialogue("", " and ", " won't stop arguing, they're behaving like children!", 0));
        return new Clue(-1, -1, "notebook", description, parameterised_hints, image_loc);
    }

    private Clue createSafe() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<ParameterisedDialogue> parameterised_hints = new ArrayList<ParameterisedDialogue>();
        String image_loc = "safe.png";
        description.add("A safe.");
        parameterised_hints.add(new ParameterisedDialogue("", " and ", " won't stop arguing, they're behaving like children!", 0));
        return new Clue(-1, -1, "safe", description, parameterised_hints, image_loc);
    }
    private Clue createFamilyPhoto() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<ParameterisedDialogue> parameterised_hints = new ArrayList<ParameterisedDialogue>();
        String image_loc = "old_family_photo.png";
        description.add("An old family photo.");
        parameterised_hints.add(new ParameterisedDialogue("You recognise ", ", but no one else. On the back they have written: How can you rest mother, while ", 
            " goes unpunished.", 0));
        return new Clue(-1, -1, "family_photo", description, parameterised_hints, image_loc);
    }
    private Clue createDiscardedLetter() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<ParameterisedDialogue> parameterised_hints = new ArrayList<ParameterisedDialogue>();
        String image_loc = "discarded_letter_photo.png";
        description.add("A discarded letter.");
        parameterised_hints.add(new ParameterisedDialogue("The letter is addressed to ", 
            ", it reads: I cannot believe you're selling the sculpture, and to a complete stranger! I knew you didn't appreciate it as much as I do, but this is too far! We will discuss this when I return, ", "", 1));
        return new Clue(-1, -1, "family_photo", description, parameterised_hints, image_loc);
    }

    // private Clue createCloth() {
    //     ArrayList<String> description = new ArrayList<String>();
    //     ArrayList<ParameterisedDialogue> parameterised_hints = new ArrayList<ParameterisedDialogue>();
    //     String image_loc = "cloth.png";
    //     description.add("A small piece of cloth.");
    //     return new Clue(-1, -1, "cloth", description, parameterised_hints, image_loc);
    // }
}
