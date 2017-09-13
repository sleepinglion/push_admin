$(document).ready(function(){
	$("#user_id_search_form").submit(function(){
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

			var action=$('#user_id_search_form').attr('action');
			var find_method=$('#user_id_search_form select[name="find_method"]').val();
			var search=$('#user_id_search_form input[name="search"]').val();

			$.getJSON(action,{'format':'json','find_method':find_method,'search':search,'per_page':perPage,'page':pageID},function(data) {
				$('#user_id_list').empty();

			if(data.count) {
				$.each(data.list,function(index,value){
					var li_exists=false;
					$('#dest_insert li').each(function(){
						if($(this).find('input:first').val()==value.name+'/'+value.id && $(this).find('input:last').val()==value.phone) {
							li_exists=true;
						}
					});

					if(li_exists) {
						var li=$('<li class="inserted"><input type="hidden" value="'+value.name+'" /><input type="hidden" value="'+value.id+'" /><input type="hidden" value="'+value.phone+'" /><span>'+value.id+':'+value.name+'/'+value.barcode+'</span><span class="user_phone">전화번호:'+value.phone+'</span></li>');
					} else {
						var li=$('<li><input type="hidden" value="'+value.name+'" /><input type="hidden" value="'+value.id+'" /><input type="hidden" value="'+value.phone+'" /><span>'+value.id+':'+value.name+'/'+value.barcode+'</span><span class="user_phone">전화번호:'+value.phone+'</span></li>');
					}

					li.click(function(){
						var name=$(this).find('input:first').val()+'/'+$(this).find('input:eq(1)').val();
						var phone=$(this).find('input:last').val();
						var exists=false;
						var space=false;
						$('#dest_insert li').each(function(){
							if($(this).find('input:first').val()==name && $(this).find('input:last').val()==phone) {
								exists=true;
							}

							if($(this).find('input:first').val()=='' && $(this).find('input:last').val()=='') {
								space=$(this);
							}
						});

						if(exists)
							return false;

						sms_clone_count++;
						var clone_li=$('#dest_insert li:last').clone(true);
						clone_li.find('input:first').val(name).attr('id','sms_desc_name'+sms_clone_count).attr('readonly','readonly');
						clone_li.find('input:last').val(phone).attr('id','sms_desc_phone'+sms_clone_count).attr('readonly','readonly');
						clone_li.find('.delete_li').click(delete_li).show();
						clone_li.appendTo($("#dest_insert ul"));

						if(space) {
							space.remove();
						}

						$(this).addClass('inserted');

					});
					li.appendTo('#user_id_list');
				});

				$(".user_select_pagination").removeData("load");

   			initPagination(data.count,$("#perpage").val(),current_page);
			} else {
					var li=$('<li><span>no_data</span></li>');
					li.appendTo('#user_id_list');

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
