import { api, LightningElement, track, wire } from 'lwc';
import getContactsByAccountId from '@salesforce/apex/ContactsController.getContactsByAccountId';
import getCasesByAccountId from '@salesforce/apex/ContactsController.getCasesByAccountId';
import getOpportunitiesByAccountId from '@salesforce/apex/ContactsController.getOpportunitiesByAccountId';


export default class RelatedContacts extends LightningElement {

    @api accountId;
    
    // contacts
    @track allContacts;

    contactColumnsOptions = [
        {label: 'First Name', fieldName: 'FirstName', type: 'text'},
        {label: 'Last Name', fieldName: 'LastName', type: 'text'},
    ]

    @wire(getContactsByAccountId, { accountId: '$accountId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.allContacts = data;
            console.log("data", data);
        } else if (error) {
            this.contacts = [];
        }
    }

    // cases
    @track allCases;

    caseColumnsOptions = [
        { label: 'Case Number', fieldName: 'CaseNumber', type: 'text' },
        { label: 'Subject', fieldName: 'Subject', type: 'text' },
        { label: 'Status', fieldName: 'Status', type: 'text' }
    ];

    @wire(getCasesByAccountId, { accountId: '$accountId' })
    wiredCases({ error, data }) {
        if (data) {
            this.allCases = data;
        } else if (error) {
            this.allCases = [];
        }
    }

    // opportunities
    @track allOpportunities;

    opportunityColumnsOptions = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Amount', fieldName: 'Amount', type: 'currency' },
        { label: 'Stage', fieldName: 'StageName', type: 'text' },
        { label: 'Close Date', fieldName: 'CloseDate', type: 'date' }
    ];

    @wire(getOpportunitiesByAccountId, { accountId: '$accountId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            this.allOpportunities = data;
        } else if (error) {
            this.allOpportunities = [];
        }
    }
}