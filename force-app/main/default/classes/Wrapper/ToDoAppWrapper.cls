public with sharing class ToDoAppWrapper {
    @AuraEnabled
    public String title { get; set; }
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String status { get; set; }
    @AuraEnabled
    public String description { get; set; }
    @AuraEnabled
    public String dueDate { get; set; }
    @AuraEnabled
    public String priority { get; set; }
    @AuraEnabled
    public List<String> tags { get; set; }
    @AuraEnabled
    public String source { get; set; }

    public ToDoAppWrapper() {
    }

    public ToDoAppWrapper(
        String id,
        String title,
        String status,
        String description,
        String dueDate,
        String priority,
        List<String> tags,
        String source
    ) {
        this.id = id;
        this.title = title;
        this.status = status;
        this.description = description;
        this.dueDate = dueDate;
        this.priority = priority;
        this.tags = tags;
        this.source = source;
    }
}
