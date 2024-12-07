import { MessageContext, publish, subscribe } from 'lightning/messageService';
import { LightningElement, track, wire } from 'lwc';
import MESSAGEEVENT from "@salesforce/messageChannel/MessageEvent__c"

export default class Component1LMS extends LightningElement {

    @wire(MessageContext)
    messageContext;

    @track message;

    connectedCallback() {
        subscribe(this.messageContext, MESSAGEEVENT, (payload) => this.handleEvent(payload));
    }

    handlePublish() {
        const payload = {data: 'Hey bro!'};
        publish(this.messageContext, MESSAGEEVENT, payload);
    }
    
    handleEvent(payload) {
        this.message = payload.data;
    }
}