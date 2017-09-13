$(document).ready(function(){
	$("#mms_picture_id_search_form").submit(function(){
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

			var action=$('#mms_picture_id_search_form').attr('action');
			var find_method=$('#mms_picture_id_search_form select[name="find_method"]').val();
			var search=$('#mms_picture_id_search_form input[name="search"]').val();

			$.getJSON(action,{'format':'json','find_method':find_method,'search':search,'per_page':perPage,'page':pageID},function(data) {
				$('#mms_picture_id_list').empty();

			if(data.count) {
				$.each(data.list,function(index,value){
					var li_exists=false;
					$('#multimedia_insert li').each(function(){
						if($(this).find('input:first').val()==value.name+'/'+value.id && $(this).find('input:last').val()==value.phone) {
							li_exists=true;
						}
					});

					if(li_exists) {
						var li=$('<li class="inserted"><input type="hidden" value="'+value.id+'" /><span>'+value.id+': <img src="'+value.photo.small_thumb.url+'" /></span></li>');
					} else {
						var li=$('<li><input type="hidden" value="'+value.id+'" /><span>'+value.id+': <img src="'+value.photo.small_thumb.url+'" /></span></li>');
					}

					li.click(function() {
						var mms_picture_id=$(this).find('input:first').val();

						var exists=false;
						var space=false;

						$('#multimedia_insert li').each(function() {
							if($(this).find('input:first').val()==mms_picture_id) {
								exists=true;
							}

							if($(this).find('input:first').val()=='') {
								space=$(this);
							}
						});

						if(exists)
							return false;

						li_length=$('#multimedia_insert li').length;
						if(space)
							li_length-1;

						if(li_length>2) {
							alert('최대 3개를 입력할 수 있습니다.');
							return false;
						}

						multimedia_clone_count++;
						var new_li=$('<li class="mms_picture_id"><input type="hidden" name="picture_ids[]" /><img src="'+$(this).find('img:first').attr('src')+'" /><button type="button" class="delete_li btn btn-danger" style="display:none">삭제</button></li>');
						new_li.find('input:first').val($(this).find('input:first').val()).attr('id','mms_picture'+multimedia_clone_count);
						new_li.find('.delete_li').click(delete_li).show();
						new_li.appendTo($("#multimedia_insert ul"));

						if(space) {
							space.remove();
						}

						$(this).addClass('inserted');

					});
					li.appendTo('#mms_picture_id_list');
				});

				$(".user_select_pagination").removeData("load");

   		if(Number(data.count)>Number($("#perpage").val()))
   			initPagination(data.count,$("#perpage").val(),current_page);
			} else {
					var li=$('<li><span>no_data</span></li>');
					li.appendTo('#mms_picture_id_list');

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
