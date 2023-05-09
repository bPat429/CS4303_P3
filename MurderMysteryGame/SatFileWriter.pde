import java.io.File;
import java.lang.Math;

// Class used to handle writing the SAT file
class SatFileWriter {
    private ArrayList<String> sat_clauses;
    private CharacterCast cast;
    private WeaponObjects weapons;
    private Random rand;
    private String satFilePath;
    private PrintWriter sat_file;
    private int n;
    private int m;
    private int victim_index;

    SatFileWriter(CharacterCast cast, WeaponObjects weapons, Random rand) {
        this.cast = cast;
        this.weapons = weapons;
        // Find n and m
        n = cast.len();
        m = weapons.len();
        // Randomly select a murderer from the cast
        // Do this outside of SAT for convenience and to avoid higher probabilities for murderers and victims which
        // are more likely (TODO mention this in the report)
        int murderer_index = rand.nextInt(cast.len());
        cast.getCharacter(murderer_index).setRole(1);
        boolean victim_chosen = false;
        victim_index = -1;
        while (!victim_chosen) {
            // Randomly select a victim from the cast, avoid choosing the murderer
            victim_index = rand.nextInt(cast.len());
            victim_chosen = (victim_index != murderer_index);
        }
        // Create three characters who must be 'red herrings', where they have 2/3 of motive/murder weapon access/no alibi
        // Do this because SAT will give preference to simpler problems where fewer characters are suspicious, and therefore there
        // are more similar plans
        boolean red_herring = false;
        int red_herring_a = -1;
        while (!red_herring) {
            // Randomly select a victim from the cast, avoid choosing the murderer
            red_herring_a = rand.nextInt(cast.len());
            red_herring = (red_herring_a != murderer_index && red_herring_a != victim_index);
        }
        red_herring = false;
        int red_herring_b = -1;
        while (!red_herring) {
            // Randomly select a victim from the cast, avoid choosing the murderer
            red_herring_b = rand.nextInt(cast.len());
            red_herring = (red_herring_b != murderer_index && red_herring_b != victim_index && red_herring_b != red_herring_a);
        }
        red_herring = false;
        int red_herring_c = -1;
        while (!red_herring) {
            // Randomly select a victim from the cast, avoid choosing the murderer
            red_herring_c = rand.nextInt(cast.len());
            red_herring = (red_herring_c != murderer_index && red_herring_c != victim_index && red_herring_c != red_herring_a && red_herring_c != red_herring_b);
        }

        cast.getCharacter(victim_index).setRole(2);

        int used_weapon_index = rand.nextInt(weapons.len());

        satFilePath = sketchPath() + "/data/sat/SatProblem.txt";
        clearSATFile();
        sat_file = createWriter("./data/sat/SatProblem.txt");
        
        writeComments(sat_file);
        // Use one line for each fluent
        int fluents_needed = countFluentsNeeded();
        sat_clauses = new ArrayList<String>();
        generateClauses(murderer_index, victim_index, red_herring_a, red_herring_b, red_herring_c, used_weapon_index);
        writeSatFile(sat_file);

        sat_file.flush();
        sat_file.close();
    }

    int getVictimIndex() {
        return this.victim_index;
    }

    void writeComments(PrintWriter output_file) {
        output_file.println("c The Problem describing the plan needed for the murder mystery story");
        sat_file.flush();
    }

    void writeSatFile(PrintWriter output_file) {
        output_file.println("p cnf " + countFluentsNeeded() + " " + sat_clauses.size());
        for (int i = 0; i < sat_clauses.size() - 1; i++) {
            output_file.println(sat_clauses.get(i));
        }
        output_file.print(sat_clauses.get(sat_clauses.size() - 1));
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
        int character_fluent_count = (int) Math.pow(n, 2) + n + n*m + n + 1 + n + n + n;

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

    void generateClauses(int murderer_index, int victim_index, int red_herring_a, int red_herring_b, int red_herring_c, int used_weapon_index) {
        generateAlibiClauses();
        generateHasAlibiClauses();
        generateHasAccessClauses();
        generateHasMurderedClauses(murderer_index, victim_index);
        generateIsMurdererClauses(murderer_index);
        generateIsVictimClauses(victim_index);
        generateIsBystanderClauses(murderer_index, victim_index);
        generateRedHerringClauses(red_herring_a, red_herring_b, red_herring_c);
        generateWeaponUsedClauses(murderer_index, used_weapon_index);
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
        String clause;
        // If Character a has an alibi then they have an alibi with at least one other person
        for (int a = 0; a < n; a++) {
            int has_alibi_a = getHasAlibiFluent(a);
            clause = "-" + has_alibi_a;
            for (int b = 0; b < n; b++) {
                if (a != b) {
                    int alibi = getAlibiFluent(a, b);
                    clause = clause + " " + alibi;
                }
            }
            addClause(clause);
        }
    }

    // Generate clauses for 'has_access'.
    void generateHasAccessClauses() {
        // Ensure that every character has access to at least one weapon to make the game more interesting
        String clause = "";
        // If Character a has an alibi then they have an alibi with at least one other person
        for (int a = 0; a < n; a++) {
            for (int c = 0; c < m; c++) {
                clause = (c == 0) ? Integer.toString(getHasAccessFluent(a, c)) : " " + getHasAccessFluent(a, c);
            }
            addClause(clause);
        }
    }


    // No clauses required for 'has_motive'.

    // Generate all has_murdered clauses
    void generateHasMurderedClauses(int murderer_index, int victim_index) {
        // If character a murders b then a and b both don't have an alibi, a has a motive and the weapon c has been used
        // We already know the identity of the murderer and victim, so only generate the clauses for them.
        int murdered_a_b = getHasMurderedFluent();
        int motive_a = getHasMotiveFluent(murderer_index);
        int has_alibi_a = getHasAlibiFluent(murderer_index);
        int has_alibi_b = getHasAlibiFluent(victim_index);
        int has_used_weapon = getHasUsedWeaponFluent();
        String clause = "-" + murdered_a_b + " -" + has_alibi_a;
        addClause(clause);
        clause = "-" + murdered_a_b + " " + motive_a;
        addClause(clause);
        clause = "-" + murdered_a_b + " -" + has_alibi_b;
        addClause(clause);
        clause = "-" + murdered_a_b + " " + has_used_weapon;
        addClause(clause);
        // Manually assert that this is always true
        clause = Integer.toString(murdered_a_b);
        addClause(clause);
    }

    // Generate all is_murderer clauses
    void generateIsMurdererClauses(int murderer_index) {
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
    void generateIsVictimClauses(int victim_index) {
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
    void generateIsBystanderClauses(int murderer_index, int victim_index) {
        // Set which characters are bystanders
        // Assert that if character a is a bystander then they do not have all of: no alibi, access to the murder weapon, motive
        String clause;
        for (int a = 0; a < n; a++) {
            int bystander_a = getIsBystanderFluent(a);
            int alibi_a = getHasAlibiFluent(a);
            int motive_a = getHasMotiveFluent(a);
            if (a == victim_index || a == murderer_index) {
                clause = "-" + bystander_a;
                addClause(clause);
            } else {
                clause = Integer.toString(bystander_a);
                addClause(clause);
                for (int c = 0; c < m; c++) {
                    int has_access_a_c = getHasAccessFluent(a, c);
                    int weapon_used_c = getWeaponUsedFluent(c);
                    clause = "-" + bystander_a + " " + alibi_a + " -" + motive_a + " -" + has_access_a_c + " -" + weapon_used_c;
                    addClause(clause);
                }
            }
        }
    }

    // Generate all clauses for the red herrings
    // Each should share two of the three factors with the murderer
    void generateRedHerringClauses(int red_herring_a, int red_herring_b, int red_herring_c) {
        String clause;
        // Red herring a has no alibi, and a motive
        int alibi_a = getHasAlibiFluent(red_herring_a);
        int motive_a = getHasMotiveFluent(red_herring_a);
        clause = "-" + alibi_a;
        addClause(clause);
        clause = Integer.toString(motive_a);
        addClause(clause);
        // Red herring b has no alibi, and weapon access
        int alibi_b = getHasAlibiFluent(red_herring_b);
        clause = "-" + alibi_b;
        addClause(clause);
        for (int c = 0; c < m; c++) {
            int has_access_b_c = getHasAccessFluent(red_herring_b, c);
            int weapon_used_c = getWeaponUsedFluent(c);
            clause = "-" + weapon_used_c + " " + has_access_b_c;
            addClause(clause);
        }
        // Red herring c has a motive, and weapon access
        int motive_c = getHasMotiveFluent(red_herring_c);
        clause = Integer.toString(motive_c);
        addClause(clause);
        for (int c = 0; c < m; c++) {
            int has_access_c_d = getHasAccessFluent(red_herring_c, c);
            int weapon_used_c = getWeaponUsedFluent(c);
            clause = "-" + weapon_used_c + " " + has_access_c_d;
            addClause(clause);
        }
        // Also ensure that every character has at least one of: no alibi, motive, murder weapon access to make things more interesting
        for (int a = 0; a < n; a++) {
            alibi_a = getHasAlibiFluent(a);
            motive_a = getHasMotiveFluent(a);     
            for (int c = 0; c < m; c++) {
                int has_access_a_c = getHasAccessFluent(a, c);
                int weapon_used_c = getWeaponUsedFluent(c);
                clause = "-" + weapon_used_c + " " + has_access_a_c + " -" + alibi_a + " " + motive_a;
                addClause(clause);
            }
        }
    }

    // Generate weapon_used clauses
    void generateWeaponUsedClauses(int murderer_index, int used_weapon_index) {
        // Assert that WeaponUsed means the murderer has access
        String clause = "";
        for (int c = 0; c < m; c++) {
            int has_access_a_c = getHasAccessFluent(murderer_index, c);
            int weapon_used_c = getWeaponUsedFluent(c);
            clause = "-" + weapon_used_c + " " + has_access_a_c;
            addClause(clause);
        }
        // Assert that the pre-selected murder weapon is used
        int weapon_used_i = getWeaponUsedFluent(used_weapon_index);
        clause = Integer.toString(weapon_used_i);
        System.out.println(used_weapon_index);
        System.out.println(weapon_used_i);
        addClause(clause);
    }

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
            for (int d = c; d < m; d++) {
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
        int offset = (int) Math.pow(n, 2) + 1;
        return offset + char_a_index;
    }

    // Has_Access is listed third
    // Offset after this = (n ^ 2) + n + (n * m)
    int getHasAccessFluent(int char_a_index, int weapon_c_index) {
        int offset = ((int) Math.pow(n, 2) + n) + 1;
        return offset + weapon_c_index + char_a_index * m;
    }

    // Has_Motive is listed fourth
    // Offset after this = (n ^ 2) + 2*n + (n * m)
    int getHasMotiveFluent(int char_a_index) {
        int offset = (int) Math.pow(n, 2) + n + (n * m) + 1;
        return offset + char_a_index;
    }

    // Is_Murderer is listed fifth
    // Offset after this = (n^2) + 2*n + (n*m) + 1
    int getHasMurderedFluent() {
        int offset = (int) Math.pow(n, 2) + 2*n + (n * m) + 1;
        return offset;
    }

    // Is_Murderer is listed sixth
    // Offset after this = (n^2) + 3*n + (n*m) + 1
    int getIsMurdererFluent(int char_a_index) {
        int offset = (int) Math.pow(n, 2) + 2*n + (n * m) + 1 + 1;
        return offset + char_a_index;
    }

    // Is_Victim is listed seventh
    // Offset after this = (n^2) + 4*n + (n*m) + 1
    int getIsVictimFluent(int char_a_index) {
        int offset = (int) Math.pow(n, 2) + 3*n + (n*m) + 2;
        return offset + char_a_index;
    }

    // Is_Bystander is listed eigth
    // Offset after this = (n^2) + 5*n + (n*m) + 1
    int getIsBystanderFluent(int char_a_index) {
        int offset = (int) Math.pow(n, 2) + 4*n + (n*m) + 2;
        return offset + char_a_index;
    }

    // Has_Used_Weapon is listed ninth
    // Offset after this = (n^2) + 5*n + (n*m) + 2
    int getHasUsedWeaponFluent() {
        int offset = (int) Math.pow(n, 2) + 5*n + (n*m) + 2;
        return offset;
    }

    // Weapon_Used is listed tenth
    // Offset after this = (n^2) + 5*n + (n*m) + 2 + m
    int getWeaponUsedFluent(int weapon_c_index) {
        int offset = (int) Math.pow(n, 2) + 5*n + (n*m) + 3;
        return offset + weapon_c_index;
    }
}
