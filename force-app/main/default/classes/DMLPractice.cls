public class DMLPractice {
    
    public static void undeleteDML() {
        List<Account> accountsList = [SELECT Name FROM Account WHERE Name LIKE 'Update%' ALL ROWS];
        System.debug('Accounts' + accountsList);
        if (!accountsList.isEmpty()) {
            undelete accountsList;
            System.debug('Records undeleted');
        }
    }
    
    public static void deleteDML() {
        List<Account> accountsList = [SELECT Name FROM Account WHERE Name LIKE 'Update%'];
        if (!accountsList.isEmpty()) {
            delete accountsList;
            System.debug('Accounts Deleted');
        }
    } 
    
    public static void upsertDML() {
        List<Account> accountsList = [SELECT Name FROM Account WHERE Name LIKE 'Insert%'];

        if (accountsList.isEmpty()) {
            System.debug('Accounts List empty');
            return;
        }
        
        // update accounts in the list
        for (Account account : accountsList) {
            account.Name = 'Update';
        }
        
        // insert new account in the list
        for (Integer i = 0; i < 5; i++) {
            Account account = new Account();
            account.Name = 'New record for upsert';
            accountsList.add(account);
        }
		upsert accountsList;
    }
    
    public static void insertDML() {
        List<Account> accountsList = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account account = new Account();
            account.Name = 'Insert' + i;
            accountsList.add(account);
        }
        if (!accountsList.isEmpty()) {
			insert accountsList; 
            System.debug('Inserted');
        }
    }
}