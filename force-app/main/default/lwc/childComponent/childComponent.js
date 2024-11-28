import { track } from "lwc";
import { api, LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api name;
    @api greet() {
        alert("Hello World");
    }
}