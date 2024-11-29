import { MessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import { LightningElement, track, wire } from 'lwc';
import MESSAGEEVENT from "@salesforce/messageChannel/MessageEvent__c"

export default class Component2LMS extends LightningElement {

    @wire(MessageContext)
    messageContext;

    @track message = '';

    connectedCallback() {
        subscribe(this.messageContext, MESSAGEEVENT, (payload) => this.handleEvent(payload));
    }

    disconnectedCallback() {
        unsubscribe(this.handleEvent);
        this.handleEvent = null;
    }

    handleEvent(payload) {
        this.message = payload.data;
    }
}