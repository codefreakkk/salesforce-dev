public with sharing class AccountController {

    public List<Account> accounts {get; set;}

    public Id accountId {get; set;}
    
    public AccountController() {
        fetchAccounts();
    }

    public void fetchAccounts() {
        accounts = [SELECT Id, Name, Phone, Industry FROM Account];
    }

    public void deleteAccount() {
        try {
            if (accountId != null) {
                List<Account> accountsToBeDeleted = [SELECT Id FROM Account WHERE Id = :accountId];
                delete accountsToBeDeleted;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Account Deleted Successfully'));
                fetchAccounts();
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No account ID provided.'));
            }
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error deleting account: ' + e.getMessage()));
        }
    }
}