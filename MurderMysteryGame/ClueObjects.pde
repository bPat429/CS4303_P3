// The objects for each interactable item which can be a clue
// Add new clues here
// For each clue (e.g. a knife) define a method creating that clue.
// That method must allow the clue to be relevant, or irrelevant using a boolean

final class ClueObjects {
    private ArrayList<ClueObject> clues;
    
    ClueObjects(Random rand, boolean[] clues_used) {
        clues = new ArrayList<ClueObject>();

        // Add John the Butler
        clues.add(createJohnTheButler(clues_used[6]));
        clues.add(createKnife(clues_used[0]));
        clues.add(createCandlestick(clues_used[1]));
        clues.add(createNotebook(clues_used[2]));
       clues.add(createPoison(clues_used[3]));
       clues.add(createCloth(clues_used[4]));
       clues.add(createSafe(clues_used[5]));

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
private ClueObject createJohnTheButler(boolean is_relevant) {
    ArrayList<String> hints = new ArrayList<String>();
    String image_loc;
    if (is_relevant) {
        image_loc = "john_the_butler.png";
        hints.add("John the Butler was seen near the victim's room shortly before the murder.");
        hints.add("He seemed nervous and evasive when questioned by the police.");
    } else {
        image_loc = "john_the_butler.png";
        hints.add("John the Butler is a long-serving employee of the mansion.");
        hints.add("He is known to be punctual and discreet.");
    }
    // Set the position of the clue in the mansion
  
    return new ClueObject(5, 7, 1, "john_the_butler", hints, image_loc);
}
    // Creates a knife clue
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

    // Creates a candlestick clue
    private ClueObject createCandlestick(boolean is_relevant) {
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc;
        if (is_relevant) {
            image_loc = "bloodstained_candlestick.png";
            hints.add("There's blood on this candlestick!");
            hints.add("It looks like it was used to hit someone.");
        } else {
            image_loc = "candlestick.png";
            hints.add("A fancy silver candlestick.");
            hints.add("It looks expensive.");
        }
        // TODO figure out positioning of clues in the mansion
        return new ClueObject(-1, -1, 0, "candlestick", hints, image_loc);
    }

private ClueObject createPoison(boolean is_relevant) {
    ArrayList<String> hints = new ArrayList<String>();
    String image_loc;
    if (is_relevant) {
        image_loc = "poison_bottle.png";
        hints.add("This bottle contains poison!");
        hints.add("It seems to be missing some liquid.");
    } else {
        image_loc = "empty_bottle.png";
        hints.add("An empty bottle.");
        hints.add("There are no labels or markings on it.");
    }
    // TODO figure out positioning of clues in the mansion
    return new ClueObject(-1, -1, 0, "poison", hints, image_loc);
}

    // Creates a notebook clue
    private ClueObject createNotebook(boolean is_relevant) {
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc;
        if (is_relevant) {
            image_loc = "bloodstained_notebook.png";
            hints.add("This notebook is covered in blood!");
            hints.add("There's a note in here that says 'I know what you did'");
        } else {
            image_loc = "notebook.png";
            hints.add("A small notebook.");
            hints.add("It looks like it belongs to someone.");
        }
        // TODO figure out positioning of clues in the mansion
        return new ClueObject(-1, -1, 0, "notebook", hints, image_loc);
    }
    
    private ClueObject createCloth(boolean is_relevant) {
    ArrayList<String> hints = new ArrayList<String>();
    String image_loc;
    if (is_relevant) {
        image_loc = "bloody_cloth.png";
        hints.add("This cloth is covered in blood!");
        hints.add("It seems to have come from a torn piece of clothing.");
    } else {
        image_loc = "cloth.png";
        hints.add("A small piece of cloth.");
        hints.add("It's too small to be of much use.");
    }
    // TODO figure out positioning of clues in the mansion
    return new ClueObject(-1, -1, 0, "cloth", hints, image_loc);
}
private ClueObject createSafe(boolean is_relevant) {
    ArrayList<String> hints = new ArrayList<String>();
    String image_loc;
    if (is_relevant) {
        image_loc = "safe.png";
        hints.add("This safe is locked!");
        hints.add("There's a piece of paper with a combination nearby.");
    } else {
        image_loc = "open_safe.png";
        hints.add("An open safe.");
        hints.add("There's nothing inside.");
    }
    // TODO figure out positioning of clues in the mansion
    return new ClueObject(-1, -1, 0, "safe", hints, image_loc);
}
 
    
    
    
}
