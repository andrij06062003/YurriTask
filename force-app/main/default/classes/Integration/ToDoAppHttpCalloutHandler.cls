public with sharing class ToDoAppHttpCalloutHandler {
    //Version 1
    public static String BaseUrl = 'https://shrimo.com/fake-api/todos';

    public static List<ToDoAppWrapper> getList() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BaseUrl);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            System.debug(res.getBody());
            return (List<ToDoAppWrapper>) JSON.deserialize(
                res.getBody().replaceAll('_id', 'id'),
                List<ToDoAppWrapper>.class
            );
        } else {
            throw new AuraHandledException('tU Daun');
        }
    }

    public static List<ToDoAppWrapper> postList(List<ToDoAppWrapper> todoList) {
        List<ToDoAppWrapper> todo = new List<ToDoAppWrapper>();
        Http http = new Http();
        for (ToDoAppWrapper rec : todoList) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(BaseUrl);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(JSON.serialize(rec));

            System.debug(req.getBody());
            HttpResponse res = http.send(req);

            System.debug('Response Status Code: ' + res.getStatusCode());
            System.debug('Response Body: ' + res.getBody());

            if (res.getStatusCode() == 201 || res.getStatusCode() == 200) {
                ToDoAppResponseWrapper wrap = (ToDoAppResponseWrapper) JSON.deserialize(
                    res.getBody(),
                    ToDoAppResponseWrapper.class
                );
                todo.add(wrap.data);
                System.debug(wrap.data);
            } else {
                throw new AuraHandledException('dolbaeb');
            }
        }
        return todo;
    }

    public static List<ToDoAppWrapper> deleteRecord(String id) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BaseUrl + '/' + id);
        req.setMethod('DELETE');
        req.setHeader('Content-Type', 'application/json');

        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
            return new List<ToDoAppWrapper>();
        } else {
            throw new AuraHandledException('failed to delete');
        }
    }

    public static ToDoAppWrapper editRecord(
        String id,
        List<ToDoAppWrapper> record

    ) {
        System.debug(id);
        System.debug(record);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BaseUrl + '/' + id);
        req.setMethod('PUT');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(record));

        HttpResponse res = http.send(req);
        System.debug(req.getBody());
        System.debug(res.getBody());

        if (res.getStatusCode() == 200 || res.getStatusCode() == 204) {
            return (ToDoAppWrapper) JSON.deserialize(
                res.getBody(),
                ToDoAppWrapper.class
            );
        } else {
            throw new AuraHandledException('Failed to Update');
        }
    }
}
