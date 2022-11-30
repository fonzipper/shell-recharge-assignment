import { LightningElement, api, track } from 'lwc';

const columns = [
    {
        label: 'Case',
        type:"button",
        fixedWidth: 100,
        typeAttributes: {
            label: 'View Case',
            name: 'open',
            variant: 'base'
        }
    },
    {
        label: 'Assign Date',
        fieldName: 'AcceptDateTime',
        type: 'date',
        typeAttributes: {
            year: "numeric",
            month: "numeric",
            day: "numeric",
            hour: "2-digit",
            hour12: false,
            minute: "2-digit"
        },
        sortable: 'true'
    },
    {label: 'Active Time', fieldName: 'ActiveTime', sortable: 'true'},
    {label: 'Handle Time', fieldName: 'HandleTime', sortable: 'true'},
    {label: 'Speed To Answer', fieldName: 'SpeedToAnswer', sortable: 'true'},
    {
        label: 'Decline Date',
        fieldName: 'DeclineDateTime',
        type: 'date',
        typeAttributes: {
            year: "numeric",
            month: "numeric",
            day: "numeric",
            hour: "2-digit",
            hour12: false,
            minute: "2-digit"
        },
        sortable: 'true'
    },
    {label: 'Decline Reason', fieldName: 'DeclineReason', sortable: 'true'},
    {
        label: 'Last Modified',
        fieldName: 'LastModifiedDate',
        type: 'date',
        typeAttributes: {
            year: "numeric",
            month: "numeric",
            day: "numeric",
            hour: "2-digit",
            hour12: false,
            minute: "2-digit"
        },
        sortable: 'true'
    }
];

export default class AgentWorkTable extends LightningElement {
    agentWorkRecords;
    _filteredWorkRecords;
    @track
    _filterString;
    @track
    sortField;
    @track
    sortDirection;
    columns = columns

    get filteredWorkRecords() {
        return this._filteredWorkRecords;
    }
    set filteredWorkRecords(value) {
        this._filteredWorkRecords = value;
        const recordIds = value?.map(record => record.Id);
        const filterEvent = new CustomEvent('filtering', {detail: recordIds});
        this.dispatchEvent(filterEvent);
    }

    @api
    get workRecords() {
        return this.agentWorkRecords;
    }
    set workRecords(value) {
        this.agentWorkRecords = value;
        this.filteredWorkRecords = this.filterWorkRecords(value, this.filterString);
    }

    @api
    get filterString() {
        return this._filterString;
    }
    set filterString(value) {
        this._filterString = value;
        this.filteredWorkRecords = this.filterWorkRecords(this.agentWorkRecords, value);
    }

    filterWorkRecords(records, filterString) {
        if (filterString) {
            const records = this.agentWorkRecords;
            if (records) {
                let result = [];

                for (let record of records) {
                    const valuesArray = Object.values(record);
                    for (let value of valuesArray) {
                        const stringValue = String(value);
                        if (stringValue) {
                            if (stringValue.toLowerCase().includes(filterString.toLowerCase())) {
                                result.push(record);
                                break;
                            }
                        }
                    }
                }
                return result;
            }
        } else {
            return records;
        }
    }

    handleColumnSorting(event) {
        var fieldName = event.detail.fieldName;
        var sortDirection = event.detail.sortDirection;
        this.sortField = fieldName;
        this.sortDirection = sortDirection;
        const sortEvent = new CustomEvent('sortchange', {
            detail: {
                sortField: this.sortField,
                sortDirection: this.sortDirection
            }
        });
        this.dispatchEvent(sortEvent);
    }

    navigateToCase(event) {
        const row = event.detail.row;
        const caseId = row.WorkItemId;
        const navigateEvent = new CustomEvent('navigate', {detail: caseId});
        this.dispatchEvent(navigateEvent);
    }
}