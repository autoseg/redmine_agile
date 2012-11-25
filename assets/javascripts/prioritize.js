$(function(){
   $("#issues-prioritizable").sortable({
      axis: 'y',
      dropOnEmpty:false,
      cursor: 'move',
      placeholder: 'sortable-placeholder',
      update: function(event, ui) {
         var source_id = ui.item.attr('id').replace('issue_','');

         if(ui.position.top < ui.originalPosition.top) {
            var next_element_id = ui.item.next().attr('id'),
            target_id = next_element_id ? next_element_id.replace('issue_','') : 0;
         } else {
            var prev_element_id = ui.item.prev().attr('id'),
            target_id = prev_element_id ? prev_element_id.replace('issue_','') : 0;
         }

         $.post('', { _method: 'put', source_id: source_id, target_id: target_id });
      }
   });

   $("#fixed_version_id, #closed_issues").change(function(evt){
      var data = {
         fixed_version_id: $('#fixed_version_id').val(),
         closed_issues: $('#closed_issues:checked').val(),
         format: 'js'
      };

      $.get('', data);
   });
});

