import { LightningElement, api } from 'lwc';

export default class FilterInput extends LightningElement {
    handleFiltering(event) {
        const filterString = event.detail.value;
        const filterEvent = new CustomEvent('filterchange', {detail: filterString});
        this.dispatchEvent(filterEvent);
    }
}