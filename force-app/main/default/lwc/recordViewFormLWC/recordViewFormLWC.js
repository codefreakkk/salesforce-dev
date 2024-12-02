import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';

export default class RecordViewFormLWC extends LightningElement {

    nameField = NAME_FIELD;
    lastNameField = LAST_NAME_FIELD;

    @api recordId;
    @api objectApiName;
}