import { LightningElement, api } from 'lwc';
import saveAsPDF from '@salesforce/apex/SupervisorReportController.saveAsPDF';

export default class PdfExport extends LightningElement {
    @api
    recordIds;
    @api
    sortField;
    @api
    sortDirection;

    handleSaveAsPDF(event) {
        const idsString = this.recordIds.join(',');
        saveAsPDF({recordIds: idsString, orderDirection: this.sortDirection, orderBy: this.sortField})
        .then(result => {
             window.open(result);
        })
        .catch(error => {
            const event = new ShowToastEvent({
                title: 'Error occurred',
                message: error.message,
                variant: 'error'
            });
            this.dispatchEvent(event);
        })
    }
}