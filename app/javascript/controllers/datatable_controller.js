import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


  connect() {
      console.log(`sort = ${this.element.dataset.sort}`);
      let sort = this.element.dataset.sort;
      console.log(`sort = ${sort}`);
      
      let state = this.element.dataset.state;
      if (state === undefined) {
        state = true;
      }
      else {
        state = state == 'true';
      }

      console.log(`state = ${state}`);
    
      let options = {
        stateSave: state,
        retrieve: true,
        order: [[sort, 'asc']],
        language: {
          search: '',
          searchPlaceholder: "Search...",
          paginate: {
            "previous": "Prev"
          }
        }
      };

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
