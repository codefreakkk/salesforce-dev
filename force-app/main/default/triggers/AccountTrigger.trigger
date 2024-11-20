trigger AccountTrigger on Account (before insert, after insert, after update, before delete) {
    AccountTriggerHandler accountTriggerHandler = new AccountTriggerHandler();

    if (Trigger.isInsert) {

        if (Trigger.isBefore) {
            accountTriggerHandler.updateAccountDescription(Trigger.New);
            
            // If account Industry is not null and having value as 'Media' then populate rating as Hot
            accountTriggerHandler.updateRatingToHot(Trigger.New);
        }

        if (Trigger.isAfter) {
            // when account is created create a related opportunity
            accountTriggerHandler.createOpportunity(Trigger.New);

            // when account is created with type as prospect assign task to logged in user
            accountTriggerHandler.createTaskForUser(Trigger.New);

        }
    }

    if (Trigger.isUpdate) {

        if (Trigger.isAfter) {

            // When account is created update description | (Recursion demo)
            if (!TriggerHelper.accountDescriptionUpdate) {
                TriggerHelper.accountDescriptionUpdate = true;
                accountTriggerHandler.updateAccountDescriptionAfterUpdate(Trigger.New);   
            }
        }
    }

    if(Trigger.isDelete) {
        
        if (Trigger.isBefore) {
            accountTriggerHandler.preventDeletionOfAccountWithActiveOpportunities(Trigger.Old);
        }
    }
}