public class SOQLPractice {
    public static void query() {
        //List<Account> account = [SELECT Account.Id, Account.Name, (SELECT FirstName, LastName FROM Contacts) FROM Account LIMIT 5];
        //System.debug(account);
    	
        // String name = '%jagat bhari%';
        // List<Account> accounts = [SELECT Name FROM Account WHERE Name LIKE :name];
        // System.debug(accounts);
        
        // List<Contact> contacts = [SELECT LastName, Account.Name FROM Contact LIMIT 1];
        // System.debug(contacts);
        
        List<AggregateResult> opportunities = [SELECT Account.Name, SUM(Amount) FROM Opportunity GROUP BY Account.Name];
        if (!opportunities.isEmpty()) {
            System.debug(opportunities);
        }
    }
}