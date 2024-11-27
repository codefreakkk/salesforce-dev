public with sharing class AccountControllerLWC {
    
    @AuraEnabled
    public static Account createAccount(Account acc) {
        try {
            insert acc;
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}