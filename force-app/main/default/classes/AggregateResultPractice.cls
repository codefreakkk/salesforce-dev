public class AggregateResultPractice {
    public static void query() {
        AggregateResult[] result = [SELECT Account.Name, SUM(Amount) avgAmmount FROM Opportunity GROUP BY Account.Name HAVING Account.Name != NULL];
        if (!result.isEmpty()) {
            String accountName = (String) result[0].get('Name');
            Decimal avgAmmount = (Decimal) result[0].get('avgAmmount');
            
            System.debug('Account Name = ' + accountName + ' Average Ammount = ' + avgAmmount);
        }
    }
}