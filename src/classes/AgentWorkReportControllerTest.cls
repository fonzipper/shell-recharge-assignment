@IsTest
private class AgentWorkReportControllerTest {
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
    static void testConstructor() {
        List<AgentWork> records = (List<AgentWork>) JSON.deserialize(AGENT_WORK_PAYLOAD, List<AgentWork>.class);
        GenericMock mock = new GenericMock();
        mock.returns.put('getOrderedAgentWork', records);
        AgentWorkRepository.instance = (AgentWorkRepository) Test.createStub(AgentWorkRepository.class, mock);

        PageReference pageRef = Page.AgentWorkReportPDF;
        pageRef.getParameters().put('recordIds', '0Bz68000003c70dCAA,0Bz68000003c6WhCAI,0Bz68000003c5fcCAA');
        pageRef.getParameters().put('orderDirection', 'asc');
        pageRef.getParameters().put('orderBy', 'Id');
        Test.setCurrentPage(pageRef);

        Test.startTest();
        AgentWorkReportController controller = new AgentWorkReportController();
        Test.stopTest();

        System.assertEquals(3, controller.records.size(), '3 AgentWork records are expected');
        System.assertEquals(1, mock.callCount.get('getOrderedAgentWork'), '1 call to repository is expected');
        List<Object> callArgs = mock.callArgs.get('getOrderedAgentWork')[0];
        System.assertEquals('Id', String.valueOf(callArgs[0]), 'Expected \'Id\' as an argument');
        System.assertEquals('asc', String.valueOf(callArgs[1]), 'Expected \'asc\' as an argument');
        System.assertEquals(3, ((Set<Id>)callArgs[2]).size(), 'Expected a set of 3 elements');
    }
}