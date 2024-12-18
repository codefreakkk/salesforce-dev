trigger OpportunityTrigger on Opportunity (after update, before update, after insert, after delete) {
    OpportunityTriggerHandler opportunityTriggerHandler = new OpportunityTriggerHandler();
    
    if (Trigger.isUpdate) {
        
        if (Trigger.isBefore) {
			// validation for ammount using addError() method
			opportunityTriggerHandler.validateAmmount(Trigger.New);

            // update opportunity stage based on close date
            opportunityTriggerHandler.updateOpportunityStage(Trigger.New, Trigger.OldMap);
        }
        
        if (Trigger.isAfter) {
            opportunityTriggerHandler.updateOpportunityDescription(Trigger.New, Trigger.OldMap);

            opportunityTriggerHandler.updateTotalNumberOfOpportunitiesAfterUpdate(Trigger.New, Trigger.OldMap);

            // Update Contact’s Email on Opportunity Stage Change
            opportunityTriggerHandler.updateContactEmailField(Trigger.New, Trigger.OldMap); 

            // create task for opportunity owner when StageName is updated to 'Closed Won'
            opportunityTriggerHandler.autoAssignTaskBasedOnOpportunityStage(Trigger.New, Trigger.OldMap);

            // update total opportunity value on account after insert
            opportunityTriggerHandler.calculateTotalOpportunityValueAfterUpdate(Trigger.New, Trigger.OldMap);
        }
    }

    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            opportunityTriggerHandler.updateTotalNumberOfOpportunities(Trigger.New);

            // update total opportunity value on account after insert
            opportunityTriggerHandler.calculateTotalOpportunityValue(Trigger.New);
        }
    }


    if (Trigger.isDelete) {
        if (Trigger.isAfter) {
            opportunityTriggerHandler.updateTotalNumberOfOpportunities(Trigger.Old);

            // update total opportunity value on account after insert
            opportunityTriggerHandler.calculateTotalOpportunityValue(Trigger.Old);
        }
    }
}