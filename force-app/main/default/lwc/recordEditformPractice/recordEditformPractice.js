import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";

export default class RecordEditformPractice extends LightningElement {
    
    objectApiName = ACCOUNT_OBJECT;
    
    handleSucces() {
        alert('Data submitted');
    }

    // create record
    accountName = ACCOUNT_NAME;

}