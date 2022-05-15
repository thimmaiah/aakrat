import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


  connect() {
    this.setupTable();
    // console.log("DataTable connected");
    // let controller = this;
    // $(document).on('turbo:load', function () {
    //   // controller.setupTable();
    // });
  }

  setupTable() {
    console.log("setupTable");

    let options = this.setupOptions();
    // Ensure  each DataTables is created
    let all = $(".jqDataTable").map(function () {
      return $(this).DataTable(options);
    }).get();

    // console.log(all);
        
    // Ensure each DataTable is destroyed, else it gets duplicated
    $(document).on('turbo:before-cache', function () {
      console.log("turbo:before-cache");
      all.forEach(table => {
        // console.log(table);
        table.destroy(false);
      });
    });


    let searchTerm = $("#search_term");
    if (searchTerm.length > 0) {
      table.search(searchTerm.val()).draw();
    }

  }

  setupOptions() {
    let options = {
      stateSave: true,
      retrieve: true,
      language: {
        search: '',
        searchPlaceholder: "Search...",
        paginate: {
          "previous": "Prev"
        }
      }
    };

    let sort = this.element.dataset.sort;
    // console.log(`sort = ${sort}`);

    let state = this.element.dataset.state;
    // console.log(`state = ${state}`);

    if (state === undefined) {
      state = true;
    }
    else {
      state = state == 'true';
      if (!state && sort) {
        options["order"] = [[sort, 'asc']];
      }
    }

    options["stateSave"] = state;
    // console.log(options);

    return options;
  }

}
