public with sharing class SupervisorReportController {

    /*
    I have intentionally kept these commented lines as I think this approach to records filtering
    would be a better and more scalable solution. This approach will also support pagination or infinite scrolling
     */
    @AuraEnabled(Cacheable=true)
    public static List<AgentWork> getAgentWork(String sortField, String sortDirection) {
//        if (String.isBlank(filterString)) {
        AgentWorkRepository repo = AgentWorkRepository.getInstance();
        return repo.getOrderedAgentWork(sortField, sortDirection, null);
//        } else {
//            String query = FIELDS_TO_QUERY; //Moved to repo class
//            if (String.isNotBlank(sortField) && String.isNotBlank(sortDirection)) {
//                query += ' ORDER BY ' + sortField + ' ' + sortDirection;
//            }
//            String soslQuery = 'FIND \'' + filterString + '*\' RETURNING AgentWork(' + query + ')';
//            List<List<SObject>> searchList = Search.query(soslQuery);
//            return (List<AgentWork>) searchList[0];
//        }
    }

    @AuraEnabled
    public static String saveAsPDF(String recordIds, String orderDirection, String orderBy) {
        PageReference pdfPage = new PageReference('AgentWorkReportPDF');
        pdfPage.getParameters().put('recordIds', recordIds);
        pdfPage.getParameters().put('orderDirection', orderDirection);
        pdfPage.getParameters().put('orderBy', orderBy);
        String url = Url.getOrgDomainUrl().toExternalForm() + '/apex/' + pdfPage.getUrl();
        return url;
    }
}