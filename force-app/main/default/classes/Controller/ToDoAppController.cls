public with sharing class ToDoAppController {
    @AuraEnabled
    public static List<ToDoAppWrapper> getList() {
        return new ToDoAppService().getToDoList();
    }
    @AuraEnabled
    public static List<ToDoAppWrapper> postList(String serialisedRecord){
        return new ToDoAppService().postToDoList((List<ToDoAppWrapper>)JSON.deserialize(serialisedRecord, List<ToDoAppWrapper>.class));
    }

    @AuraEnabled        
    public static List<ToDoAppWrapper> deleteList(String id , String source){
        return new ToDoAppService().deleteToDoList(id , source);    
    }
    @AuraEnabled
    public static ToDoAppWrapper updateToList(String id, ToDoAppWrapper record){
      return new ToDoAppService().updateToList(id , record);
    }

}