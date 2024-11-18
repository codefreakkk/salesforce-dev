public class DatbaseMethodPractice {
    public static void insertDataToAccount() {
        List<Account> accountList = new List<Account>();
        
        for (Integer i = 0; i < 5; i++) {
            Account account = new Account();
        	account.Name = 'Vijay' + i;
        	account.Rating = 'Hot';
            accountList.add(account);
        }
        
         Account account = new Account();
         account.Rating = 'Hot';
         accountList.add(account);
        
        Database.SaveResult[] results = null;
        if (!accountList.isEmpty()) {
			results = Database.insert(accountList, false);   
        }
        for (Database.SaveResult result : results) {
            if (result.isSuccess()) {
                System.debug('Account Inserted with Id : ' + result.getId());
            } else {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error Message : ' + error.getMessage());
					System.debug('Error Field : ' + error.getFields());
                }
            } 
        }
        
    }
}