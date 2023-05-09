import java.util.ArrayList;
import java.util.Random;

// The possible motives a character may have for murder

final class Motives {
    private ArrayList<Motive> motives;

    Motives(Random rand) {
        motives = new ArrayList<Motive>();
        // Motives (TODO):
        // The murderer was in love with the victim, but the victim didn't reciprocate
        // The murderer and victim were rivals in affection for another character
        // The murderer was a psycopath

        // The murderer and victim were in a heated argument
        motives.add(new Motive("argument", rand, argumentDialogue(), argumentClues()));   

        // The murderer believed the victim stole from them
        motives.add(new Motive("revenge", rand, revengeDialogue(), revengeClues()));   

        // The murderer wanted something from the victim
        motives.add(new Motive("greed", rand, greedDialogue(), greedClues()));
    }

    public ArrayList<Motive> getMotives() {
        return motives;
    }

    public Motive getMotive(int i) {
        return motives.get(i);
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

    // Clues TODO

    private ArrayList<ClueObject> argumentClues() {
        ArrayList<ClueObject> clues = new ArrayList<ClueObject>();
        return clues;
    }

    private ArrayList<ClueObject> revengeClues() {
        ArrayList<ClueObject> clues = new ArrayList<ClueObject>();
        return clues;
    }

    private ArrayList<ClueObject> greedClues() {
        ArrayList<ClueObject> clues = new ArrayList<ClueObject>();
        return clues;
    }
}