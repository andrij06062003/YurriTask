import { LightningElement, track } from "lwc";
import addToList from "@salesforce/apex/ToDoAppController.postList";
import getTodoList from "@salesforce/apex/ToDoAppController.getList";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class ToDoApp extends LightningElement {
    @track toDoList=[];
    newTask = "";
    newStatus = "Not Started";
    newDescription = "";
    newDueDate = "12-11-2025";
    newPriority = "Medium";
    newTags = [];  
    source = '';  
    
    
    handleInputChange(event) {
                this.newTask = event.target.value;
            }
        
            handleStatusChange(event) {
                this.newStatus = event.target.value;
            }
        
            handleDescriptionChange(event) {
                this.newDescription = event.target.value;
            }
        
            handleDueDateChange(event) {
                this.newDueDate = event.target.value;
            }
        
            handlePriorityChange(event) {
                this.newPriority = event.target.value;
            }
        
            handleTagsChange(event) {
                this.newTags = event.target.value;
            }

            connectedCallback(){
                this.fetchToDoList();
            }
            handleSourceApi(){
                this.source = 'API';
            }
            handleSourceSalesForce(){
                this.source = 'SalesForce';
            }
   
    async addToDo() {
        if (!this.newTask) {
            this.showToast("Error", "Task exist", "error");
            return;
        }

        const newToDo = {
            title: this.newTask,
            status: this.newStatus,
            description: this.newDescription,
            dueDate: this.newDueDate,
            priority: this.newPriority,
            tags: this.newTags.split(",").map((tag) => {
                return tag.trim();
            }),
            source:this.source
        };

        console.log(this.source);
        console.log(JSON.stringify(newToDo));
        try {
            const res = await addToList({
                serialisedRecord: JSON.stringify([newToDo])
            });
            this.toDoList = [...res, ...this.toDoList];
            //this.resetFields();
            this.showToast("Success", "Task added", "success");
        } catch (error) {
            this.showToast("Error", "Failed to add To-Do", "error");
        }
    }

   async fetchToDoList(){
        try {
            const res = await getTodoList();
            this.toDoList = res;

        } catch (error) {
            this.showToast("Error" , "Fail" , 'error');
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


// import { LightningElement, track } from "lwc";
// import getToDoList from "@salesforce/apex/ToDoAppController.getList";
// import addToList from "@salesforce/apex/ToDoAppController.postList";
// import deleteRecord from "@salesforce/apex/ToDoAppController.deleteList";
// import editRecord from "@salesforce/apex/ToDoAppController.editList";
// import { ShowToastEvent } from "lightning/platformShowToastEvent";

// export default class ToDoApp extends LightningElement {
//     @track toDoList = [];
//     newTask = "";
//     newStatus = "Not Started";
//     newDescription = "";
//     newDueDate = "12-11-2025";
//     newPriority = "Medium";
//     newTags = [];                                                                              

//     connectedCallback() {
//         this.loadToDos();
//     }

   
//     async loadToDos() {
//         try {
//             const response = await getToDoList();
//             console.log(response);
//             this.toDoList = response.map((todo) => ({
//                 id: todo.id,
//                 title: todo.title,
//                 status: todo.status,
//                 description: todo.description,
//                 dueDate: todo.dueDate,
//                 priority: todo.priority,
//                 tags: todo.tags
//             }));
//             console.log(this.id);
//         } catch (error) {
//             this.showToast("Error", "Failed to load To-Do list", "error");
//         }
//     }

//     handleInputChange(event) {
//         this.newTask = event.target.value;
//     }

//     handleStatusChange(event) {
//         this.newStatus = event.target.value;
//     }

//     handleDescriptionChange(event) {
//         this.newDescription = event.target.value;
//     }

//     handleDueDateChange(event) {
//         this.newDueDate = event.target.value;
//     }

//     handlePriorityChange(event) {
//         this.newPriority = event.target.value;
//     }

//     handleTagsChange(event) {
//         this.newTags = event.target.value;
//     }

//     get options() {
//         return [
//             { label: "Title", value: "title" },
//             { label: "Status", value: "status" },
//             { label: "Due Date", value: "dueDate" },
//             { label: "Description", value: "description" },
//             { label: "Due Date", value: "dueDate" },
//             { label: "Priority", value: "priority" }
//         ];
//     }

//     async addToDo() {
//         if (!this.newTask) {
//             this.showToast("Error", "Task exist", "error");
//             return;
//         }

//         const newToDo = {
//             title: this.newTask,
//             status: this.newStatus,
//             description: this.newDescription,
//             dueDate: this.newDueDate,
//             priority: this.newPriority,
//             tags: this.newTags.split(",").map((tag) => {
//                 return tag.trim();
//             })
//         };

//         console.log(JSON.stringify(newToDo));
//         try {
//             const res = await addToList({
//                 serializedRecord: JSON.stringify([newToDo])
//             });
//             this.toDoList = [...res, ...this.toDoList];
//             this.resetFields();
//             this.showToast("Success", "Task added", "success");
//         } catch (error) {
//             this.showToast("Error", "Failed to add To-Do", "error");
//         }
//     }

//     resetFields() {
//         this.title = "";
//         this.status = "";
//         this.description = "";
//         this.dueDate = "";
//         this.priority = "";
//         this.tags = [];
//     }

//     async deleteToDos(event) {
//         const recid = event.currentTarget.dataset.id;
//         try {
//             console.log("Event target:", event.target);
//             console.log("Record id:", recid);
//             await deleteRecord({ id: recid });
//             this.toDoList = this.toDoList.filter((todo) => todo.id !== recid);
//             this.showToast("success", "Record deleted", "success");
//         } catch (error) {
//             this.showToast("Error", "Failed to delete", "error");
//         }
//     }

//     async handleEditChange(event) {
//         const recid = event.target.dataset.id;
//         const updateTitle = event.target.value;

//         this.toDoList = this.toDoList.map((todo) => {
//             if (todo.id == recid) {
//                 return { ...todo, title: updateTitle };
//             }
//             return todo;
//         });
//     }

//     async saveToDos(event) {
//         const recid = event.target.dataset.id;
//         const updatedRecord = this.toDoList.find((todo) => todo.id === recid);

//         if (!updatedRecord) {
//             this.showToast("Error", "Record empty", "error");
//             return;
//         }
//         try {
//             await editRecord({ id: recid, title: updatedRecord.title });
//             this.showToast("success", "Record edited sucesfully", "success");
//         } catch (error) {
//             this.showToast("Error", "Dayn ne editnuv", "error");
//         }
//     }

//     showToast(title, message, variant) {
//         const evt = new ShowToastEvent({
//             title: title,
//             message: message,
//             variant: variant
//         });
//         this.dispatchEvent(evt);
//     }
// }
