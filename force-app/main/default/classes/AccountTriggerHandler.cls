public with sharing class AccountTriggerHandler {
    public void updateAccountDescription(List<Account> accountList) {
        for (Account accounts : accountList) {
            accounts.Description = 'Account Description updated via trigger';
        }
    }

    public void updateRatingToHot(List<Account> accountList) {
        for (Account accounts : accountList) {
            if (accounts.Industry != NULL && accounts.Industry.equals('Media')) {
                accounts.Rating = 'Hot';
                System.debug('Updated Rating to Hot');
            }
        }
    }

    public void createOpportunity(List<Account> accountList) {
        List<Opportunity> opportunityList = new List<Opportunity>();

        for (Account accounts : accountList) {
            Opportunity opportunity = new Opportunity();

            opportunity.Name = 'My Opportunity';
            opportunity.CloseDate = System.today();
            opportunity.StageName = 'Prospecting';
            opportunity.AccountId = accounts.Id;
            /* accounts.AnnualRevenue = 10000 // This is not allowed as account is read only
            As we know the records that fire after the trigger are read-only */
            opportunityList.add(opportunity);
        }
        
        // create opportunity
        if (!opportunityList.isEmpty()) {
            insert opportunityList;
            System.debug('Opportunity created');
        }
    }

    public void createTaskForUser(List<Account> accountList) {
        List<Task> taskList = new List<Task>();

        for (Account accounts : accountList) {
            Task task = new Task();
            task.subject = 'Follow up';
            task.ActivityDate = System.today() + 2;
            task.WhatId = accounts.Id;
            task.OwnerId = UserInfo.getUserId();
            task.Status = 'Not Started';

            taskList.add(task);
        }

        if (!taskList.isEmpty()) {
            insert taskList;
            System.debug('Task created');
        }
    }

    public void updateAccountDescriptionAfterUpdate(List<Account> accountList) {
        List<Account> accountsToBeUpdated = new List<Account>();

        for (Account acc : accountList) {
            Account account = new Account();
            account.Description = 'Account description updated via trigger';
            account.Id = acc.Id;
            
            accountsToBeUpdated.add(account);
        }

        if (!accountsToBeUpdated.isEmpty()) {
            update accountsToBeUpdated;
            System.debug('Account Description Updated after update trigger');
        }
    }
    
    public void preventDeletionOfAccountWithActiveOpportunities(List<Account> accountList) {
        System.debug('Prevent delete function called');
        
        Set<Id> accountIds = new Set<Id>();
        for (Account account : accountList) {
            accountIds.add(account.Id);
        }

        System.debug('Account Ids : ' + accountIds);

        List<String> stages = new List<String>{'Perception Analysis', 'Proposal/Price Quote'};
        Set<Id> accountIdWithRelatedOpportunity = new Set<Id>();
        for (Opportunity opportunity : [SELECT AccountId FROM Opportunity WHERE StageName IN :stages AND AccountId IN :accountIds]) {
            accountIdWithRelatedOpportunity.add(opportunity.AccountId);
        }

        System.debug('Account Ids with related opportunity : ' + accountIdWithRelatedOpportunity);

        for (Account account : accountList) {
            if (accountIdWithRelatedOpportunity.contains(account.Id)) {
                account.addError('Account cannot be deleted as it has related opportunity with Perception Analysis or Proposal/Price Quote ');
                System.debug('Inside loop');
            }
        }
    }   

    public void preventDuplicateAccount(List<Account> accountList) {
        // store all account name
        List<String> accountNames = new List<String>();
        for (Account account : accountList) {
            accountNames.add(account.Name);
        }

        // get all matching account names
        List<String> accountNamesFromObject = new List<String>();
        for (Account account : [SELECT Id, Name FROM Account WHERE Name IN :accountNames]) {
            accountNamesFromObject.add(account.Name);
        }

        // check if account name already exist's
        for (Account account : accountList) {
            if (accountNamesFromObject.contains(account.Name)) {
                account.addError('Account with ' + account.Name + ' already exists');
            }
        }
    } 

    public void preventDuplicateAccountWithinSameIndustry(List<Account> accountList) {
        // store all account name
        List<String> accountNames = new List<String>();
        for (Account account : accountList) {
            accountNames.add(account.Name);
        }

        System.debug('Account Names : ' + accountNames);

        Map<String, Account> accountsFromObject = new Map<String, Account>();
        for (Account account : [SELECT Id, Name, Industry FROM Account WHERE Name IN :accountNames]) {
            accountsFromObject.put(account.Name, account);
            System.debug('Added to map');
        }

        System.debug('Accounts From Object ' + accountsFromObject);

        for (Account account : accountList) {
            if (accountsFromObject.containsKey(account.Name) && accountsFromObject.get(account.Name).Industry == account.Industry) {
                account.addError('Account Name : ' + account.Name + ' exist with ' + account.Industry);
            }
        }
    }

    public void updateRelatedContacts(List<Account> accountList, Map<Id, Account> accountOldMap) {
        Map<Id, String> accountWithPhoneList = new Map<Id, String>();

        for (Account account : accountList) {
            String oldAccountPhone = accountOldMap.get(account.Id).Phone;
            if (account.Phone != oldAccountPhone) {
                accountWithPhoneList.put(account.Id, account.Phone);
            }
        }

        System.debug('Accounts with phone list '+ accountWithPhoneList);

        List<Contact> contactList = new List<Contact>();
        for (Contact contact : [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN :accountWithPhoneList.keySet()]) {
            contact.Phone = accountWithPhoneList.get(contact.AccountId);
            contactList.add(contact);
        }

        System.debug('Contacts ' + contactList);

        if (!contactList.isEmpty()) {
            update contactList;
            System.debug('Contact List updated');
        }
    }

    public void createContactsAccordingToTotalContactField(List<Account> accountList) {
        System.debug('createContactsAccordingToTotalContactField');
        List<Contact> contactList = new List<Contact>();
        for (Account account : accountList) {
            Integer totalContacts = (Integer) account.Total_Number_of_Contacts__c;

            // create Contacts
            for (Integer i = 0; i < totalContacts; i++) {
                Contact contact = new Contact(LastName=account.Name);
                contact.AccountId = account.Id;
                contactList.add(contact);
            }
        }

        System.debug('Contact list ' + contactList);

        if (!contactList.isEmpty()) {
            insert contactList;
            System.debug('Contact inserted');
        }
    }
}