import { api, LightningElement, track } from 'lwc';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";
import ACCOUNT_INDUSTRY from "@salesforce/schema/Account.Industry";

/*

create 
edit 
view

*/


export default class RecordFormPractice extends LightningElement {

    @api recordId;
    objectApiName = ACCOUNT_OBJECT;

    handleSuccess() {
        alert('Data submitted');
    }

    // create record
    // fields = [ACCOUNT_NAME];




    // edit record
    // fields = [ACCOUNT_NAME, ACCOUNT_INDUSTRY];
    
    // view record
    fields = [ACCOUNT_NAME, ACCOUNT_INDUSTRY];

}