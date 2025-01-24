import { LightningElement, track } from 'lwc';
 import getToDoList from '@salesforce/apex/ToDoApp.getList';
// import addToList from '@salesforce/apex/ControllerHandler.postList';
// import deleteRecord from '@salesforce/apex/ControllerHandler.deleteList';
// import editRecord from '@salesforce/apex/ControllerHandler.editList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToDoApp extends LightningElement {
    @track toDoList = [];
    newTask = '';

    connectedCallback() {
        this.loadToDos();
    }

    async loadToDos() {
        try {
            const response = await getToDoList()
            console.log(response);
            this.toDoList = response.map(todo => ({
                id: todo._id,  
                title: todo.title
            }));
        } catch (error) {
            this.showToast('Error', 'Failed to load To-Do list', 'error');
        }
    }

    handleInputChange(event) {
        this.newTask = event.target.value;
    }

    async addToDo(){
       if(!this.newTask){
        this.showToast('Error' , 'Task exist' , 'error')
        return;
       }
        try {
             const res = await addToList({title: this.newTask , status:'Not Started'})
             this.toDoList = [res.data , ...this.toDoList];
             this.newTask = '';
             this.showToast('Success' , 'Task added' , 'success');

        } catch (error) {
            this.showToast('Error', 'Failed to add To-Do', 'error');
        }
      
    }
    async deleteToDos(event){
        const recid = event.target.dataset.id
        try {
            console.log(recid);
            await deleteRecord({id:recid})
            this.showToast('success', 'Record deleted' , 'success');
            
        } catch (error) {
            this.showToast('Error' , 'Failed to delete' , 'error');
        }
        
    }

    async handleEditChange(event){

        const recid = event.target.dataset.id;
        const updateTitle = event.target.value;
        
        this.toDoList = this.toDoList.map(todo=>{
            if(todo.id == recid){
                return {...todo , title:updateTitle};
            }
            return todo;
        });

    }


    async saveToDos(event){
        const recid = event.target.dataset.id
        const updatedRecord = this.toDoList.find(todo=>todo.id===recid);

        if(!updatedRecord){
            this.showToast('Error' , 'Record empty' , 'error');
            return;
        }
        try {
            await editRecord({id:recid , title:updatedRecord.title })
            this.showToast('success' , 'Record edited sucesfully' , 'success');
            
        } catch (error) {
            this.showToast('Error' , 'Dayn ne editnuv' , 'error');
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
