@isTest
public class ContactTriggerHandlerTest {

    @isTest
    private static void checkPrimaryContactBeforeInsert() {
        List<Account> accountList = new List<Account>();

        for (Integer i = 0; i < 5; i++) {
            Account account = new Account(Name='Test'+i);
            accountList.add(account);
        }
        
        if (!accountList.isEmpty()) {
            insert accountList;
        }

        // create contact related to account as primary
        List<Contact> contactList = new List<Contact>();
        for (Account account : [SELECT Id, Name FROM Account]) {
            Contact contact = new Contact(LastName=account.Name);
            contact.AccountId = account.Id;
            contact.Primary_Contact__c = true;
            contactList.add(contact);
        }

        if (!contactList.isEmpty()) {
            insert contactList;
        }

        contactList = new List<Contact>();
        for (Account account : [SELECT Id, Name FROM Account]) {
            Contact contact = new Contact(LastName=account.Name);
            contact.AccountId = account.Id;
            contact.Primary_Contact__c = true;
            contactList.add(contact);
        }

        try {
            if (!contactList.isEmpty()) {
                insert contactList;
            }
        } catch (Exception e) {
            boolean exceptionThrown = (e.getMessage().contains('Primary contact Exist')) ? true : false;
            System.assertEquals(true, exceptionThrown, 'Some error occured while inserting contact');
        }
    }
}