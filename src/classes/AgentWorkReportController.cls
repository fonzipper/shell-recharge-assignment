public with sharing class AgentWorkReportController {

    public List<AgentWork> records {get;set;}

    public AgentWorkReportController() {
        String recordIdsString = ApexPages.currentPage().getParameters().get('recordIds');
        String orderDirection = ApexPages.currentPage().getParameters().get('orderDirection');
        String orderBy = ApexPages.currentPage().getParameters().get('orderBy');
        if (String.isNotBlank(recordIdsString)) {
            List<Id> idList = (List<Id>) recordIdsString.split(',');
            Set<Id> recordIds = new Set<Id>(idList);
            AgentWorkRepository repo = AgentWorkRepository.getInstance();
            records = repo.getOrderedAgentWork(orderBy, orderDirection, recordIds);
        }
    }
}