import java.util.Random;
// A motive contains:
// the motive (e.g. being blackmailed),
// a list of dialogue options from bystanders hinting at the motive
// a list of ClueObject which can be used to demonstrate the motive
class Motive {
  private String motive;
  private ArrayList<ParameterisedDialogue> dialogue_hints;
  private ArrayList<ClueObject> relevant_clues;
  private Random rand;

  Motive(String motive, Random rand, ArrayList<ParameterisedDialogue> dialogue_hints, ArrayList<ClueObject> relevant_clues) {
    this.motive = motive;
    this.dialogue_hints = dialogue_hints;
    this.relevant_clues = relevant_clues;
    this.rand = rand;
  }
  
  public String getMotive() {
    return motive;
  }

  public ArrayList<ParameterisedDialogue> getDialogueHints() {
    return dialogue_hints;
  }

  public String getRandomHint(String suspect, String victim) {
    return dialogue_hints.get(rand.nextInt(dialogue_hints.size())).getString(suspect, victim);
  }

  public ArrayList<ClueObject> getClues() {
    return relevant_clues;
  }

  public String getRandomClue() {
    return relevant_clues.get(rand.nextInt(relevant_clues.size()));
  }
}
