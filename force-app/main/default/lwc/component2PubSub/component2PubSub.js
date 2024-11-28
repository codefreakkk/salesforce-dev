import { LightningElement, track } from 'lwc';
import {subscribe, unsubscribe} from 'c/pubsub';

export default class Component2PubSub extends LightningElement {
    
    @track message = '';

    connectedCallback() {
        subscribe('messageEvent', (payload) => this.handleMessageEvent(payload));
    }

    disconnectedCallback() {
        unsubscribe('messageEvent', (payload) => this.handleMessageEvent(payload));
    }

    handleMessageEvent(payload) {
        console.log("Payload messgae", payload.data);
        this.message = payload.data;
    }

}