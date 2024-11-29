public with sharing class ContactControllerLWC {

    @AuraEnabled
    public static List<Contact> getAllContacts(String contact){
        try {
            String searchText = '%'+contact+'%';
            List<Contact> allContacts = [SELECT Id, FirstName, LastName FROM Contact WHERE LastName LIKE :searchText];
            System.debug(allContacts);
            return allContacts;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}