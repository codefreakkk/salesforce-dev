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

    public void sendEmailAfterContactInsert(List<Contact> contactList) {

        List<String> contactIds = new List<String>();
        for (Contact contact : contactList) {
            contactIds.add(contact.Id);
        }
        System.debug('Contact Id : ' + contactIds);

        if (!contactIds.isEmpty()) {
            List<Messaging.MassEmailMessage> emails = new List<Messaging.MassEmailMessage>();
            List<EmailTemplate> emailTemplate = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Contact_Created_Email_Template'];

            Messaging.MassEmailMessage massEmail = new Messaging.MassEmailMessage();
            massEmail.setTargetObjectIds(contactIds);
            massEmail.setTemplateId(emailTemplate[0].Id);
            emails.add(massEmail);

            try {
                // Messaging.sendEmail(emails); commented temporarly 
                System.debug('Mass Email Sent');
            } catch (Exception e) {
                System.debug(e.getMessage());
            }
        }
    }
}