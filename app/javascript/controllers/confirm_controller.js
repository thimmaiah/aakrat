import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {
        console.log("confirm connect");
    }

    delete(event) { 
        console.log(event.target.closest("form"));
        this.deleteForm = event.target.closest("form");

        $("#confirm_submit").attr("action", this.deleteForm.action);
        $('#confirmModal').modal({});
        event.preventDefault();
    }

    ok(event) {
        console.log("confirm clicked");
        $('#confirmModal').modal('hide');
    }

}


