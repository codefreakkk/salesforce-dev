import { LightningElement, track, wire } from 'lwc';
// import getAllAccounts from '@salesforce/apex/AccountControllerLWC.getAllAccounts';
import {ShowToastEvent} from "lightning/platformShowToastEvent";
import { createRecord } from 'lightning/uiRecordApi';

export default class ContactFormLWC extends LightningElement {
    @track account;
    @track firstName;
    @track lastName;
    accountOptions = [];

    // handler functions
    handleFirstName(event) {
        this.firstName = event.target.value;
    }

    handleLastName(event) {
        this.lastName = event.target.value;
    }

    handleAccount(event) {
        this.account = event.detail.value;
    }

    // get all accounts
    // @wire(getAllAccounts)
    // wiredAccounts(response) {
    //     console.log(response);
    //     const data = response.data;
    //     if (data) {
    //         this.accountOptions = data.map((accountData) => {
    //             return {label: accountData.Name, value: accountData.Id}
    //         }) 
    //         console.log("Account Options : ", this.accountOptions);
    //     }
    //     if (response.error) {
    //         console.log("Some error occured ", response.error);
    //     }
    // }

    
    // async handleSave() {
    //     // prepare contact data
    //     const fields = {
    //         AccountId: this.account,
    //         FirstName: this.firstName,
    //         LastName: this.lastName
    //     }
    //     const recordInput = {apiName: 'Contact', fields};
    //     try {
    //         await createRecord(recordInput);
    //         this.showToast('Success', 'Contact created successfully', 'success');
    //     } catch (error) {
    //         console.log("error while creating contact ", error);
    //         this.showToast('Error', 'Error creating contact ' + error.body.message, 'error')
    //     }
    // }

    // showToast(title, message, variant) {
    //     const event = new ShowToastEvent({
    //         title, message, variant
    //     });
    //     this.dispatchEvent(event);
    // }

}