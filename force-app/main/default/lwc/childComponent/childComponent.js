import { track } from "lwc";
import { api, LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api name;
    @api greet() {
        alert("Hello World");
    }

    // 2nd way child to parent communication
    handleClick() {
        const event = new CustomEvent('message', {
            detail: {data: 'Hello from child'}
        });
        this.dispatchEvent(event);
    }
}