import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {

    @track employeeName = '';

    handleEmployeeName(event) {
        this.employeeName = event.target.value;
    }

    // child to parent call
    handleCallChildMethod() {
        const child = this.template.querySelector('c-child-component');
        child.greet()
    }
}