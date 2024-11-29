import { api, track, wire} from 'lwc';
import LightningModal from 'lightning/modal';
import { updateRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from "lightning/platformShowToastEvent";
import { MessageContext, publish } from 'lightning/messageService';
import CONTACT_UPDATE_EVENT from '@salesforce/messageChannel/ContactUpdateEvent__c';

export default class ContactUpdateModal extends LightningModal {
    @api content;
    @track firstName;
    @track lastName;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        const {firstName, lastName} = this.content;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    handleFirstName(event) {
        this.firstName = event.target.value;
    }

    handleLastName(event) {
        this.lastName = event.target.value;
    }

    async handleUpdate() {
        try {
            const {contactId} = this.content;
            const fields = {
                Id: contactId,
                FirstName: this.firstName,
                LastName: this.lastName
            };
            const recordInput = {fields};
            const updateResult = await updateRecord(recordInput);

            // publish contact update event
            if (updateResult) {
                publish(this.messageContext, CONTACT_UPDATE_EVENT, {});
            }

            // toast
            this.showToast('Success', 'Contact Updated Successfully', 'success');
        } catch (error) {
            this.showToast('Error', 'Error Updating Contact', 'error');
        }
    }

    handleOkay() {
        this.close();
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title, message, variant
        });
        this.dispatchEvent(event);
    }
}