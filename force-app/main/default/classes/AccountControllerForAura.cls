public with sharing class AccountControllerForAura {

    @AuraEnabled
    public static List<Account> getAllAccountWithRatingHot(){
        try {
            List<Account> accounts = [SELECT Id, Name, Rating, Type, Industry FROM Account WHERE Rating = 'Hot'];
            return accounts;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}