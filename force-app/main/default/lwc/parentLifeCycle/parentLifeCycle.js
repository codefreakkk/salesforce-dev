import { LightningElement, track } from 'lwc';

export default class ParentLifeCycle extends LightningElement {

    @track name;

    constructor() {
        super();
        console.log('Parent constructor called');
    }

    // render() {
    //     console.log('Parent render method called');
    // }

    connectedCallback() {
        console.log('Parent Connected call back');
    }

    renderedCallback() {
        console.log('Parent Render callback called');
    }

    disconnectedCallback() {
        console.log('Parent disconnected callback called');
    }

    handleChange(event) {
        this.name = event.target.value;
    }
}