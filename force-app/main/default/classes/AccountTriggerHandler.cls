public with sharing class AccountTriggerHandler {
    public void updateAccountDescription(List<Account> accountList) {
        for (Account accounts : accountList) {
            accounts.Description = 'Account Description updated via trigger';
        }
    }

    public void updateRatingToHot(List<Account> accountList, Map<Id, Account> oldAccountMap) {
        System.debug('Update Rating to Hot method called');
        
        for (Account accounts : accountList) {
            if (oldAccountMap == null && accounts.Industry != NULL && accounts.Industry.equals('Media')) {
                accounts.Rating = 'Hot';
                System.debug('Before Insert : Updated Rating to Hot');
            }
            if (accounts.Industry != oldAccountMap.get(accounts.Id).Industry && accounts.Industry.equals('Media')) {
                accounts.Rating = 'Hot';
                System.debug('Before Update : Updated Rating to Hot');
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
            /* accounts.AnnualRevenue = 10000 // This is not allowes as account is read only
            As we know the records that fire after the trigger are read-only */
            opportunityList.add(opportunity);
        }
        
        // create opportunity
        try {
            if (!opportunityList.isEmpty()) {
                insert opportunityList;
                System.debug('Opportunity created');
            }
        } catch (Exception e) {
            System.debug('Some error occured ' + e.getMessage());
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

        try {
            if (!taskList.isEmpty()) {
                insert taskList;
                System.debug('Task created');
            }
        } catch (Exception e) {
            System.debug('Some error occured ' + e.getMessage());
        }
    }
}