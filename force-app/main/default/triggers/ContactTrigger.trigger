trigger ContactTrigger on Contact (after delete, after insert, before insert, before update) {
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

        if (Trigger.isBefore) {
            contactTriggerHandler.checkPrimaryContact(Trigger.New);

            // create account before creating contact
            contactTriggerHandler.createAccountBeforeCreatingContact(Trigger.New);
        }

    }

    
    if (Trigger.IsUpdate) {
        if (Trigger.isBefore) {
            contactTriggerHandler.checkPrimaryContactAfterUpdate(Trigger.NewMap, Trigger.OldMap);
        }
    }

}