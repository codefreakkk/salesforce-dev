@isTest
public with sharing class OpportunityTriggerHandlerTest {

    /* 
    test cases for validate amount
    */
    @isTest
    static void validateAmmountTestForNullAmmount() {
        Opportunity opportunity = new Opportunity(
            Name='Test name',
            CloseDate=System.today(),
            StageName='Closed Won'
        );

        opportunity.Amount = null;
        
        // insert opportunity
        insert opportunity;

        try {
            // update opportunity
            update opportunity;
        } catch (Exception e) {
            boolean exceptionThrown = (e.getMessage().contains('Amount cannot be empty')) ? true : false;
            System.assertEquals(true, exceptionThrown, 'Amount is not null');
        }

    }

    @isTest
    static void validateAmmountTestForNegativeAmmount() {
        Opportunity opportunity = new Opportunity(
            Name='Test name',
            CloseDate=System.today(),
            StageName='Closed Won'
        );

        opportunity.Amount = -10;
        
        // insert opportunity
        insert opportunity;

        try {
            // update opportunity
            update opportunity;
        } catch (Exception e) {
            boolean exceptionThrown = (e.getMessage().contains('Amount cannot be negative')) ? true : false;
            System.assertEquals(true, exceptionThrown, 'Amount is not negative');
        }

    }

    @isTest
    static void updateTotalNumberOfOpportunitiesAfterInsert() {
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

    @isTest
    static void updateTotalNumberOfOpportunitiesAfterDelete() {
        Account account = new Account(Name='Test Name');
        insert account;

        Opportunity opportunity1 = new Opportunity(
            Name='Test opp 1',
            CloseDate=Date.Today(),
            StageName='Closed Won',
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
		List<Account> testAccount = [SELECT Id, Total_Opportunities__c, (SELECT Id FROM Opportunities WHERE StageName = 'Closed Won') FROM Account WHERE Id = :account.Id];
        System.assertEquals(1, testAccount[0].Total_Opportunities__c, 'Total_Opportunities__c should match the number of Closed Won opportunities.');
        
        // delete opportunity for trigger
        delete opportunity1;

        testAccount = [SELECT Id, Total_Opportunities__c, (SELECT Id FROM Opportunities WHERE StageName = 'Closed Won') FROM Account WHERE Id = :account.Id];
        Integer expectedOpportunities = testAccount[0].Opportunities.size();
        System.assertEquals(expectedOpportunities, testAccount[0].Total_Opportunities__c, 'Total_Opportunities__c should match the number of Closed Won opportunities.');
    }

    @isTest
    static void updateContactEmailField() {
        Contact contact = new Contact(
            LastName='test',
            email='test@gmail.com'
        );

        insert contact;

        Opportunity opportunity = new Opportunity(
            Name='Test opp',
            CloseDate=Date.Today(),
            StageName='Prospecting',
            ContactId=contact.Id,
            amount=100
        );

        // insert opportunity
        insert opportunity;

        // validate opportunity
        List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE Id = :opportunity.Id];
        System.assertEquals(opportunity.Id, opportunityList[0].Id, 'Validate inserted opportunity');

        opportunityList[0].StageName = 'Closed Won';

        // update opportunity
        update opportunityList;

        // check updated email
        List<Contact> contactList = [SELECT Id, Email FROM Contact WHERE Id = :contact.Id];
        String contactEmail = 'won@opportunity.com';
        System.assertEquals(contactEmail, contactList[0].email, 'Validating email');
    }
}