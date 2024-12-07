import { LightningElement, wire, api, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_ID from "@salesforce/schema/Contact.AccountId";
import ACCOUNT_ID_CASE from "@salesforce/schema/Case.AccountId"; // 500
import ACCOUNT_ID_OPPORTUNITY from "@salesforce/schema/Opportunity.AccountId" // 006
 
export default class ShowParentInfoOnChildRecord extends LightningElement {
    @api recordId;
    accountId;
    objectAPIName;
    myfields = [];
    // accountFieldName = {
    //     get accountId() {
    //         console.log("Record id", this.recordId);
    //         if (this.recordId.startsWith('500')) {
    //             console.log('for case');
    //             this.objectAPIName = 'Case';
    //             // this.fields = [ACCOUNT_ID_CASE];
    //             return [ACCOUNT_ID_CASE]
                
    //         }    
    //         if (this.recordId.startsWith('006')) {
    //             console.log("for opp");
    //             this.objectAPIName = 'Opportunity'
    //             // this.fields = [ACCOUNT_ID_OPPORTUNITY]
    //             return [ACCOUNT_ID_OPPORTUNITY]
    //         }
    //         this.objectAPIName = 'Account';
    //         // this.fields = [ACCOUNT_ID]
    //         return [ACCOUNT_ID];
    //     }
    // } 

    constructor() {
        super();
        this.myFields = this.getAccountId();
    }

    @wire(getRecord, {recordId: '$recordId', fields: this.myFields}) 
    conData({data, error}) {
        if(data) {
            this.accountId = data.fields.AccountId.value; 
        }
        else {
            console.log(error);
        }
    }

    getAccountId() {
        if (this.recordId.startsWith('500')) {
            console.log('for case');
            this.objectAPIName = 'Case';
            // this.fields = [ACCOUNT_ID_CASE];
            return [ACCOUNT_ID_CASE]
            
        }    
        if (this.recordId.startsWith('006')) {
            console.log("for opp");
            this.objectAPIName = 'Opportunity'
            // this.fields = [ACCOUNT_ID_OPPORTUNITY]
            return [ACCOUNT_ID_OPPORTUNITY]
        }
        this.objectAPIName = 'Account';
        // this.fields = [ACCOUNT_ID]
        return [ACCOUNT_ID];
    }
}