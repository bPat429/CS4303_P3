import java.io.File;

// Class used to handle writing the SAT file
class SatFileWriter {
    private ArrayList<Interactable> interactables;
    private ArrayList<String> sat_clauses;
    private CharacterCast cast;
    private Random rand;
    private String satFilePath;
    private PrintWriter sat_file;
    private int n;
    private int m;

    SatFileWriter(CharacterCast cast, Random rand) {
        interactables = new ArrayList<Interactable>();
        // Find n and m
        n = cast.len();
        m = interactables.size();

        // Randomly select a murderer from the cast
        // Do this outside of SAT for convenience
        Character murderer = cast.getCharacter(rand.nextInt(cast.len()));
        boolean victim_chosen = false;
        Character victim = null;
        // TODO include the possibility of suicide ?
        while (!victim_chosen) {
            // Randomly select a victim from the cast, avoid choosing the murderer
            victim = cast.getCharacter(rand.nextInt(cast.len()));
            victim_chosen = (victim != murderer);
        }

        satFilePath = sketchPath() + "/data/sat/SatProblem.txt";
        clearSATFile();
        sat_file = createWriter("./data/sat/SatProblem.txt");
        
        writeComments(sat_file);
        // Use one line for each fluent
        int fluents_needed = countFluentsNeeded();
        sat_clauses = new ArrayList<String>();
        generateClauses();
        writeSatFile(sat_file);

        sat_file.flush();
        sat_file.close();
    }

    void writeComments(PrintWriter output_file) {
        output_file.println("c The Problem describing the plan needed for the murder mystery story");
        sat_file.flush();
    }

    void writeSatFile(PrintWriter output_file) {
        output_file.println("p cnf " + countFluentsNeeded() + " " + sat_clauses.size());
        for (int i = 0; i < sat_clauses.size(); i++) {
            output_file.println(sat_clauses.get(i));
        }
    }

    void clearSATFile() {
        File f = new File(satFilePath);
        if (f.exists()) {
            f.delete();
        }
    }

    int countFluentsNeeded() {
        // Let n = Number of Characters, m = Number of weapons. a, b are characters. c is a weapon.
        // Counting fluents needed for each character:
        // 1. alibi(a, b): Each character (a) may have an alibi with character (b). Count = n^2
        // 2. has_alibi(a): Each character (a) may have an alibi. Count = n
        // 3. has_access(a, c): Each character (a) may have access to weapon (c). Count = n*m
        // 4. motive(a): Each character (a) may have motive for the murder. Count = n
        // 5. murdered(a, b): Character (a) has murdered Character (b). a and b are pre-chosen. Count = 1.
        // 6. Murderer(a): Character (a) is the murderer. This role is pre-chosen. Count = n
        // 7. Victim(a): Character (a) is the victim. This role is pre-chosen. Count = n
        // 8. Bystander(a): Character (a) is neither Murderer nor Victim. This role is pre-chosen. Count = n
        int character_fluent_count = n^2 + n + n*m + n + 1 + n + n + n;

        // Counting fluents needed for each weapon:
        // 1. has_used_weapon(a): Character (a) is the murderer and has used exactly one weapon. Count = 1 because we know the murderer
        // 2. weapon(c): Weapon (c) was used for the murder. Count = m
        // 3. murder_weapon_access(a, c): Person (a) has access to Weapon (c) which was used for the murder. Count = n
        int weapon_fluent_count = 1 + m + n;
        return weapon_fluent_count + character_fluent_count;
    }

    void addClause(String clause) {
        sat_clauses.add(clause + " 0");
    }

    void generateClauses() {
        generateAlibiClauses();
        generateHasAlibiClauses();
        generateHasMurderedClauses();
        generateIsMurdererClauses(); // TODO
        generateIsVictimClauses(); // TODO
        generateIsBystanderClauses(); // TODO
        generateHasUsedWeaponClauses();



    }

    // Generate all alibi clauses for each character
    void generateAlibiClauses() {
        // If Character a and b share an alibi then neither are murderer, or victim, and both have alibi's
        for (int a = 0; a < n; a++) {
            addClause("-" + getAlibiFluent(a, a));
            for (int b = 0; b < n; b++) {
                if (a != b) {
                    generateAlibiString(a, b);
                }
            }
        }
    }

    // Generate all strings required for each alibi
    void generateAlibiString(int char_a, int char_b) {
        int alibi_a_b = getAlibiFluent(char_a, char_b);
        int alibi_b_a = getAlibiFluent(char_b, char_a);
        int murderer_a = getIsMurdererFluent(char_a);
        int victim_a = getIsVictimFluent(char_a);
        int has_alibi_a = getHasAlibiFluent(char_a);
        String clause = "-" + alibi_a_b + " " + alibi_b_a;
        addClause(clause);
        clause = "-" + alibi_a_b + " -" + murderer_a;
        addClause(clause);
        clause = "-" + alibi_a_b + " -" + victim_a;
        addClause(clause);
        clause = "-" + alibi_a_b + " " + has_alibi_a;
        addClause(clause);
    }

    // Generate all has_alibi clauses for each character
    void generateHasAlibiClauses() {
        // If Character a has an alibi then they have an alibi with at least one other person
        for (int a = 0; a < n; a++) {
            int has_alibi_a = getHasAlibiFluent(a);
            String clause = "";
            for (int b = 0; b < n; b++) {
                if (a != b) {
                    int alibi = getAlibiFluent(a, b);
                    if (b == 0 || (a == 0 && b == 1)) {
                        clause = clause + alibi;
                    } else {
                        clause = clause + " " + alibi;
                    }
                }
            }
            addClause(clause);
        }
    }

    // No clauses required for 'has_access'. TODO consider adding character job based restrictions.

    // No clauses required for 'has_motive'.

    // Generate all has_murdered clauses
    void generateHasMurderedClauses() {
        // If character a murders b then a and b both don't have an alibi, a has a motive and the weapon c has been used
        // We already know the identity of the murderer and victim, so only generate the clauses for them.
        // TODO
        int murderer_index = -1;
        int victim_index = -1;
        int murdered_a_b = getHasMurderedFluent();
        int has_alibi_a = getHasAlibiFluent(murderer_index);
        int has_alibi_b = getHasAlibiFluent(victim_index);
        int has_used_weapon = getHasUsedWeaponFluent();
        String clause = "-" + murdered_a_b + " -" + has_alibi_a;
        addClause(clause);
        clause = "-" + murdered_a_b + " -" + has_alibi_b;
        addClause(clause);
        clause = "-" + murdered_a_b + " " + has_used_weapon;
        addClause(clause);
        // Manualoly assert that this is always true
        clause = Integer.toString(murdered_a_b);
        addClause(clause);
    }

    // Generate all is_murderer clauses
    void generateIsMurdererClauses() {
        // Set which character is the murderer
        int murderer_index = -1;
        String clause;
        for (int a = 0; a < n; a++) {
            int murderer_a = getIsMurdererFluent(a);
            if (a == murderer_index) {
                clause = Integer.toString(murderer_a);
            } else {
                clause = "-" + murderer_a;
            }
            addClause(clause);
        }
    }

    // Generate all is_victim clauses
    void generateIsVictimClauses() {
        // Set which character is the victim
        int victim_index = -1;
        String clause;
        for (int a = 0; a < n; a++) {
            int victim_a = getIsVictimFluent(a);
            if (a == victim_index) {
                clause = Integer.toString(victim_a);
            } else {
                clause = "-" + victim_a;
            }
            addClause(clause);
        }
    }

    // Generate all is_bystander clauses
    void generateIsBystanderClauses() {
        // Set which characters are bystanders
        // Assert that if character a is a bystander then they do not have all of: no alibi, access to the murder weapon, motive
        int murderer_index = -1;
        int victim_index = -1;
        String clause;
        for (int a = 0; a < n; a++) {
            int bystander_a = getIsBystanderFluent(a);
            int alibi_a = getHasAlibiFluent(a);
            int motive_a = getHasMotiveFluent(a);
            if (a == victim_index || a == murderer_index) {
                clause = "-" + bystander_a;
            } else {
                clause = Integer.toString(bystander_a);
            }
            addClause(clause);
            // TODO murder_weapon_access_a
            for (int c = 0; c < m; c++) {
                int has_access_a_c = getHasAccessFluent(a, c);
                int weapon_used_c = getWeaponUsedFluent(c);
                clause = "-" + bystander_a + " " + alibi_a + " -" + motive_a + " -" + has_access_a_c + " -" + weapon_used_c;
                addClause(clause);
            }
        }
    }

    // No clauses needed for weapon_used fluents

    // Generate all has_used_weapon clauses
    void generateHasUsedWeaponClauses() {
        // Assert that exactly one weapon has been used, asserted as always true by generateHasMurderedClauses()
        String clause = "";
        // Assert that at least one weapon has been used
        for (int c = 0; c < m; c++) {
            int weapon_used_c = getWeaponUsedFluent(c);
            if (c > 0) {
                clause = clause + " ";
            }
            clause = clause + weapon_used_c;
        }
        addClause(clause);
        // Assert that at most one weapon is used
        for (int c = 0; c < m; c++) {
            int weapon_used_c = getWeaponUsedFluent(c);
            for (int d = 0; d < m; d++) {
                if (c != d) {
                    int weapon_used_d = getWeaponUsedFluent(d);
                    clause = "-" + weapon_used_c + " -" + weapon_used_d;
                    addClause(clause);
                }
            }
        }
    }

    // Functions used to retrieve specific fluents

    // Calculate which integer representing an alibi fluent corresponds to which fluent alibi(a, b)
    // This is requried for the Dimacs CNF format
    // n.b. Alibi fluents are listed first. Index starts at 1, because 0 is reserved
    // Offset after this = n ^ 2
    int getAlibiFluent(int char_a_index, int char_b_index) {
        int offset = 0 + 1;
        return offset + char_b_index + char_a_index * n;
    }

    // Has_Alibi is listed second
    // Offset after this = (n ^ 2) + n
    int getHasAlibiFluent(int char_a_index) {
        int offset = (n^2) + 1;
        return offset + char_a_index;
    }

    // Has_Access is listed third
    // Offset after this = (n ^ 2) + n + (n * m)
    int getHasAccessFluent(int char_a_index, int weapon_c_index) {
        int offset = ((n ^ 2) + n) + 1;
        return offset + weapon_c_index + char_a_index * m;
    }

    // Has_Motive is listed fourth
    // Offset after this = (n ^ 2) + 2*n + (n * m)
    int getHasMotiveFluent(int char_a_index) {
        int offset = (n ^ 2) + n + (n * m) + 1;
        return offset + char_a_index;
    }

    // Is_Murderer is listed fifth
    // Offset after this = (n^2) + 2*n + (n*m) + 1
    int getHasMurderedFluent() {
        int offset = (n ^ 2) + 2*n + (n * m) + 1;
        return offset + 1;
    }

    // Is_Murderer is listed sixth
    // Offset after this = (n^2) + 3*n + (n*m) + 1
    int getIsMurdererFluent(int char_a_index) {
        int offset = (n^2) + 2*n + (n*m) + 1;
        return offset + char_a_index;
    }

    // Is_Victim is listed seventh
    // Offset after this = (n^2) + 4*n + (n*m) + 1
    int getIsVictimFluent(int char_a_index) {
        int offset = (n^2) + 3*n + (n*m) + 1;
        return offset + char_a_index;
    }

    // Is_Bystander is listed eigth
    // Offset after this = (n^2) + 5*n + (n*m) + 1
    int getIsBystanderFluent(int char_a_index) {
        int offset = (n^2) + 4*n + (n*m) + 1;
        return offset + char_a_index;
    }

    // Has_Used_Weapon is listed ninth
    // Offset after this = (n^2) + 5*n + (n*m) + 2
    int getHasUsedWeaponFluent() {
        int offset = (n^2) + 5*n + (n*m) + 1;
        return offset + 1;
    }

    // Weapon_Used is listed tenth
    // Offset after this = (n^2) + 5*n + (n*m) + 2 + m
    int getWeaponUsedFluent(int weapon_c_index) {
        int offset = (n^2) + 5*n + (n*m) + 1 + 1;
        return offset + weapon_c_index;
    }
}
