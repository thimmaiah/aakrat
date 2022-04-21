import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("projectaccess connect");
    }


    setRole(event) {
        console.log("setRole called");
        let user_id = $("#project_access_user_id").val();
        $.ajax({
            url: `/clients.json?user_id=${user_id}`
        }).then(function (data) {
            console.log(data);
            console.log(`Setting role to ${data[0].user_type}`);
            $("#project_access_role_name").val(data[0].user_type);
        });
    }
}


