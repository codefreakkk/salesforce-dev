import { LightningElement, track } from 'lwc';
import selfRegister from '@salesforce/apex/CustomSelfRegHandler.selfRegister';
 
export default class CustomSelfRegister extends LightningElement {
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track studentName = '';
    @track message = '';
    @track password = '';
    @track error = '';
 
    // Handle input change and update corresponding properties
    handleInputChange(event) {
        const field = event.target.dataset.field;
        this[field] = event.target.value;
    }
 
    // Handle registration
    async handleRegister() {
        this.message = '';
        this.error = '';
        const obj = {firstName: this.firstName,
            lastName: this.lastName,
            email: this.email,
            studentName: this.studentName,
            password: this.password};
            console.log('user ', obj.email);
        try {
            const result = await selfRegister({
                firstName: this.firstName,
                lastName: this.lastName,
                email: this.email,
                studentName: this.studentName,
                password: this.password
            });
            console.log('Result', result);
            this.message = result;
            this.clearFields();
        } catch (err) {
            console.log('err', err);
            this.error = err.body.message || 'An error occurred during registration';
        }
    }
 
    // Clear input fields after successful registration
    clearFields() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.studentName = '';
        this.password = '';
    }
}