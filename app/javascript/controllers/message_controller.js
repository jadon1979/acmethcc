import ApplicationController from "controllers/application_controller"

export default class extends ApplicationController {

  connect () {
    super.connect()
  }

  createMessage() {
    console.log("createMessage")
  }

  renderMessage() { 
    console.log("renderMessage")
  }
}