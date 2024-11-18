public class AccountHandler {
    public Id addAccount(String accountName, String rating, String active) {
        Account account = new Account();
        account.name = accountName;
        account.Rating = rating;
        account.Active__c = active;
        insert account;
		System.debug('Account Inserted');
        
        return account.Id;
    }
    
    public void addContact(String accountName, String rating, String active, String firstName, String lastName) {
		Id accountId;
        accountId = addAccount(accountName, rating, active);
        Contact contact = new Contact(FirstName=firstName, LastName=lastName);
        contact.accountId = accountId;
        insert contact;
    }
}