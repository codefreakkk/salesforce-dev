public class OpportunityBatchPractice implements Database.Batchable<SOBJECT>, Database.Stateful {
    public Integer recordCount = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, LeadSource FROM Opportunity';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> opportunityList) {
        if (!opportunityList.isEmpty()) {
            for (Opportunity opportunity : opportunityList) {
                opportunity.LeadSource = 'Web';
                opportunity.Amount = 10;
            }
            update opportunityList;
            recordCount += opportunityList.size();   
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Total Record Process ' + recordCount);
    }
}

// find close cases and delete it