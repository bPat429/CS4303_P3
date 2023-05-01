import java.util.ArrayList;
// The NPC objects defining each character
// Add new characters here

final class CharacterCast {
    private ArrayList<NPC> cast;

    CharacterCast(Random rand) {
        cast = new ArrayList<NPC>();
        // n.b. The character's job in the house:
        // 0 = butler
        // 1 = maid
        // 2 = owner
        // 3 = chef
        // 4 = guest

        // Add John the Butler
        cast.add(new NPC("John", 0, rand, johnButlerDialogue()));   

        // Add Andrew the Maid
        cast.add(new NPC("Andrew", 1, rand, andrewMaidDialogue()));   

        // Add Elisa the Lady of the house
        cast.add(new NPC("Elisa", 2, rand, elisaOwnerDialogue()));
    }

    public ArrayList<NPC> getCast() {
        return cast;
    }

    public NPC getCharacter(int i) {
        return cast.get(i);
    }

    public int len() {
        return cast.size();
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> johnButlerDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is John");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> andrewMaidDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Andrew");
        return dialogue;
    }

    // Default dialogue for this character (not including clues)
    private ArrayList<String> elisaOwnerDialogue() {
        ArrayList<String> dialogue = new ArrayList<String>();
        dialogue.add("Hello my name is Elisa");
        return dialogue;
    }
}
