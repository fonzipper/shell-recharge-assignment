public with sharing class AgentWorkRepository {
    public static final String FIELDS_TO_QUERY = 'Id, WorkItemId, WorkItem.CaseNumber, AcceptDateTime, ActiveTime, HandleTime, DeclineDateTime, DeclineReason, SpeedToAnswer, LastModifiedDate';

    @TestVisible
    private static AgentWorkRepository instance;

    public static AgentWorkRepository getInstance() {
        if (instance == null) {
            instance = new AgentWorkRepository();
        }
        return instance;
    }

    public List<AgentWork> getOrderedAgentWork(String orderBy, String orderDirection, Set<Id> recordIds) {
        String query = 'SELECT ' + FIELDS_TO_QUERY + ' FROM AgentWork';
        if (recordIds != null) {
            query += ' WHERE Id IN :recordIds';
        }
        if (String.isNotBlank(orderBy) && String.isNotBlank(orderDirection)) {
            query += ' ORDER BY ' + orderBy + ' ' + orderDirection;
        }
        return Database.query(query);
    }
}