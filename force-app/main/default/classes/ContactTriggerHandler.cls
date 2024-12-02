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

    public void checkPrimaryContact(List<Contact> contactList) {
        Map<Id, Contact> mp = new Map<Id, Contact>();

        for (Contact contact : contactList) {
            mp.put(contact.AccountId, contact);
        }

        for (Account account : [SELECT Id, (SELECT Id , AccountId, Primary_Contact__c FROM Contacts) FROM Account WHERE Id IN :mp.keySet()]) {
            System.debug('Current Account ' + account);

            // check if primary contact exist
            for (Contact contact : account.Contacts) {
                if (contact.Primary_Contact__c && mp.get(contact.AccountId).Primary_Contact__c == true) {
                    mp.get(contact.AccountId).addError('Primary contact Exist');
                }
            }
        }
    }

    public void checkPrimaryContactAfterUpdate(Map<Id, Contact> contactMap, Map<Id, Contact> oldContactMap) {
        Map<Id, Contact> contactsWithAccountId = new Map<Id, Contact>();

        for (Contact contact : contactMap.values()) {
            if (contact.Primary_Contact__c != oldContactMap.get(contact.Id).Primary_Contact__c) {
                contactsWithAccountId.put(contact.AccountId, contact);
            }
        }

        for (Account account : [SELECT Id, (SELECT Id , AccountId, Primary_Contact__c FROM Contacts) FROM Account WHERE Id IN :contactsWithAccountId.keySet()]) {
            System.debug('Current Account ' + account);

            // check if primary contact exist
            for (Contact contact : account.Contacts) {
                if (contact.Primary_Contact__c && contactsWithAccountId.get(contact.AccountId).Primary_Contact__c == true) {
                    contactsWithAccountId.get(contact.AccountId).addError('Primary contact Exist');
                }
            }
        }
    }

    public void createAccountBeforeCreatingContact(List<Contact> contactList) {
        
        List<Account> accountList = new List<Account>();

        for (Contact contact : contactList) {
            Account account = new Account(Name=contact.LastName);
            accountList.add(account);
        }

        if (!accountList.isEmpty()) {
            insert accountList;
            System.debug('Account created');

            for (Integer i = 0; i < contactList.size(); i++) {
                contactList[i].AccountId = accountList[i].Id;
            }
        }
    }
}