import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAllContacts from "@salesforce/apex/ContactControllerLWC.getAllContacts";
import ContactUpdateModal from 'c/contactUpdateModal';
import { MessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import CONTACT_UPDATE_EVENT from '@salesforce/messageChannel/ContactUpdateEvent__c';


export default class UpdateContactLWC extends NavigationMixin(LightningElement) {
    @track contact;
    @track allContacts;
    @track wiredContactResults;

    @wire(MessageContext)
    messageContext;

    contactColumnsOptions = [
        {label: 'First Name', fieldName: 'FirstName', type: 'text'},
        {label: 'Last Name', fieldName: 'LastName', type: 'text'},
        {
            label: 'Update Contact',
            type: 'button',
            typeAttributes: {
                label: 'Update',
                name: 'update',
                variant: 'primary'
            }
        },
        {
            label: 'View Contact',
            type: 'button',
            typeAttributes: {
                label: 'view',
                name: 'view',
                variant: 'primary'
            }
        }, 
        
    ]

    connectedCallback() {
        this.refreshContact();
        subscribe(this.messageContext, CONTACT_UPDATE_EVENT, (payload) => this.handleContactUpdateEvent());
    }

    disconnectedCallback() {
        unsubscribe(this.handleContactUpdateEvent);
    }

    async refreshContact() {
        const result = await getAllContacts({contact: this.contact});
        if (result) {
            this.allContacts = [];
            this.allContacts = result;
        }
    }

    handleContact(event) {
        this.contact = event.target.value;
        this.refreshContact();
    }

    async handleUpdate(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        const contactId = row.Id;
        const firstName = row.FirstName;
        const lastName = row.LastName;

        // handle update 
        if (actionName === "update") {
            await ContactUpdateModal.open({
                size: 'medium',
                description: 'Accessible description of modal\'s purpose',
                content: {
                    contactId, firstName, lastName
                },
            });
        }

        // handle redirect/view
        if (actionName == "view") {
            console.log("Contact id ", contactId);
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage', 
                attributes: {
                    recordId: contactId,
                    objectApiName: 'Contact', 
                    actionName: 'view',
                }
            });
        }
    }

    async handleContactUpdateEvent() {
        this.refreshContact();
    }
}