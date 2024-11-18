public class ContactTriggerHandler {
    public void updateContactCount(List<Contact> contactList) {
        List<Account> accountList = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        
        for (Contact contact : contactList) {
        	accountIds.add(contact.AccountId);
        }
        
        for (Account account : [SELECT Id, (SELECT Id From Contacts) FROM Account WHERE Id IN :accountIds]) {
            account.Total_Contact_Count__c = account.Contacts.size();
            accountList.add(account);
        }
        
        if (!accountList.isEmpty()) {
            update accountList;
            System.debug('Account total contact count updated');
        }
    }
}