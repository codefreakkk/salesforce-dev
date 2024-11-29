import { LightningElement, track, wire } from 'lwc';
import getAllContacts from "@salesforce/apex/ContactControllerLWC.getAllContacts";
import ContactUpdateModal from 'c/contactUpdateModal';
import { MessageContext, subscribe } from 'lightning/messageService';
import CONTACT_UPDATE_EVENT from '@salesforce/messageChannel/ContactUpdateEvent__c';
import {refreshApex} from "@salesforce/apex";


export default class UpdateContactLWC extends LightningElement {
    @track contact;
    @track allContacts;
    @track wiredContactResults;

    @wire(MessageContext)
    messageContext;

    contactColumnsOptions = [
        {label: 'First Name', fieldName: 'FirstName', type: 'text'},
        {label: 'Last Name', fieldName: 'LastName', type: 'text'},
        {
            label: 'Action',
            type: 'button',
            typeAttributes: {
                label: 'Update',
                name: 'update',
                variant: 'success'
            }
        }
    ]

    connectedCallback() {
        subscribe(this.messageContext, CONTACT_UPDATE_EVENT, async (payload) => {
            console.log("SUBSCRIBED TO EVENT");
            await refreshApex(this.wiredContactResults);
        });
    }

    @wire(getAllContacts, {contact: '$contact'})
    wiredContact(result) {
        this.wiredContactResults = result;
        const {error, data} = result; 
        if (data) {
            this.allContacts = data;
        }
        if (error) {
            this.allContacts = undefined;
        }
    }

    handleContact(event) {
        this.contact = event.target.value;
    }

    async handleUpdate(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === "update") {
            const contactId = row.Id;
            const firstName = row.FirstName;
            const lastName = row.LastName;

            console.log('Row : ', row);

            await ContactUpdateModal.open({
                size: 'medium',
                description: 'Accessible description of modal\'s purpose',
                content: {
                    contactId, firstName, lastName
                },
            });
        }
    }
}