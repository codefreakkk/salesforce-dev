public class ContactStatusBatch implements Database.Batchable<SOBJECT>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date lastYear = System.today() - 365;
        String query = 'SELECT Id, Status FROM Contact Status__c FROM Contact Where LastActivityDate <= :lastYear';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contactList) {
        for (Contact contact : contactList) {
            contact.Status__c = 'Inactive';
        }
        update contactList;
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Updated the contacts');
    }
}