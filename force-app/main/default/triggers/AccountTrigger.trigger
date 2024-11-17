trigger AccountTrigger on Account (before insert) {
    AccountTriggerHandler accountTriggerHandler = new AccountTriggerHandler();
    
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            accountTriggerHandler.updateAccountDescription(Trigger.New);
        }
    }
}