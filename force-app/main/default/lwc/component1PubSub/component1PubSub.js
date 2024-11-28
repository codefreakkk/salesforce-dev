import { LightningElement } from 'lwc';
import {publish} from 'c/pubsub';

export default class Component1PubSub extends LightningElement {
    handlePublishEvent() {
        const payload = {data: 'Hello world'};
        publish('messageEvent', payload);
    }
}