public with sharing class ToDoApp {
    @AuraEnabled(cacheable=true)
    public static List<Object> getList() {
        return ToDoAppService.getToDoList();
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> postList(String title , String status){
        return ToDoAppService.postToDoList(title, status);
    }

    @AuraEnabled(cacheable=true)           
    public static List<String> deleteList(String id){
        return ToDoAppService.deleteToDoList(id);
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> editList(String id, String title ){
      return ToDoAppService.updateToList(id, title);
    }

}
