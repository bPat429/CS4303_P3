import java.util.ArrayList;
// The Character objects defining each character
// Add new characters here

final class CharacterCast {
    private ArrayList<Character> cast;

    CharacterCast(Random rand) {
        cast = new ArrayList<Character>();
        // n.b. The character's job in the house:
        // 0 = butler
        // 1 = maid
        // 2 = owner
        // 3 = chef
        // 4 = guest

        // Add John the Butler
        cast.add(new Character(4, 2, "John", 0, rand, johnButlerDialogue(), "characters/john.png"));   

        // Add Andrew, a maid
        cast.add(new Character(32, 5, "Andrew", 1, rand, andrewMaidDialogue(), "characters/andrew.png"));  

        // Add Jane, a maid
        cast.add(new Character(11, 14, "Jane", 1, rand, janeMaidDialogue(), "characters/jane.png"));  

        // Add Alicia the Lady of the house
        cast.add(new Character(19, 8, "Alicia", 2, rand, aliciaOwnerDialogue(), "characters/alicia.png"));

        // Add Humphrey, the chef
        cast.add(new Character(14, 3, "Humphrey", 3, rand, humphreyChefDialogue(), "characters/humphrey.png"));

        // Add Lawrence, a guest
        cast.add(new Character(24, 17, "Lawrence", 4, rand, lawrenceGuestDialogue(), "characters/lawrence.png"));

        // Add Elisabeth, a guest
        cast.add(new Character(26, 5, "Elisabeth", 4, rand, elisabethGuestDialogue(), "characters/elisabeth.png"));
    }

    public ArrayList<Character> getCast() {
        return cast;
    }

    public Character getCharacter(int i) {
        return cast.get(i);
    }

    public int len() {
        return cast.size();
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> johnButlerDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is John, I'm the butler.");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> andrewMaidDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Andrew, I'm a maid.");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> janeMaidDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Jane, I'm a maid.");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> aliciaOwnerDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Alicia, I own this mansion.");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> humphreyChefDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Humphrey, I'm the chef.");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> lawrenceGuestDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Lawrence, I'm a guest.");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> elisabethGuestDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Elisabeth, I'm a guest.");
        return dialogue;
    }
}
