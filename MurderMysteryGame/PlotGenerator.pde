import java.util.Random;
import java.util.ArrayList;
import org.sat4j.core.*;
import java.lang.Math;

// Class used for handling plot generation, and the creation of interactables required for the plot
class PlotGenerator {
    private CharacterCast cast;
    private WeaponObjects weapons;
    private ClueObjects clues;
    private Character murderer;
    private Character victim;
    private Random rand;

    PlotGenerator(Random rand) {
        // Initialise all cast, weapons and clues
        cast = new CharacterCast(rand);
        weapons = new WeaponObjects(rand);
        clues = new ClueObjects(rand);
        
        SatFileWriter sat_writer = new SatFileWriter(cast, weapons, rand);

        // TODO Plug the cast into SAT and generate a murder mystery
        IProblem problem = runSolver();
        if (problem == null) {
            System.out.println("Error, plot generation has failed");
            return;
        }

        // Apply changes to the cast of characters according to the generated plan
        applyPlot(problem);
        Motives motives = new Motives(rand, clues);

        int victim_index = sat_writer.getVictimIndex();

        // For each character with a motive seed either a clue, or a dialogue line in another living character indicating the motive
        for (int a = 0; a < cast.len(); a++) {
            if (cast.getCharacter(a).hasMotive()) {
                boolean clue_seeded = false;
                // Choose a type of motive
                MotiveType motive_type = motives.getRandomMotiveType();

                while (!clue_seeded) {
                    // Try to add motive as a clue
                    if (rand.nextInt(2) == 1) {
                        Clue indicating_clue = motive_type.getRandomClue();
                        if (!indicating_clue.isRelevant()) {
                            indicating_clue.setRelevance(true);
                            indicating_clue.setSuspectName(cast.getCharacter(a).getName());
                            indicating_clue.setVictimName(cast.getCharacter(victim_index).getName());
                            clue_seeded = true;
                        }
                    } else {
                        String dialogue_clue = motive_type.getRandomHint(cast.getCharacter(a).getName(), cast.getCharacter(victim_index).getName());
                        boolean dialogue_seeded = false;
                        while(!dialogue_seeded) {
                            for (int b = 0; b < cast.len(); b++) {
                                if (a != b && cast.getCharacter(b).getRole() != 2) {
                                    // Multiple people can have the same clue, usually only 1.
                                    if (rand.nextInt(cast.len() - 2) == 0) {
                                        cast.getCharacter(b).addDialogue(dialogue_clue);
                                        dialogue_seeded = true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }


        // int murderer_index = 0;
        // int victim_index = 1;
        // murderer = cast.getCharacter(0);
        // murderer.setRole(1);
        // victim = cast.getCharacter(1);
        // victim.setRole(2);
        // Character bystander = cast.getCharacter(2);
        // bystander.addDialogue("John hated Alistar, they argued frequently");
        
        // for (int i = 0; i < cast.len(); i++) {
        //     // TODO properly place characters
        //     cast.getCharacter(i).setPosition(i + 1, i + 2);
        // }
        
        // // TODO handle physical clues
        // for (int i = 0; i < clues.len(); i++) {
        //     // TODO properly place clues in the mansion
        //     clues.getClue(i).setPosition(-i - 1, -i - 2);
        //     interactables.add(clues.getClue(i));
        // }
    }

    CharacterCast getCast() {
      return cast;
    }

    WeaponObjects getWeapons() {
      return weapons;
    }

    ClueObjects getClues() {
      return clues;
    }

    IProblem runSolver() {
        // Use greedy solver because it uses the RandomWalkDecorator from sat4j
        ISolver solver = SolverFactory.newGreedySolver();
        solver.setTimeout(10); // 10 second timeout
        Reader reader = new DimacsReader(solver);
        PrintWriter out = new PrintWriter(System.out,true);
        // CNF filename is given on the command line 
        try {
            String filename = sketchPath() + "/data/sat/SatProblem.txt";
            IProblem problem = reader.parseInstance(filename);
            if (problem.isSatisfiable()) {
                System.out.println("Satisfiable !");
                reader.decode(problem.model(),out);
                System.out.println(problem.model(1));
                return problem;
            } else {
                System.out.println("Unsatisfiable !");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    void applyPlot(IProblem problem) {
        int n = cast.len();
        int m = weapons.len();
        int offset = applyAlibis(problem);
        // Add the 'has alibi' offset
        offset = offset + n;
        offset = applyWeaponAccess(problem, offset);
        offset = applyMotives(problem, offset);
        // Add the 'has murdered' offset
        offset = offset + 1;
        // Add the 'is murderer' offset
        offset = offset + n;
        // Add the 'is victim' offset
        offset = offset + n;
        // Add the 'is bystander' offset
        offset = offset + n;
        // Add the 'has used weapon' offset
        offset = offset + 1;
        // TODO weapon used
        offset = applyWeaponUsed(problem, offset);
    }

    // Map Dimacs variables back to useful values
    // These applyX functions must be applied in order to track the offset correctly
    int applyAlibis(IProblem problem) {
        int offset = 1;
        int n = cast.len();
        // Use the same formulae as in SatFileWriter to convert fluents to specific ints
        for (int a = 0; a < n; a++) {
            for (int b = 0; b < n; b++) {
                if (problem.model(offset + b + a * n)) {
                    cast.getCharacter(a).addAlibi(cast.getCharacter(b));
                }
            }
        }
        // Return the new offset
        return offset + (int) Math.pow(n, 2);
    }

    int applyWeaponAccess(IProblem problem, int offset) {
        int n = cast.len();
        int m = weapons.len();
        // Use the same formulae as in SatFileWriter to convert fluents to specific ints
        for (int a = 0; a < n; a++) {
            for (int b = 0; b < m; b++) {
                if (problem.model(offset + b + a * m)) {
                    cast.getCharacter(a).addWeaponAccess(weapons.getWeapon(b));
                }
            }
        }
        // Return the new offset
        return offset + n*m;
    }

    int applyMotives(IProblem problem, int offset) {
        int n = cast.len();
        // Use the same formulae as in SatFileWriter to convert fluents to specific ints
        for (int a = 0; a < n; a++) {
            cast.getCharacter(a).setHasMotive(problem.model(offset + a));
        }
        // Return the new offset
        return offset + n;
    }

    // Also add a clue to the body which describes the type of weapon used
    int applyWeaponUsed(IProblem problem, int offset) {
        int m = weapons.len();
        // Use the same formulae as in SatFileWriter to convert fluents to specific ints
        for (int c = 0; c < m; c++) {
            weapons.getWeapon(c).setRelevance(problem.model(offset + c));
            if (problem.model(offset + c)) {
                String murdered_by = "";
                if (weapons.getWeapon(c).getType() == 0) {
                    murdered_by = " was poisoned";
                } else if (weapons.getWeapon(c).getType() == 1) {
                    murdered_by = " was stabbed";
                } else if (weapons.getWeapon(c).getType() == 2) {
                    murdered_by = " was bludgeoned";
                }
                clues.getBody().addHint(new ParameterisedDialogue("The police report says ", murdered_by, "", 5));
                clues.getBody().setRelevance(true);
            }
        }
        // Return the new offset
        return offset + m;
    }

    
}
