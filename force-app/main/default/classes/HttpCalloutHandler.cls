public with sharing class HttpCalloutHandler {

    public static String BaseUrl = 'https://shrimo.com/fake-api/todos';
   
    @AuraEnabled(cacheable=true)
    public static List<Object> getList() {

        Http http = new Http();
        HttpRequest req  = new HttpRequest();
        req.setEndpoint(BaseUrl);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        HttpResponse res = http.send(req);
        if (res.getStatusCode()==200) {
            System.debug(res.getBody());
            return (List<Object>) JSON.deserializeUntyped(res.getBody());
            
        }
        else {
           throw new AuraHandledException('tU Daun');
        }
    }

    @AuraEnabled(cacheable=true)
    public static Map<String , Object> postList(String title , String status){

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BaseUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type' , 'application/json');

        Map<String , Object> body = new Map<String , Object>{
            'title' => title,
            'status' => status,
            'description'=> 'Complete JavaScript basic',
            'dueDate' =>'2024-11-15',
            'priority'=> 'High',
            'status'=> 'Not Started',
            'tags' => 'JavaScript' + 'Learning'
        };
        req.setBody(JSON.serialize(body));

        HttpResponse res = http.send(req);

        if (res.getStatusCode()== 201) {
             return (Map<String , Object>)JSON.deserializeUntyped(res.getBody());
            //return 'success';

         }
         else {
           throw new AuraHandledException('dolbaeb');
         }

        
    }

    @AuraEnabled(cacheable=true)
    public static string deleteRecord(String id){
       
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BaseUrl + '/' + id);
        req.setMethod('DELETE');
        req.setHeader('Content-Type', 'application/json');

        HttpResponse res = http.send(req);

        if (res.getStatusCode()==200 || res.getStatusCode() ==204) {
            return 'Record Deleted';
        }
        else {
             throw new AuraHandledException('failed to delete');
        }


    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> editRecord(String id , String title){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BaseUrl + '/' + id);
        req.setMethod('PUT');
        req.setHeader('Content-Type' , 'application/json');

        Map<String , Object> body = new Map<String,Object>{
            'title'=>title
        };
        
        req.setBody(JSON.serialize(body));

        HttpResponse res = http.send(req);

        if (res.getStatusCode()==200 || res.getStatusCode()==204) {
            
            return (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        }
        else {
            throw new AuraHandledException('Failed to Update');
        }
        
    }
}