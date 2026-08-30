import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clickModal(){
    const popUp = document.querySelector(".pop-up").classList
    if (!popUp.contains('d-none'))
      popUp.add('d-none')
    else
      popUp.remove('d-none')
    console.log('teste')
  }
}
