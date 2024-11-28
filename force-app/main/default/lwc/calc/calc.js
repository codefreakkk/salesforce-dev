import { LightningElement , track} from 'lwc';

export default class Calc extends LightningElement {
    value1 = 0;
    value2 = 0;
    @track result = 0;
    @track message = ''

    handleAdd() {
        this.result = parseInt(this.value1) + parseInt(this.value2);
        this.message = 'Your addition is ' + this.result;
    }

    handleSub() {
        this.result = parseInt(this.value1) - parseInt(this.value2);
        this.message = 'Your Sub is ' + this.result;
    }

    handleMul() {
        this.result = parseInt(this.value1) * parseInt(this.value2);
        this.message = 'Your Mul is ' + this.result;
    }

    handleDiv() {
        this.result = parseInt(this.value1) / parseInt(this.value2);
        this.message = 'Your Div is ' + this.result;
    }

    // handler for input
    handleValue1() {
        this.value1 = event.target.value;
    }

    handleValue2() {
        this.value2 = event.target.value;
    }
}