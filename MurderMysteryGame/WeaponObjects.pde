// The weapon objects. Kept separate from the non-weapon clues because these are used for the SAT procedural generation
// A weapon is a type of interactable representing the method of murder
// e.g. a bloody knife indicates a stabbing
// Exactly one weapon is used in each game
// Specific weapons are only available to certain characters
final class WeaponObjects {
    private ArrayList<Clue> weapons;
    
    WeaponObjects(Random rand) {
        weapons = new ArrayList<Clue>();
        weapons.add(createKnife());
        weapons.add(createCandlestick());
        weapons.add(createPoison());
    }

    public ArrayList<Clue> getWeapons() {
        return weapons;
    }

    public Clue getWeapon(int i) {
        return weapons.get(i);
    }

    public int len() {
        return weapons.size();
    }
    
    // Creates a knife clue
    private Clue createKnife() {
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc = "knife.png";
        hints.add("A kitchen knife, razor sharp.");
        hints.add("There are no nicks on the blade, it's owner uses it well.");
        Clue weapon = new Clue(-1, -1, 1, "knife", hints, image_loc);
        weapon.addHint(new ParameterisedDialogue("There are traces of blood on the hilt."));
        weapon.addHint(new ParameterisedDialogue("The blade is chipped."));
        // TODO figure out positioning of clues in the mansion
        return new Clue(-1, -1, 1, "knife", hints, image_loc);
    }

    // Creates a candlestick clue
    private Clue createCandlestick() {
        ArrayList<String> hints = new ArrayList<String>();
        ArrayList<String> clue_hints = new ArrayList<String>();
        String image_loc = "candlestick.png";
        String clue_image_loc = "bloodstained_candlestick.png";
        clue_hints.add("There's blood on this candlestick!");
        clue_hints.add("It looks like it was used to hit someone.");
        hints.add("A fancy silver candlestick.");
        hints.add("It looks expensive.");
        // TODO figure out positioning of clues in the mansion
        return new Clue(-1, -1, 1, "candlestick", hints, clue_hints, image_loc, clue_image_loc);
    }

    private Clue createPoison() {
        ArrayList<String> hints = new ArrayList<String>();
        ArrayList<String> clue_hints = new ArrayList<String>();
        String image_loc = "empty_bottle.png";
        String clue_image_loc = "poison_bottle.png";
        clue_hints.add("This bottle contains poison!");
        clue_hints.add("It seems to be missing some liquid.");
        hints.add("An empty bottle.");
        hints.add("There are no labels or markings on it.");
        // TODO figure out positioning of clues in the mansion
        return new Clue(-1, -1, 1, "poison", hints, clue_hints, image_loc, clue_image_loc);
    }
}
