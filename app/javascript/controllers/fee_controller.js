import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
      console.log("Fee javascript loaded");
      $("#per_sqft_fee").hide();
      $('#project_per_sq_ft_rate').prop('disabled', 'disabled');
      $('#project_percentage_of_estimated_budget').addClass('required');
  }

  onChange(event) {
    console.log("onChange");
    console.log("change");
    // Clear the values
    $('#project_percentage_of_estimated_budget').val(0);
    $('#project_per_sq_ft_rate').val(0);

    let selected = $("#project_fee_type").val();
    switch (selected) {
      case "% of Budget":
        // hide category & disable
        $("#per_sqft_fee").hide();
        $('#project_per_sq_ft_rate').prop('disabled', 'disabled');
        $('#project_per_sq_ft_rate').removeClass('required');

        $("#percentage_fee").show();
        $('#project_percentage_of_estimated_budget').prop('disabled', "");
        $('#project_percentage_of_estimated_budget').addClass('required');

        break;
      case "Rate / SqFt":
        // hide category & disable
        $("#per_sqft_fee").show();
        $('#project_per_sq_ft_rate').prop('disabled', '');
        $('#project_per_sq_ft_rate').addClass('required');

        $("#percentage_fee").hide();
        $('#project_percentage_of_estimated_budget').prop('disabled', "disabled");
        $('#project_percentage_of_estimated_budget').removeClass('required');
        break;
      default:
    }
  }

  

}
