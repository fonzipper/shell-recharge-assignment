@IsTest
private class SupervisorReportControllerTest {
    private static final String AGENT_WORK_PAYLOAD = '[ {\n' +
            '  "attributes" : {\n' +
            '    "type" : "AgentWork",\n' +
            '    "url" : "/services/data/v56.0/sobjects/AgentWork/0Bz68000003c70dCAA"\n' +
            '  },\n' +
            '  "Id" : "0Bz68000003c70dCAA",\n' +
            '  "WorkItemId" : "5006800000FfwKvAAJ",\n' +
            '  "AcceptDateTime" : "2022-11-29T14:27:21.000+0000",\n' +
            '  "ActiveTime" : 79,\n' +
            '  "HandleTime" : 142,\n' +
            '  "SpeedToAnswer" : 3,\n' +
            '  "LastModifiedDate" : "2022-11-29T14:29:43.000+0000",\n' +
            '  "WorkItem" : {\n' +
            '    "attributes" : {\n' +
            '      "type" : "Case",\n' +
            '      "url" : "/services/data/v56.0/sobjects/Case/5006800000FfwKvAAJ"\n' +
            '    },\n' +
            '    "Id" : "5006800000FfwKvAAJ",\n' +
            '    "CaseNumber" : "00001028"\n' +
            '  }\n' +
            '}, {\n' +
            '  "attributes" : {\n' +
            '    "type" : "AgentWork",\n' +
            '    "url" : "/services/data/v56.0/sobjects/AgentWork/0Bz68000003c6WhCAI"\n' +
            '  },\n' +
            '  "Id" : "0Bz68000003c6WhCAI",\n' +
            '  "WorkItemId" : "5006800000Ffp5xAAB",\n' +
            '  "AcceptDateTime" : "2022-11-29T10:27:48.000+0000",\n' +
            '  "ActiveTime" : 37,\n' +
            '  "HandleTime" : 111,\n' +
            '  "SpeedToAnswer" : 4,\n' +
            '  "LastModifiedDate" : "2022-11-29T10:29:39.000+0000",\n' +
            '  "WorkItem" : {\n' +
            '    "attributes" : {\n' +
            '      "type" : "Case",\n' +
            '      "url" : "/services/data/v56.0/sobjects/Case/5006800000Ffp5xAAB"\n' +
            '    },\n' +
            '    "Id" : "5006800000Ffp5xAAB",\n' +
            '    "CaseNumber" : "00001027"\n' +
            '  }\n' +
            '}, {\n' +
            '  "attributes" : {\n' +
            '    "type" : "AgentWork",\n' +
            '    "url" : "/services/data/v56.0/sobjects/AgentWork/0Bz68000003c5fcCAA"\n' +
            '  },\n' +
            '  "Id" : "0Bz68000003c5fcCAA",\n' +
            '  "WorkItemId" : "5006800000FfY5DAAV",\n' +
            '  "AcceptDateTime" : "2022-11-28T14:14:18.000+0000",\n' +
            '  "ActiveTime" : 0,\n' +
            '  "HandleTime" : 6967,\n' +
            '  "SpeedToAnswer" : 9,\n' +
            '  "LastModifiedDate" : "2022-11-28T16:10:25.000+0000",\n' +
            '  "WorkItem" : {\n' +
            '    "attributes" : {\n' +
            '      "type" : "Case",\n' +
            '      "url" : "/services/data/v56.0/sobjects/Case/5006800000FfY5DAAV"\n' +
            '    },\n' +
            '    "Id" : "5006800000FfY5DAAV",\n' +
            '    "CaseNumber" : "00001026"\n' +
            '  }\n' +
            '} ]';

    @IsTest
    static void getAgentWork() {
        List<AgentWork> records = (List<AgentWork>) JSON.deserialize(AGENT_WORK_PAYLOAD, List<AgentWork>.class);
        GenericMock mock = new GenericMock();
        mock.returns.put('getOrderedAgentWork', records);
        AgentWorkRepository.instance = (AgentWorkRepository) Test.createStub(AgentWorkRepository.class, mock);

        Test.startTest();
        List<AgentWork> result = SupervisorReportController.getAgentWork('Id', 'desc');
        Test.stopTest();

        System.assertEquals(3, result.size(), '3 AgentWork records are expected.');
        System.assertEquals(1, mock.callCount.get('getOrderedAgentWork'), '1 call to repository is expected');
    }

    @IsTest
    static void saveAsPDF() {
        String recordId = '0Bz68000003c5fcCAA';
        String orderBy = 'Id';
        String orderDirection = 'desc';
        String controlURL = Url.getOrgDomainUrl().toExternalForm() + '/apex/AgentWorkReportPDF?orderBy=Id&orderDirection=desc&recordIds=0Bz68000003c5fcCAA';

        Test.startTest();
        String resultURL = SupervisorReportController.saveAsPDF(recordId, orderDirection, orderBy);
        Test.stopTest();

        System.assertEquals(controlURL, resultURL, 'Wrong result URL');
    }
}