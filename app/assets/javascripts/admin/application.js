// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.

//= require jquery
//= require jquery_ujs
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require bootstrap/alert
//= require plugin/jquery.pagination


var sms_clone_count=1;
var multimedia_clone_count=1;

$(document).ready(function(){
	$('#myModal').on('hidden.bs.modal', function () {
			$(this).removeData('bs.modal');
	});

	$('.modal_link').click(function(event){
		event.preventDefault();
		$('#myModal').removeData("modal");
		$('#myModal').load($(this).attr('href')+'?no_layout=true',function(){
			$('#myModal').modal();
		});
	});

	$('input[name="mms_send"]').change(function(){
		if($(this).val()=='send') {
			$("#multimedia_insert_layer,#message_insert_layer").show();
		} else {
			$("#multimedia_insert_layer,#message_insert_layer").hide();
		}
	})

	$(".btn-maximize").click(function(){
		var i=$(this).find('i:first');
		if(i.hasClass('glyphicon-chevron-down')) {
			i.removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
			$(this).parent().parent().parent().find('.box-content').slideDown();
		} else {
			i.removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
			$(this).parent().parent().parent().find('.box-content').slideUp();
		}
		return false;
	});

	$(".btn-close").click(function(){
		$(this).parent().parent().parent().remove();
		return false;
	});

	$(".btn-minimize").click(function(){
		var i=$(this).find('i:first');
		if(i.hasClass('glyphicon-chevron-down')) {
			i.removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
			$(this).parent().parent().parent().find('.box-content').slideDown();
		} else {
			i.removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
			$(this).parent().parent().parent().find('.box-content').slideUp();
		}
		return false;
	});


	$(".sl_search_form ul li a").click(function(){
		var search_type=$.uri.setUri($(this).attr('href')).param("search_type");
		$('.sl_search_form select[name="search_type"]').val(search_type).change();
		$(".sl_search_form:first button:first").html($(this).text()+' &nbsp; <span class="caret"></span>').parent().removeClass('open');
		$('.sl_search_form input[name="search_value"]').focus();
		return false;
	});

	$(".search_type").change(function(){
		var search_type_text=$('.sl_search_form ul li a:contains("'+$(this).find('option[value="'+$(this).val()+'"]').text()+'")').text();
		$("#sl_search_form:first button:first").html(search_type_text+' &nbsp; <span class="caret"></span>').parent().removeClass('open');
	//	$(".search_type").val($(this).val());
		$(this).parent().parent().find('input[type="search"]:first').focus();
	});

	$("#dest_type input").change(dest_type_change);
	$("#schedule_type input").change(schedule_type_change);
	$("#multimedia_type input").change(multimedia_type_change);
	dest_type_change();
	schedule_type_change();
	multimedia_type_change();

	function dest_type_change() {
		if($('#dest_type input:checked').val()=='all') {
				$("#dest_insert").hide().find('input').removeAttr('required');
		} else {
				$("#dest_insert").show().find('input').attr('required','required');
		}
	}

	function schedule_type_change() {
		if($('#schedule_type input:checked').val()==0) {
				$("#schedule_insert").hide();
		} else {
				$("#schedule_insert").show();
		}
	}

	function multimedia_type_change() {
		if($('#multimedia_type input:checked').val()==0) {
				$("#multimedia_insert").hide()
		} else {
				$("#multimedia_insert").show()
		}
	}

	$("#message_text").keyup(fnChkByte);


	$("#add_dest").click(function(){
		if($('#dest_insert li:last input:first').val()=='') {
			alert('이름을 써주세요');
			return false;
		}

		if($('#dest_insert li:last input:last').val()=='') {
			alert('전화번호를 써주세요');
			return false;
		}

		var clone_li=$(this).parent().find('li:last').clone(true);
		clone_li.find('input').val('');
		clone_li.appendTo($("#dest_insert ul"));

		sms_clone_count++;
		clone_li.find('input:first').attr('id','sms_desc_name'+sms_clone_count).removeAttr('readonly');
		clone_li.find('input:last').attr('id','sms_desc_phone'+sms_clone_count).removeAttr('readonly');

		$("#dest_insert .delete_li").show();
	});

	$(".delete_li").click(delete_li);

	$("#add_multimedia").click(function(){
		if($("#multimedia_insert li").length>2) {
			alert('최대 3개의 파일을 전송할 수 있습니다')
			return false;
		}

		if($('#multimedia_insert li:last input:first').val()=='') {
			alert('파일을 입력해주세요');
			return false;
		}

		var new_li=$('<li><label>이미지<input name="picture_files[]" type="file"></label>&nbsp;&nbsp;</li>');
		new_li.find('input').val('');
		new_li.append($('#dest_insert .delete_li:first').clone(true));
		new_li.appendTo($("#multimedia_insert ul"));

		multimedia_clone_count++;
		new_li.find('input:first').attr('id','mms_multimedia'+multimedia_clone_count);

		$("#multimedia_insert .delete_li").show();
	});
});

function fnChkByte(){
	var obj=document.getElementById('message_text');
	var maxByte=document.getElementById('max_byte').firstChild.nodeValue;
var str = obj.value;
var str_len = str.length;

var rbyte = 0;
var rlen = 0;
var one_char = "";
var str2 = "";

for(var i=0; i<str_len; i++){
one_char = str.charAt(i);
if(escape(one_char).length > 4){
    rbyte += 2;                                         //한글2Byte
}else{
    rbyte++;                                            //영문 등 나머지 1Byte
}

if(rbyte <= maxByte){
    rlen = i+1;                                          //return할 문자열 갯수
}
}

if(rbyte > maxByte){
    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.\n장문은 장문문자메세지(MMS)에서 보내세요");
    str2 = str.substr(0,rlen);                                  //문자열 자르기
    obj.value = str2;
    fnChkByte(obj, maxByte);
}else{
    document.getElementById('byteInfo').innerText = rbyte;
}
}

function delete_li() {
	var ul=$(this).parent().parent();
	$(this).parent().remove();
	if(ul.find("li").length<2) {
		ul.find(".delete_li").hide();
	}
}

function setDateInput(obj) {
  if (obj != undefined) {
   var datediff = -(parseInt(obj));
   var newDate = new Date();
   var now = new Date();
   newDate.setDate(now.getDate()+datediff);
   var newYear = newDate.getFullYear();
   var newMonth = newDate.getMonth()+1;
   if (newMonth.toString().length == 1) newMonth = "0" + newMonth;

   endMonth=now.getMonth() +1;
   if (endMonth.toString().length == 1) endMonth = "0" + endMonth;

   var newDay = newDate.getDate();
   if (newDay.toString().length == 1) newDay = "0" + newDay;
   var txtSDate = newMonth + "/" + newDay +'/'+newYear;
   endDay=now.getDate();
   if (endDay.length == 1) endDay = "0" + endDay;
   var txtEDate = endMonth + "/" + endDay + '/' + now.getFullYear();
   $('input[name="start_date"]').val(txtSDate);
   $('input[name="end_date"]').val(txtEDate);
  } else {alert("잠시 후 이용해 주시기 바랍니다."); return false;}
 }
