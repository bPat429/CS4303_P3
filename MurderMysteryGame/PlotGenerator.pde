import java.util.Random;
import java.util.ArrayList;
import org.sat4j.core.*;

// Class used for handling plot generation, and the creation of interactables required for the plot
class PlotGenerator {
    private ArrayList<Interactable> interactables;
    private CharacterCast cast;
    private Character murderer;
    private Character victim;
    private Random rand;

    PlotGenerator(CharacterCast cast, Random rand) {
        interactables = new ArrayList<Interactable>();
        
        SatFileWriter sat_writer = new SatFileWriter(cast, rand);

        // TODO Plug the cast into SAT and generate a murder mystery
        // runSolver();

        // TODO get rid of this filler method

        // Apply changes to the cast of characters according to the generated plan
        // TODO stop this from being hard-coded
        int murderer_index = 0;
        int victim_index = 1;
        murderer = cast.getCharacter(0);
        murderer.setRole(1);
        victim = cast.getCharacter(1);
        victim.setRole(2);
        Character bystander = cast.getCharacter(2);
        bystander.addDialogue("John hated Alistar, they argued frequently");
        
        for (int i = 0; i < cast.len(); i++) {
            // TODO properly place characters
            cast.getCharacter(i).setPosition(i + 1, i + 2);
        }

        ClueObjects clues = new ClueObjects(rand, new boolean[]{true});
        
        // TODO handle physical clues
        for (int i = 0; i < clues.len(); i++) {
            // TODO properly place clues in the mansion
            clues.getClue(i).setPosition(-i - 1, -i - 2);
            interactables.add(clues.getClue(i));
        }
    }

    ArrayList<Interactable> getInteractables() {
      return interactables;
    }

    void runSolver() {
        ISolver solver = SolverFactory.newDefault();
        solver.setTimeout(10); // 10 second timeout
        Reader reader = new DimacsReader(solver);
        PrintWriter out = new PrintWriter(System.out,true);
        // CNF filename is given on the command line 
        try {
            String filename = sketchPath() + "/data/sat/SatProblem.txt";
            System.out.println(sketchPath());
            IProblem problem = reader.parseInstance(filename);
            if (problem.isSatisfiable()) {
                System.out.println("Satisfiable !");
                reader.decode(problem.model(),out);
            } else {
                System.out.println("Unsatisfiable !");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
