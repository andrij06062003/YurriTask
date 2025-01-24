public with sharing class ServiceHandler {
    public static List<Object> getToDoList() {
        return HttpCalloutHandler.getList();
    }
    public static Map<String,Object> postToDoList(String title , String status){
        return HttpCalloutHandler.postList(title, status);
    }
    public static List<String> deleteToDoList(String id){

        return HttpCalloutHandler.deleteRecord(id);
    }
    public static Map<String,Object> updateToList(String id , String title){
        return HttpCalloutHandler.editRecord(id, title);
    }
}