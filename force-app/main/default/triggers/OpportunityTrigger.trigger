trigger OpportunityTrigger on Opportunity (after update, before update) {
    OpportunityTriggerHandler opportunityTriggerHandler = new OpportunityTriggerHandler();
    
    if (Trigger.isUpdate) {
        
        if (Trigger.isBefore) {
			// validation for ammount using addError() method
			opportunityTriggerHandler.validateAmmount(Trigger.New);
        }
        
        if (Trigger.isAfter) {
            opportunityTriggerHandler.updateOpportunityDescription(Trigger.New, Trigger.OldMap);
        }
    }
}