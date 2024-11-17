public with sharing class AccountTriggerHandler {
    public void updateAccountDescription(List<Account> accountList) {
        for (Account accounts : accountList) {
            accounts.Description = 'Account Description updated via trigger';
        }
    }
}