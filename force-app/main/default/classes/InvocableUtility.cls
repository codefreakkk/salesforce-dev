public class InvocableUtility {
    
    public class AccountWrapper {
        @InvocableVariable
        public Id accountId;
        
        @InvocableVariable
        public String phone;
    }
    
	@InvocableMethod(label='Update related contact' description='Update related contacts of account')
    public static void updateRelatedContacts(List<AccountWrapper> accountList) {
        
        Map<Id, String> accountIdWithPhone = new Map<Id, String>(); 
        for (AccountWrapper accountWrapper : accountList) {
            accountIdWithPhone.put(accountWrapper.accountId, accountWrapper.phone);
        }
        
        List<Contact> contactList = new List<Contact>();
        for (Contact contact : [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN :accountIdWithPhone.keySet()]) {
            contact.Phone = accountIdWithPhone.get(contact.AccountId); 
            contactList.add(contact);
        }
        
        if (!contactList.isEmpty()) {
            update contactList;
            System.debug('Contacts updated');
        }
    }
}