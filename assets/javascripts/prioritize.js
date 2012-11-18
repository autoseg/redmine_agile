$(function(){
   $("#issues-prioritizable").sortable({
      axis: 'y',
      dropOnEmpty:false,
      cursor: 'move',
      placeholder: 'sortable-placeholder',
      update: function(event, ui) {
         var id_source = ui.item.attr('id').replace('issue_','');

         if(ui.item.prev().attr('id')) {
            var id_prev = ui.item.prev().attr('id').replace('issue_',''),
            id_target = ui.item.prev().attr('id') ? id_prev  : 0;
         } else {
            var id_next = ui.item.next().attr('id').replace('issue_',''),
            id_target = ui.item.next().attr('id') ? id_next : 0;
         }

         $.post('', { _method: 'put', source: id_source, target: id_target });
      }
   });

   $("#fixed_version_id").change(function(evt){
      $.get('', { fixed_version_id: $(this).val(), format: 'js' });
   });
});

