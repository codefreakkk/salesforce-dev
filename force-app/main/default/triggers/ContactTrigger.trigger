trigger ContactTrigger on Contact (after delete, after insert) {
    ContactTriggerHandler contactTriggerHandler = new ContactTriggerHandler();
    
    if (Trigger.isDelete) {
        if (Trigger.isAfter) {
            contactTriggerHandler.updateContactCount(Trigger.Old);
        }
    }

    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            contactTriggerHandler.sendEmailAfterContactInsert(Trigger.New);
        }
    }
}