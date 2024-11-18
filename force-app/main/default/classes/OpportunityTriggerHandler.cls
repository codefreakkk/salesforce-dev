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
}