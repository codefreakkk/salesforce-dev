public class AccountTriggerHandlerPractice {
    public static void createRelatedContact(List<Account> accountList) {
        List<Contact> contactList = new List<Contact>();
        for (Account account : accountList) {
            Contact contact = new Contact();
            contact.AccountId = account.Id;
            contact.LastName = account.Name;
            contactList.add(contact);
        }
        if (!contactList.isEmpty()) {
            insert contactList;
            System.debug('contact created');
        }
    }
}