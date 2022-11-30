@IsTest
global class GenericMock implements System.StubProvider {

    global GenericMock() {
        this(false);
    }

    global GenericMock(Boolean statics) {
        this.statics = statics;
    }

    // If this is false, all results are pulled from the s_ variables. This is because
    // when Test.stopTest() collects batch jobs, it somehow resets the instance variables
    // on the GenericMock. As such, enabling writing to the statics works better.
    // WARNING: This enables a global counter on this class, which is bad when you want to
    // have more than one mock class in a method.
    private Boolean statics;

    global Map<String, Object> returns = new Map<String, Object>();
    global Map<String, Integer> callCount = new Map<String, Integer>();
    global Map<String, List<List<Object>>> callArgs = new Map<String, List<List<Object>>>();
    global Map<String, Exception> throws = new Map<String, Exception>();

    global static Map<String, Object> s_returns = new Map<String, Object>();
    global static Map<String, Integer> s_callCount = new Map<String, Integer>();
    global static Map<String, List<List<Object>>> s_callArgs = new Map<String, List<List<Object>>>();
    global static Map<String, Exception> s_throws = new Map<String, Exception>();

    global Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
        if (this.statics) {
            if (!s_callCount.containsKey(stubbedMethodName)) {
                s_callCount.put(stubbedMethodName, 0);
            }
            if (!s_callArgs.containsKey(stubbedMethodName)) {
                s_callArgs.put(stubbedMethodName, new List<List<Object>>());
            }
            s_callCount.put(stubbedMethodName, s_callCount.get(stubbedMethodName) + 1);
            s_callArgs.get(stubbedMethodName).add(listOfArgs);

            if (s_throws.containsKey(stubbedMethodName)) {
                throw s_throws.get(stubbedMethodName);
            }

            return s_returns.get(stubbedMethodName);
        }

        if (!callCount.containsKey(stubbedMethodName)) {
            callCount.put(stubbedMethodName, 0);
        }
        if (!callArgs.containsKey(stubbedMethodName)) {
            callArgs.put(stubbedMethodName, new List<List<Object>>());
        }
        callCount.put(stubbedMethodName, callCount.get(stubbedMethodName) + 1);
        callArgs.get(stubbedMethodName).add(listOfArgs);

        if (throws.containsKey(stubbedMethodName)) {
            throw throws.get(stubbedMethodName);
        }

        return returns.get(stubbedMethodName);
    }
}