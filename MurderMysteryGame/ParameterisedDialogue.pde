// Parameterised dialogue with the template: string_1 + Suspect + string_2 + Victim + string_3
// Don't forget to add spacing!
class ParameterisedDialogue {
    String string_1;
    String string_2;   
    String string_3;   
    int pattern;
    ParameterisedDialogue(String string_1, String string_2, String string_3, int pattern) {
        this.string_1 = string_1;
        this.string_2 = string_2;
        this.string_3 = string_3;
        this.pattern = pattern;
    }

    ParameterisedDialogue(String string_1) {
        this.string_1 = string_1;
        this.pattern = 5;
    }

    public String getDialogue(String suspect, String victim) {
        switch(pattern) {
            case 0:
                return string_1 + suspect + string_2 + victim + string_3;
            case 1:
                return string_1 + victim + string_2 + suspect + string_3;
            case 2:
                return string_1 + suspect + string_2;
            case 3:
                return suspect + string_1 + suspect + string_2 + victim + string_3;
            case 4:
                return victim + string_1 + suspect + string_2 + victim + string_3;
            case 5:
                return string_1;
            default:
                return string_1 + suspect + string_2 + victim + string_3;
        }
    }
}