$(document).ready(function(){
	$("#mms_message_search_form").submit(function(){
		getList();
		return false;
	});

	getList();

	$("#perpage").change(function(){
		$(".user_select_pagination").empty();
		getList();
		$(this).blur();
		return true;
	 });

	function getList(current_page, jq) {
		if(!current_page)
				current_page = 0;

			var perPage =$("#perpage").val();
			var pageID=current_page+1;

			var action=$('#mms_message_search_form').attr('action');
			var find_method=$('#mms_message_search_form select[name="find_method"]').val();
			var search=$('#mms_message_search_form input[name="search"]').val();

			$.getJSON(action,{'format':'json','find_method':find_method,'search':search,'per_page':perPage,'page':pageID},function(data) {
				$('#mms_message_list').empty();

			if(data.count) {
				$.each(data.list,function(index,value){
					var li=$('<li><input type="hidden" value="'+value.id+'" /><textarea style="display:none">'+value.content+'</textarea><span>'+value.id+': '+value.title+'</span></li>');

					li.click(function() {
						$('#mms_text').val($(this).find('textarea:first').val());
					});
					li.appendTo('#mms_message_list');
				});

				$(".user_select_pagination").removeData("load");

   		if(Number(data.count)>Number($("#perpage").val()))
   			initPagination(data.count,$("#perpage").val(),current_page);
			} else {
					var li=$('<li><span>no_data</span></li>');
					li.appendTo('#mms_message_list');

				$(".user_select_pagination").removeData("load");

   			initPagination(data.count,$("#perpage").val(),current_page);
			}
			});
		}


	function pageselectCallback(page_index, jq) {
		if ($(jq).data("load") == true)
			getList(page_index, jq);
		else
			$(jq).data("load", true);

		return false;
	}

	function initPagination(num_entries, items_per_page, current_page) {
		if(!current_page)
			var current_page=0;
			$(".user_select_pagination").pagination(num_entries, {
                        current_page : current_page,
                        num_edge_entries : 2,
                        num_display_entries : 8,
                        callback : pageselectCallback,
                        items_per_page : items_per_page
                });
		return false;
	}
});
