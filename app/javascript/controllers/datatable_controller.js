import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

      // let table = $('.jqDataTable').DataTable({        
      //   stateSave: true,
      //   retrieve: true,
      //   language: {
      //     search: '',
      //     searchPlaceholder: "Search...",
      //     paginate: {
      //       "previous": "Prev"
      //     }          
      //   }
      // });   
      // // Ensure DataTable is destroyed, else it gets duplicated
      // $(document).on('turbo:before-cache', function() {     
      //   table.destroy();
      // });


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
