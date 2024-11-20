@isTest
public with sharing class OpportunityTriggerHandlerTest {

    @isTest
    static void updateTotalNumberOfOpportunitiesAfterUpdate() {
        Account account = new Account(Name='Test Name');
        insert account;

        Opportunity opportunity1 = new Opportunity(
            Name='Test opp 1',
            CloseDate=Date.Today(),
            StageName='Prospecting',
            AccountId=account.Id,
            amount=100
        );

        Opportunity opportunity2 = new Opportunity(
            Name='Test opp 2',
            CloseDate=Date.Today(),
            StageName='Prospecting',
            AccountId = account.Id,
            amount=0
        );

        insert new List<Opportunity>{opportunity1, opportunity2};

        // check intial state
        List<Account> initiaAccount = [SELECT Id, Total_Opportunities__c FROM Account WHERE Id = :account.Id];
        System.assertEquals(0, initiaAccount[0].Total_Opportunities__c, 'Initial');

        // update opportunity 
        opportunity1.StageName = 'Closed Won';
        opportunity2.StageName = 'Closed Lost';

        update new List<Opportunity>{opportunity1, opportunity2};

        List<Account> testAccount = [SELECT Id, Total_Opportunities__c, (SELECT Id FROM Opportunities WHERE StageName = 'Closed Won') FROM Account WHERE Id = :account.Id];
        Integer expectedOpportunities = testAccount[0].Opportunities.size();
        System.assertEquals(expectedOpportunities, testAccount[0].Total_Opportunities__c, 'Total_Opportunities__c should match the number of Closed Won opportunities.');
    }

}