public with sharing class ContactsController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId(String accountId) {
        return [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> getCasesByAccountId(Id accountId) {
        return [SELECT Id, CaseNumber, Subject, Status FROM Case WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunitiesByAccountId(Id accountId) {
        return [SELECT Id, Name, Amount, StageName, CloseDate FROM Opportunity WHERE AccountId = :accountId];
    }
}