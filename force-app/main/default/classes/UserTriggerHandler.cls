public with sharing class UserTriggerHandler {
    
    public void preventDeactivationOfUserForActiveCases(Map<Id, User> userMap, Map<Id, User> oldUserMap) {

        Set<Id> userIds = new Set<Id>();
        for (User user : userMap.values()) {
            if (user.IsActive != oldUserMap.get(user.Id).IsActive && user.IsActive == false) {
                userIds.add(user.Id);
            }
        }

        System.debug('Users' + userIds);

        for (Case currentCase : [SELECT Id, OwnerId FROM Case WHERE Status != 'Closed' AND OwnerId IN :userIds]) {
            if (currentCase != null) {
                userMap.get(currentCase.OwnerId).addError('Cannot deactive user cases are active on it');
                System.debug('Cannot deactivate user');
            }
        }
    }
}