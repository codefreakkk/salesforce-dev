import { api, LightningElement, track } from 'lwc';

export default class ChildLifeCycle extends LightningElement {

    @api prop;

    constructor() {
        super();
        console.log('Child constructor called');
    }

    // render() {
    //     console.log('Child render method called');
    // }

    connectedCallback() {
        console.log('Child Connected call back');
    }

    renderedCallback() {
        console.log('Child Render callback called ' + this.name);
    }

    disconnectedCallback() {
        console.log('Child disconnected callback called');
    }


}