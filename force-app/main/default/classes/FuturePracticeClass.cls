public class FuturePracticeClass {
    
    @future
    public static void futureDemo() {
        System.debug('Future method called');
        for (Integer i = 0; i <= 10000; i++) {}
        System.debug('Future method calling finished');
    }
}