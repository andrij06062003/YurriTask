public with sharing class ToDoAppSalesForce implements IToDoApp {
    public List<ToDoAppWrapper> getList() {
        List<ToDoAppWrapper> salesRec = new List<ToDoAppWrapper>();

        List<SalesForceToDoApp__c> query = [
            SELECT
                Id,
                Title__c,
                Tags__c,
                Status__c,
                DueDate__c,
                Priority__c,
                Description__c
            FROM SalesForceToDoApp__c
            LIMIT 5
        ];
        for (SalesForceToDoApp__c record : query) {
            ToDoAppWrapper wrapper = new ToDoAppWrapper();
            wrapper.id = record.id;
            wrapper.title = record.Title__c;
            wrapper.status = record.Status__c;
            wrapper.dueDate = record.DueDate__c;
            wrapper.priority = record.Description__c;
            wrapper.description = record.Description__c;

            String tagsString = record.Tags__c;
            if (tagsString != null) {
                wrapper.tags = new List<String>();
                for (String tag : tagsString.split(',')) {
                    wrapper.tags.add(tag.trim());
                }
            } else {
                wrapper.tags = new List<String>();
            }
            wrapper.source = 'SalesForce';

            salesRec.add(wrapper);
            System.debug(wrapper.tags);
        }
        System.debug(salesRec);
        return salesRec;
    }
    public List<ToDoAppWrapper> postList(
        List<ToDoAppWrapper> serialisedRecord
    ) {
        List<SalesForceToDoApp__c> listToUpdate = new List<SalesForceToDoApp__c>();
        for (ToDoAppWrapper fields : serialisedRecord) {
            SalesForceToDoApp__c rec = new SalesForceToDoApp__c();
            rec.Title__c = fields.title;
            rec.Status__c = fields.status;
            rec.DueDate__c = fields.dueDate;
            rec.Priority__c = fields.priority;
            rec.Description__c = fields.description;
            listToUpdate.add(rec);
        }
        System.debug(listToUpdate);
        if (!listToUpdate.isEmpty()) {
            insert listToUpdate;
        }
        return serialisedRecord;
    }
    public List<ToDoAppWrapper> deleteRecord(String id , String source) {
        List<SalesForceToDoApp__c> recordIds = [
            SELECT
                Id,
                Title__c,
                Tags__c,
                Status__c,
                DueDate__c,
                Priority__c,
                Description__c
            FROM SalesForceToDoApp__c
            WHERE Id = :id
        ];
        delete recordIds;
        return new List<ToDoAppWrapper>();
    }
    public ToDoAppWrapper editRecord(String id, ToDoAppWrapper record) {
        System.debug(id);
        List<SalesForceToDoApp__c> records= [
            SELECT
                Id,
                Title__c,
                Tags__c,
                Status__c,
                DueDate__c,
                Priority__c,
                Description__c
            FROM SalesForceToDoApp__c
            WHERE Id = :id
            LIMIT 1
        ];

        System.debug(records);
        if (!records.isEmpty()) {
            SalesForceToDoApp__c getRecord = records[0];
            getRecord.Title__c = record.title;
            getRecord.Status__c = record.status;
            getRecord.DueDate__c = record.dueDate;
            getRecord.Priority__c = record.priority;
            getRecord.Description__c = record.description;
            update getRecord;
        }
        else {
            throw new AuraHandledException('No record found with the specified Id.');
        }

        return record;
    }
}
