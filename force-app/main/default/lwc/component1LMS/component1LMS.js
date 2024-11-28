import { MessageContext, publish } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import MESSAGEEVENT from "@salesforce/messageChannel/MessageEvent__c"

export default class Component1LMS extends LightningElement {

    @wire(MessageContext)
    messageContext;

    handlePublish() {
        const payload = {data: 'Hey bro!'};
        publish(this.messageContext, MESSAGEEVENT, payload);
    }
}