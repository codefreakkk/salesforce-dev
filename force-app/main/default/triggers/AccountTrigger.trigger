trigger AccountTrigger on Account (before insert, after insert) {
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
}