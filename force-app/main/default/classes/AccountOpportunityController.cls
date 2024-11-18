public with sharing class AccountOpportunityController {
    
    public List<AccountWrapper> getAccountWithOpportunityCount() {
        List<AccountWrapper> accountWrappers = new List<AccountWrapper>();
		List<Account> accounts = [SELECT Id, Name, (SELECT Id FROM Opportunities) FROM Account LIMIT 100];
        
        for (Account acc : accounts) {
            Integer opportunityCount = acc.Opportunities.size(); // count opportunities
            accountWrappers.add(new AccountWrapper(acc, opportunityCount));
        }
        
        return accountWrappers;
    }
    
    public class AccountWrapper {
        public Account account {get; set;}
        public Integer opportunityCount {get; set;}
        public boolean isSelected {get; set;}
        
        public AccountWrapper(Account account, Integer opportunityCount) {
            this.account = account;
            this.opportunityCount = opportunityCount;
        }
    }
}