import { LightningElement, api, track } from "lwc";
import getToDoList from "@salesforce/apex/ToDoAppController.getList";
import deleteRecord from "@salesforce/apex/ToDoAppController.deleteList";
import editRecord from "@salesforce/apex/ToDoAppController.updateToList";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class ToDoApp extends LightningElement {
    @api toDoList = [];
    @track isModalOpen = false;
    @track currentRecord = null;
    @track editedRecord = null;

    connectedCallback() {
        this.loadToDos();
    }

    @api
    async loadToDos() {
        try {
            const response = await getToDoList();
            console.log(response);
            this.toDoList = response.map((todo) => ({
                id: todo.id,
                title: todo.title,
                status: todo.status,
                description: todo.description,
                dueDate: todo.dueDate,
                priority: todo.priority,
                tags: todo.tags
            }));

            console.log(this.id);
        } catch (error) {
            this.showToast("Error", "Failed to load To-Do list", "error");
        }
    }

    async deleteToDos(event) {
        const recid = event.currentTarget.dataset.id;
        try {
            console.log("Event target:", event.target);
            console.log("Record id:", recid);
            await deleteRecord({ id: recid });
            this.toDoList = this.toDoList.filter((todo) => todo.id !== recid);
            this.showToast("success", "Record deleted", "success");
        } catch (error) {
            this.showToast("Error", "Failed to delete", "error");
        }
    }

    modalOpen(event) {
        const recordId = event.target.dataset.id;
        this.currentRecord = this.toDoList.find((todo) => todo.id === recordId);
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
        this.editedRecord = null;
    }
    handleModalInputChange(event) {
        const fieldName = event.target.name;
        const newValue = event.target.value;
        this.currentRecord = { ...this.currentRecord, [fieldName]: newValue };
        console.log(JSON.stringify(this.currentRecord));
    }

    async saveToDos(){
        if(!this.currentRecord){
            this.showToast("Error", "Failed update", "error");
            return;
        }
        const recordId = this.currentRecord.id;
        try {
            await editRecord(
                {
                    id:recordId,
                    record: [
                        {
                            id:this.currentRecord.id,
                            title:this.currentRecord.title,
                            status:this.currentRecord.status,
                            dueDate:this.currentRecord.dueDate,
                            tags:this.currentRecord.tags
                        }
                ]
            })
            this.toDoList = this.toDoList.map(item=> item.id===this.currentRecord.id?this.currentRecord:item);
           
            this.showToast("success", "Record edited","success");
            this.closeModal();
        } catch (error) {
            
        }

    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
}
