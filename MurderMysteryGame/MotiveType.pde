import java.util.Random;
// A motive contains:
// the motive (e.g. being blackmailed),
// a list of dialogue options from bystanders hinting at the motive
// a list of clue which can be used to demonstrate the motive
class MotiveType {
  private String motive;
  private ArrayList<ParameterisedDialogue> dialogue_hints;
  private ArrayList<Clue> relevant_clues;
  private Random rand;

  MotiveType(String motive, Random rand, ArrayList<ParameterisedDialogue> dialogue_hints, ArrayList<Clue> relevant_clues) {
    this.motive = motive;
    this.dialogue_hints = dialogue_hints;
    this.relevant_clues = relevant_clues;
    this.rand = rand;
  }
  
  public String getMotiveType() {
    return motive;
  }

  public ArrayList<ParameterisedDialogue> getDialogueHints() {
    return dialogue_hints;
  }

  public String getRandomHint(String suspect, String victim) {
    return dialogue_hints.get(rand.nextInt(dialogue_hints.size())).getDialogue(suspect, victim);
  }

  public ArrayList<Clue> getClues() {
    return relevant_clues;
  }

  public Clue getRandomClue() {
    return relevant_clues.get(rand.nextInt(relevant_clues.size()));
  }
}
