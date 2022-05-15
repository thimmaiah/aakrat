import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


  connect() {

      let options = {
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
      console.log(`sort = ${sort}`);
      
      let state = this.element.dataset.state;
      console.log(`state = ${state}`);
    
      if (state === undefined) {
        state = true;
      }
      else {
        state = state == 'true';
        if(!state && sort) {
          options["order"] = [[sort, 'asc']];
        }
      }

      options["stateSave"] = state;
      console.log(options);
  
      // Ensure  each DataTables is created
      let all = $(".jqDataTable").map(function() {
          return $(this).DataTable(options);
      }).get();

      
      // Ensure each DataTable is destroyed, else it gets duplicated
      $(document).on('turbo:before-cache', function () {
        all.forEach(table => {
          table.destroy();
        });
      });
  
      
      let searchTerm = $("#search_term");
      if (searchTerm.length > 0) {
        table.search(searchTerm.val()).draw();
      }
  }

}
