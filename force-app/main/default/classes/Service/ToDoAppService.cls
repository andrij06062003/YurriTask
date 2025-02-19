public with sharing class ToDoAppService {
    List<IToDoApp> mixmethod = new List<IToDoApp>{
        new ToDoAppHttpCalloutHandler(),
        new ToDoAppSalesForce()
    };
    public List<ToDoAppWrapper> getToDoList() {
        List<ToDoAppWrapper> result = new List<ToDoAppWrapper>();
        for (IToDoApp obj : mixmethod) {
            result.addAll(obj.getList());
        }
        return result;
    }

    public List<ToDoAppWrapper> postToDoList(
        List<ToDoAppWrapper> serialisedRecord
    ) {
        List<ToDoAppWrapper> result = new List<ToDoAppWrapper>();
        List<ToDoAppWrapper> recordsWithSourceApi = new List<ToDoAppWrapper>();
        List<ToDoAppWrapper> recordsWithSourceSalesForce = new List<ToDoAppWrapper>();
        for (ToDoAppWrapper record : serialisedRecord) {
            if (record.source == 'API') {
                recordsWithSourceApi.add(record);
            }
            if (record.source == 'SalesForce') {
                recordsWithSourceSalesForce.add(record);
            }

        }
        if (!recordsWithSourceApi.isEmpty()) {
            IToDoApp callIntegration = new ToDoAppHttpCalloutHandler();
            result.addAll(callIntegration.postList(recordsWithSourceApi));
        }

        if (!recordsWithSourceSalesForce.isEmpty()) {
            IToDoApp callSalesForce = new ToDoAppSalesForce();
            result.addAll(callSalesForce.postList(recordsWithSourceSalesForce));
        }
        return result;
    }

    public List<ToDoAppWrapper> deleteToDoList(String id, String source) {
        if (source == 'Api') {
            IToDoApp callIntegration = new ToDoAppHttpCalloutHandler();
            return callIntegration.deleteRecord(id, source);
        }
        if (source == 'SalesForce') {
            IToDoApp callSales = new ToDoAppSalesForce();
            return callSales.deleteRecord(id, source);
        } else {
            throw new AuraHandledException('Choose Type');
        }
    }

    public ToDoAppWrapper updateToList(String id, ToDoAppWrapper record) {
        System.debug(record.source);
            if (record.source == 'API') {
                IToDoApp callIntegration = new ToDoAppHttpCalloutHandler();
                return callIntegration.editRecord(id, record);
            } else if (record.source == 'SalesForce') {
                IToDoApp callSales = new ToDoAppSalesForce();
                return callSales.editRecord(id, record);
            } else {
                throw new AuraHandledException('Choose Type');
            }
        } 
}
