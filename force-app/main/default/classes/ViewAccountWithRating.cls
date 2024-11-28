public with sharing class ViewAccountWithRating {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountWithRating(String rating){
        try {
            System.debug('Rating : ' + rating);
            if (String.isBlank(rating)) {
                return [SELECT Id, Name, Rating FROM Account];
            }
            return [SELECT Id, Name, Rating FROM Account WHERE Rating = :rating];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteAccount(String accountId){
        try {
            System.debug('Account Id' + accountId);
            delete [SELECT Id FROM Account Where Id = :accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}