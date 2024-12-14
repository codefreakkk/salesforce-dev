import { LightningElement , api} from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class UpdateAccountLDS extends LightningElement {
    @api recordId;
    @api objectApiName;

    fields = [NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];

    handleSubmit() {
        this.showToast('Success', 'Record updated', 'success');
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title, message, variant
        });
        this.dispatchEvent(event);
    }

}