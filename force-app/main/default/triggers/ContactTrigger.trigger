trigger ContactTrigger on Contact (after delete) {
    ContactTriggerHandler contactTriggerHandler = new ContactTriggerHandler();
    
    if (Trigger.isDelete) {
        if (Trigger.isAfter) {
            contactTriggerHandler.updateContactCount(Trigger.Old);
        }
    }
}