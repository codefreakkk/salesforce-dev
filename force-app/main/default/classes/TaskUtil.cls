public class TaskUtil {
    public String getTaskPriority(String leadState) {
        if (leadState == null || leadState.length() > 2) {
            return null;
        }
        if (leadState.equals('CA')) {
            return 'High';
        } else {
            return 'Normal';
        }
    }
}