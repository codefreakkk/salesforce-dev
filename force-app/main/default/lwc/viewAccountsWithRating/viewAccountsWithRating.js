import { LightningElement, track, wire } from 'lwc';
import getAccountWithRating from "@salesforce/apex/ViewAccountWithRating.getAccountWithRating";
import deleteAccount from "@salesforce/apex/ViewAccountWithRating.deleteAccount";
import {ShowToastEvent} from "lightning/platformShowToastEvent";
import {refreshApex} from "@salesforce/apex";

export default class ViewAccountsWithRating extends LightningElement {
    @track accountRating = '';
    @track accounts;
    @track error;

    accountRatingsOptions = [
        {label: 'Hot', value: 'Hot'},
        {label: 'Warm', value: 'Warm'},
        {label: 'Cold', value: 'Cold'},
    ]

    // datatable columns
    accountTableColumns = [
        {label: 'Account Name', fieldName: 'Name', type: 'text'},
        {label: 'Rating', fieldName: 'Rating', type: 'text'},
        {
            label: 'Action',
            type: 'button',
            typeAttributes: {
                label: 'Delete',
                name: 'delete',
                iconName: 'utility:delete',
                variant: 'destructive'
            }
        }
    ];



    @wire(getAccountWithRating, {rating: '$accountRating'})
    wiredAccount(result) {
        this.accounts = result;
        console.log("Result", result);
        if (result.error) {
            this.error = result.error;
            this.account = undefined;
        }
    }

    handleAccountRating(event) {
        this.accountRating = event.detail.value;
    }
    
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === "delete") {
            this.deleteAccount(row.Id);
        }
    }

    async deleteAccount(accountId) {
        try {
            await deleteAccount({accountId});
            await refreshApex(this.accounts);
            this.showToast('Success', 'Account Deleted Successfully', 'success');
        } catch (e) {
            console.log("Some error occured", e);
            this.showToast('Error', 'Error deleting account ' + e.body.message, 'error')
        }
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title, message, variant
        });
        this.dispatchEvent(event);
    }
}