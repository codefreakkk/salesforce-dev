import { LightningElement, track } from 'lwc';
import createAccount from "@salesforce/apex/AccountControllerLWC.createAccount";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';   
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import RATING_FIELD from '@salesforce/schema/Account.Rating';


export default class CreateAccountLWC extends LightningElement {
    @track name = NAME_FIELD;
    @track type = TYPE_FIELD;
    @track rating = RATING_FIELD;

    accountRatings = [
        { label: 'Hot', value: 'Hot' },
        { label: 'Warm', value: 'Warm' },
        { label: 'Cold', value: 'Cold' }
    ]
    accountTypes = [
        { label: 'Prospect', value: 'Prospect' }
    ];

    accountInfo = {
        Name: this.name,
        Type: this.type,
        Rating: this.rating
    }

    handleAccountNameChange(event) {
        this.accountInfo.Name = event.target.value;
    }

    handleAccountTypeChange(event) {
        this.accountInfo.Type = event.detail.value;
    }

    handleRatingChange(event) {
        this.accountInfo.Rating = event.detail.value;
    }

    async handleCreateAccount() {
        console.log(this.accountInfo.Name);

        // createAccount({acc: this.accountInfo})
        //     .then((response) => {
        //         console.log("Account created");
                // this.dispatchEvent(
                //     new ShowToastEvent({
                //         title: 'Success',
                //         message: 'Account created successfully',
                //         variant: 'success'
                //     })
                // );
        //     })
        //     .catch((error) => {
        //         console.log(error);
        //         this.dispatchEvent(
        //             new ShowToastEvent({
        //                 title: 'Error',
        //                 message: error.body.message,
        //                 variant: 'error'
        //             })
        //         );
        //     })

        try {
            await createAccount({acc: this.accountInfo});
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created successfully',
                    variant: 'success'
                })
            );
        } catch (e) {
            console.log("Error : ", e);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: e.body.message,
                    variant: 'error'
                })
            );
        }
    }
}