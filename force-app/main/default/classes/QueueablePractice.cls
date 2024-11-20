public with sharing class QueueablePractice implements Queueable {

    List<Account> accountList = null;
    Id parentId = null;

    public QueueablePractice(List<Account> accountList, Id parentId) {
        this.parentId = parentId;
        this.accountList = accountList;
    }

    public void execute(QueueableContext context) {
        for (Account account : accountList) {
            account.ParentId = parentId;
        }

        try {
            update accountList;
            System.debug('Account updated');
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}