public with sharing class ToDoAppService {
    public static List<ToDoAppWrapper> getToDoList() {
        return ToDoAppHttpCalloutHandler.getList();
    }

    public static List<ToDoAppWrapper> postToDoList(List<ToDoAppWrapper> serialisedRecord){
        return ToDoAppHttpCalloutHandler.postList(serialisedRecord);
    }

    public static List<ToDoAppWrapper> deleteToDoList(String id){
        return ToDoAppHttpCalloutHandler.deleteRecord(id);
    }
    
    public static ToDoAppWrapper updateToList(String id, List<ToDoAppWrapper> record){
        return ToDoAppHttpCalloutHandler.editRecord(id, record);
    }
}