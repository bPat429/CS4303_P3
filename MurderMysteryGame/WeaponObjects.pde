// The weapon objects. Kept separate from the non-weapon clues because these are used for the SAT procedural generation
// A weapon is a type of interactable representing the method of murder
// e.g. a bloody knife indicates a stabbing
// Exactly one weapon is used in each game
// Specific weapons are only available to certain characters
final class WeaponObjects {
    private ArrayList<Weapon> weapons;
    
    WeaponObjects(Random rand) {
        weapons = new ArrayList<Weapon>();
        weapons.add(createKnife());
        weapons.add(createPoison());
        weapons.add(createCandlestick());
    }

    public ArrayList<Weapon> getWeapons() {
        return weapons;
    }

    public Weapon getWeapon(int i) {
        return weapons.get(i);
    }

    public int len() {
        return weapons.size();
    }
    
    // Creates a knife clue
    private Weapon createKnife() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc = "knife.png";
        String relevant_image_loc = "bloody_knife.png";
        description.add("A kitchen knife, razor sharp.");
        hints.add("There are traces of blood on the hilt.");
        hints.add("The blade is chipped.");
        return new Weapon(25, 10, "knife", 1, description, hints, image_loc, relevant_image_loc);
    }

    // Creates a candlestick clue
    private Weapon createCandlestick() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc = "candlestick.png";
        String relevant_image_loc = "bloodstained_candlestick.png";
        hints.add("There's blood on this candlestick!");
        hints.add("It looks like it was used to hit someone.");
        description.add("A fancy silver candlestick.");
        // TODO figure out positioning of clues in the mansion
        return new Weapon(3, 12, "candlestick", 2, description, hints, image_loc, relevant_image_loc);
    }

    private Weapon createPoison() {
        ArrayList<String> description = new ArrayList<String>();
        ArrayList<String> hints = new ArrayList<String>();
        String image_loc = "poison_bottle.png";
        String relevant_image_loc = "half_empty_poison_bottle.png";
        description.add("A bottle of rat poison.");
        hints.add("The bottle is half full.");
        hints.add("There is some spilled liquid, it has been used recently.");
        // TODO figure out positioning of clues in the mansion
        return new Weapon(1,5, "poison", 0, description, hints, image_loc, relevant_image_loc);
    }
}
