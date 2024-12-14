import { LightningElement, track, wire } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountControllerLWC.getAllAccounts';

export default class AccountWithRelatedObjects extends LightningElement {

    @track accountId;
    accountOptions = [];

    @wire(getAllAccounts)
    wiredAccounts(response) {
        console.log(response);
        const data = response.data;
        if (data) {
            this.accountOptions = data.map((accountData) => {
                return {label: accountData.Name, value: accountData.Id}
            }) 
            console.log("Account Options : ", this.accountOptions);
        }
        if (response.error) {
            console.log("Some error occured ", response.error);
        }
    }

    handleAccountChange(event) {
        this.accountId = event.detail.value;
        console.log(this.accountId);
    }
}