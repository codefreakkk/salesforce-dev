public class SchedulePractice implements Schedulable {
    public void execute(SchedulableContext sc) {
        System.debug('Daily Job running');
    }
}