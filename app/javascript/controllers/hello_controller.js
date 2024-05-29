import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  targets = ["nameValue"]
  connect() {
    //this.element.textContent = "Hello World!"
  }

  test(){
    //debugger
    //console.log(this.element)
    //document.querySelector("#new_task_list_title").innerHTML = this.element
  }
}
