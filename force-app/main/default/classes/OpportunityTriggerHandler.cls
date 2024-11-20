public class OpportunityTriggerHandler {
    
    public void validateAmmount(List<Opportunity> opportunityList) {
        for (Opportunity opportunity : opportunityList) {
            if (opportunity.Amount == null) {
                opportunity.Amount.addError('Amount cannot be empty');
            } else if (opportunity.Amount < 0) {
                opportunity.Amount.addError('Amount cannot be negative ');
            }
        }
    }

    public void updateOpportunityDescription(List<Opportunity> opportunityList, Map<Id, Opportunity> oldOpportunityMap) {
        List<Opportunity> opportunitiesToBeUpdated = new List<Opportunity>();
        
        for (Opportunity opportunity : opportunityList) {
            if (opportunity.StageName != oldOpportunityMap.get(opportunity.Id).StageName) {
                Opportunity o = new Opportunity();
                o.Id = opportunity.Id;
                
                if (opportunity.StageName == 'Closed Won') {
                    o.Description = 'Opportunity Updated to Closed Won';
                }
                else if (opportunity.StageName == 'Closed Lost') {
                    o.Description = 'Opportunity Updated to Closed Lost';
                }
				opportunitiesToBeUpdated.add(o);            
            }
        }
        if (!opportunitiesToBeUpdated.isEmpty()) {
            update opportunitiesToBeUpdated;
        }
    }

    public void updateTotalNumberOfOpportunities(List<Opportunity> opportunityList) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opportunity : opportunityList) {
            accountIds.add(opportunity.AccountId);
        }

        List<Account> accountList = new List<Account>();
        for (Account account : [SELECT Id, (SELECT Id FROM Opportunities WHERE StageName = 'Closed Won') FROM Account WHERE Id IN :accountIds]) {
            Account currentAccount = new Account();
            currentAccount.Id = account.Id;
            currentAccount.Total_Opportunities__c = account.Opportunities.size();

            accountList.add(currentAccount);
        }

        try {
            update accountList;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }

    public void updateContactEmailField(List<Opportunity> opportunityList, Map<Id, Opportunity> oldOpportunityMap) {
        Set<Id> contactIds = new Set<Id>();

        
        for (Opportunity opportunity : opportunityList) {
            if (opportunity.StageName != oldOpportunityMap.get(opportunity.Id).StageName && opportunity.StageName == 'Closed Won') {
                contactIds.add(opportunity.ContactId);
            }
        }
        System.debug('Contact Ids : ' + contactIds);

        List<Contact> contactList = new List<Contact>();
        for (Contact contact : [SELECT Id, Email FROM Contact WHERE Id IN :contactIds]) {
            contact.email = 'won@opportunity.com';
            contactList.add(contact);
        }
        System.debug('Contacts : ' + contactList);

        try {
            if (!contactList.isEmpty()) {
                update contactList;
                System.debug('Contacts updated');
            }
        } catch (Exception e) {
            System.debug('Exception : ' + e.getMessage());
        }
    }
}