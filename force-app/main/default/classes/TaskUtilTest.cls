@isTest
public class TaskUtilTest {
    
    @isTest
    static void taskPriority() {
        TaskUtil taskUtil = new TaskUtil();
        String priority = taskUtil.getTaskPriority('Prospecting');
        System.assertEquals(null, priority);
    }
}