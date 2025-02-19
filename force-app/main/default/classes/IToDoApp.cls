public interface IToDoApp {
    List<ToDoAppWrapper> getList();
    List<ToDoAppWrapper> postList(List<ToDoAppWrapper> serialisedRecord);
    List<ToDoAppWrapper> deleteRecord(String id ,String source);
    ToDoAppWrapper editRecord(String id, ToDoAppWrapper record);
}
