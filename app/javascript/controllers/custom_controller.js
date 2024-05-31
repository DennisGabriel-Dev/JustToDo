import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "nameTaskList" ]
  connect() {
    
  }

  update_hint(){
    let nameTaskList = document.getElementById('new_task_list_title');
    nameTaskList.innerHTML = this.nameTaskListTarget.value
  }
}
