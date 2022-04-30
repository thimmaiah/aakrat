import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("project connect");
    }


    setStatus(event) {
        let status = $("#site_visit_completed").val();
        console.log(`setStatus called ${status}`);
        let form = $("#site_visit_completed_form");
        // Set the action of the form to the current url, so we can request the same data with new currency
        let actionUrl = window.location.href.split("?")[0];
        console.log(actionUrl);
        form.attr('action', actionUrl);

        let query = window.location.search.substring(1);
        console.log(`query = ${query}`)
        let vars = query.split('&');
        console.log(`vars = ${vars}`);

        // We need to make sure all params in the URL are sent back
        // So add them to the form
        vars.forEach(keyVal => {
            let keyValArr = keyVal.split('=');
            if (keyValArr[0] != "completed") {
                form.append(`<input type='text' hidden="hidden" name='${keyValArr[0]}' value='${keyValArr[1]}' />`);
            }
        });

        // Make the call
        let submit = form.find("input[type='submit']");
        submit.click();

    }
}


