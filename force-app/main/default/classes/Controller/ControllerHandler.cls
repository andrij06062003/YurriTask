public with sharing class ControllerHandler {
    @AuraEnabled(cacheable=true)
    public static List<Object> getListController() {
        return ServiceHandler.getToDoList();
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> postListController(String title , String status){
        return ServiceHandler.postToDoList(title, status);
    }

    @AuraEnabled(cacheable=true)           
    public static List<String> deleteListController(String id){
        return ServiceHandler.deleteToDoList(id);
    }
    @AuraEnabled(cacheable=true)
    public static Map<String,Object> editListController(String id, String title ){
      return ServiceHandler.updateToList(id, title);
    }
}
