import java.util.ArrayList;
import java.util.Random;

// The possible motives a character may have for murder

final class Motives {
    private ArrayList<MotiveType> motives;

    Motives(Random rand, ClueObjects clues) {
        motives = new ArrayList<MotiveType>();
        // Motives (TODO):
        // The murderer was in love with the victim, but the victim didn't reciprocate
        // The murderer and victim were rivals in affection for another character
        // The murderer was a psycopath

        // The murderer and victim were in a heated argument
        motives.add(new MotiveType("argument", rand, argumentDialogue(), argumentClues(clues)));   

        // The murderer believed the victim stole from them
        motives.add(new MotiveType("revenge", rand, revengeDialogue(), revengeClues(clues)));   

        // The murderer wanted something from the victim
        motives.add(new MotiveType("greed", rand, greedDialogue(), greedClues(clues)));
    }

    public ArrayList<MotiveType> getMotives() {
        return motives;
    }

    public MotiveType getMotiveType(int i) {
        return motives.get(i);
    }

    public MotiveType getRandomMotiveType() {
        return motives.get(rand.nextInt(motives.size()));
    }

    public int len() {
        return motives.size();
    }

    // Diaglogues

    private ArrayList<ParameterisedDialogue> argumentDialogue() {
        ArrayList<ParameterisedDialogue> dialogue = new ArrayList<ParameterisedDialogue>();
        ParameterisedDialogue new_dialogue = new ParameterisedDialogue("I heard ", " and ", " shouting at each other yesterday!", 0);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("", " told me that they were arguing with ", " last night.", 1);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("Everyone knows ", " was always arguing with ", ".", 1);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("", " is always getting into fights. I think they had somethign to do with it.", "", 2);
        dialogue.add(new_dialogue);
        return dialogue;
    }

    private ArrayList<ParameterisedDialogue> revengeDialogue() {
        ArrayList<ParameterisedDialogue> dialogue = new ArrayList<ParameterisedDialogue>();
        ParameterisedDialogue new_dialogue = new ParameterisedDialogue("They never told me why, but ", " always had a grudge against ", ".", 0);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("'s sister passed last year, and ", " has wanted to get back at ", " ever since.", 3);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("'s brother passed a few years ago, and ", " has always blamed ", " for it.", 3);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("I heard ", " stole from ", " but no one could prove it!", 1);
        dialogue.add(new_dialogue);
        return dialogue;
    }

    private ArrayList<ParameterisedDialogue> greedDialogue() {
        ArrayList<ParameterisedDialogue> dialogue = new ArrayList<ParameterisedDialogue>();
        ParameterisedDialogue new_dialogue = new ParameterisedDialogue("", " told me that they left a lot to ", " in their will. I'm so jealous.", 1);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue(" had a beautiful painting of the sea. ", " was always asking to borrow it, but ", " never let them.", 4);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue(" had a vintage car. ", " was always asking to take it for a drive, but ", " never let them.", 4);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue(" had a kashmir scarf. ", " loved to borrow it, and always looked so angry when ", " took it back.", 4);
        dialogue.add(new_dialogue);
        new_dialogue = new ParameterisedDialogue("I feel so sorry for ", ". They were really close with ", ". They were even on each other's life insurance!", 0);
        dialogue.add(new_dialogue);
        return dialogue;
    }

    // Clues
    // n.b. Each distinct clue (e.g. Notebook) may only be a clue for one type of method

    private ArrayList<Clue> argumentClues(ClueObjects clues) {
        ArrayList<Clue> method_clues = new ArrayList<Clue>();
        // Notebook
        method_clues.add(clues.getClue(1));
        return method_clues;
    }

    private ArrayList<Clue> revengeClues(ClueObjects clues) {
        ArrayList<Clue> method_clues = new ArrayList<Clue>();
        // An old family photo
        method_clues.add(clues.getClue(3));
        return method_clues;
    }

    private ArrayList<Clue> greedClues(ClueObjects clues) {
        ArrayList<Clue> method_clues = new ArrayList<Clue>();
        // discarded letter
        method_clues.add(clues.getClue(4));
        return method_clues;
    }
}