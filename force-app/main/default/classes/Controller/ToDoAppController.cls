public with sharing class ToDoAppController {
    @AuraEnabled(cacheable=true)
    public static List<ToDoAppWrapper> getList() {
        return ToDoAppService.getToDoList();
    }
    @AuraEnabled(cacheable=true)
    public static List<ToDoAppWrapper> postList(String serializedRecord){
        return ToDoAppService.postToDoList((List<ToDoAppWrapper>)JSON.deserialize(serializedRecord, List<ToDoAppWrapper>.class));
    }

    @AuraEnabled(cacheable=true)           
    public static List<ToDoAppWrapper> deleteList(String id){
        return ToDoAppService.deleteToDoList(id);
    }
    @AuraEnabled(cacheable=true)
    public static ToDoAppWrapper updateToList(String id, List<ToDoAppWrapper> record){
      return ToDoAppService.updateToList(id , record);
    }

}