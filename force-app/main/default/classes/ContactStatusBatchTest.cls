@isTest
public class ContactStatusBatchTest {
	
    @isTest
    public static void successfullBatchExecution() {
     	List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact contact = new Contact();
            // contact.LastActivityDate = System.today() - 365;
        }

        insert contactList;
        
        // execute batch
        ContactStatusBatch batch = new ContactStatusBatch();
        Database.executeBatch(batch, 10);
        
        // validate the test
        List<Contact> updateContactList = [SELECT Id, Status__c FROM Contact WHERE Status__c = 'Inactive'];
        System.assertEquals(updateContactList.size(), 5);
    }
}