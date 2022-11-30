import { LightningElement, wire, api, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getAgentWork from '@salesforce/apex/SupervisorReportController.getAgentWork';
import { NavigationMixin } from 'lightning/navigation';

export default class SupervisorReport extends NavigationMixin(LightningElement) {
    @track
    sortDirection = '';
    @track
    sortField = '';
    @track
    agentWorkRecords;
    @track
    filteredRecordIds;
    @track
    filterString = '';

    @wire(getAgentWork, {sortField: '$sortField', sortDirection: '$sortDirection'})
    searchAgentWork({error, data}) {
        if (data) {
            this.agentWorkRecords = data;
        } else if (error) {
            const event = new ShowToastEvent({
                title: 'Error occurred',
                message: error.message,
                variant: 'error'
            });
            this.dispatchEvent(event);
        }
    }

    navigateToCase(event) {
        const caseId = event.detail;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: caseId,
                actionName: 'view',
            },
        });
    }

    handleSorting(event) {
        this.sortField = event.detail.sortField;
        this.sortDirection = event.detail.sortDirection;
    }

    handleFiltering(event) {
        this.filterString = event.detail;
    }

    populateFilteredRecordIds(event) {
        this.filteredRecordIds = event.detail;
    }
}