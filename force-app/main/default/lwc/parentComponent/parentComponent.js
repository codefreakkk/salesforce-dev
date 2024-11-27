import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {

    @track employeeName = '';
    messageFromChild = '';

    handleEmployeeName(event) {
        this.employeeName = event.target.value;
    }

    // child to parent call
    handleCallChildMethod() {
        const child = this.template.querySelector('c-child-component');
        child.greet()
    }

    // 2nd way child to parent communication
    handleMessage(event) {
        // access the data sent via child in parent
        this.messageFromChild = event.detail.data;
    } 
}