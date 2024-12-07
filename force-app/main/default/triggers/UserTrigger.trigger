trigger UserTrigger on User (before update) {
    UserTriggerHandler userTriggerHandler = new UserTriggerHandler();

    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            userTriggerHandler.preventDeactivationOfUserForActiveCases(Trigger.NewMap, Trigger.OldMap);
        }
    }
}