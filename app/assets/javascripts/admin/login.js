//= require jquery
//= require bootstrap/alert

$(document).ready(function() {
	var cookie=getCookie('login_id');

	if(cookie) {
		$("#admin_login_id").val(cookie);
		$("#remember_me").prop('checked',true);
	}

	$("#new_admin").submit(function(){
		var loginID=$.trim($("#admin_login_id").val());
		var password=$.trim($("#admin_password").val());
		var token=$(this).find('input[name="authenticity_token"]').val();

		if(loginID=='') {
			display_message($("#message_no_email").val());
			return false;
		}

		if(password=='') {
			display_message($("#message_no_password").val());
			return false;
		}

		if($("#remember_me").is(":checked")) {
			setCookie('login_id',loginID);
		}
		/*
		//var userPassword=hex_sha1(userPassword);
		$.post($(this).attr('action')+'.json',{'login_id':loginID,'authenticity_token':token,'password':password,'crypt':true,'json':true},function(data){
			if(data.result=='success') {
				if($('input[name="redirect_url"]').length) {
					location.href=$('input[name="redirect_url"]').val();
				} else {
					location.href='/';
				}
			} else {
				display_message(data.message);
			}
		},'json'); */
		//return false;
	});
});

function display_message(message,alert_type) {
	if(!alert_type)
		alert_type='danger';

	console.log('1');
	$("#sl_message").addClass('alert-'+alert_type).show();
	console.log('2');
	$("#sl_message p").empty();
	$("#sl_message p").text(message);
}


/**
 * 쿠키값 추출
 * @param cookieName 쿠키명
 */
function getCookie( cookieName )
{
 var search = cookieName + "=";
 var cookie = document.cookie;

 // 현재 쿠키가 존재할 경우
 if( cookie.length > 0 )
 {
  // 해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴.
  startIndex = cookie.indexOf( cookieName );
  // 만약 존재한다면
  if( startIndex != -1 )
  {
   // 값을 얻어내기 위해 시작 인덱스 조절
   startIndex += cookieName.length;

   // 값을 얻어내기 위해 종료 인덱스 추출
   endIndex = cookie.indexOf( ";", startIndex );

   // 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정
   if( endIndex == -1) endIndex = cookie.length;

   // 쿠키값을 추출하여 리턴
   return cookie.substring( startIndex + 1, endIndex ) ;
  }
  else
  {
   // 쿠키 내에 해당 쿠키가 존재하지 않을 경우
   return false;
  }
 }
 else
 {
  // 쿠키 자체가 없을 경우
  return false;
 }
}


/**
 * 쿠키 설정
 * @param cookieName 쿠키명
 * @param cookieValue 쿠키값
 * @param expireDay 쿠키 유효날짜
 */
function setCookie( cookieName, cookieValue, expireDate )
{
 var today = new Date();
 today.setDate( today.getDate() + parseInt( expireDate ) );
 document.cookie = cookieName + "=" + cookieValue + "; path=/; expires=" + today.toGMTString() + ";";
}


/**
 * 쿠키 삭제
 * @param cookieName 삭제할 쿠키명
*/
function deleteCookie( cookieName )
{
 var expireDate = new Date();

 //어제 날짜를 쿠키 소멸 날짜로 설정한다.
 expireDate.setDate( expireDate.getDate() - 1 );
 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}
