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
            /* accounts.AnnualRevenue = 10000 // This is not allowes as account is read only
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
}