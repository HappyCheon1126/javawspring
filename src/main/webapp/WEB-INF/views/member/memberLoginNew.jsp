<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>		<!-- 네이버로그인 js파일 -->

<script>
	var naver_id_login = new naver_id_login("xW0p5VrP1n8uMwTEuZtY", "http://localhost:9090/javawspring/member/memberLogin");
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	function naverSignInCallback() {
		  //var mid = naver_id_login.getProfileData('id');
		  var name = naver_id_login.getProfileData('name');
		  var email = naver_id_login.getProfileData('email');
		  var nickName = naver_id_login.getProfileData('nickname');
		  var age = naver_id_login.getProfileData('age');
		  var gender = naver_id_login.getProfileData('gender');
		  var birthday = naver_id_login.getProfileData('birthday');
		  var birthyear = naver_id_login.getProfileData('birthyear');
		  var tel = naver_id_login.getProfileData('mobile');
		  var profile_image = naver_id_login.getProfileData('profile_image');
		  
		 	console.log("고유번호",naver_id_login.getProfileData('id'))
		 	console.log("성명",naver_id_login.getProfileData('name'))
	  	console.log("이메일",naver_id_login.getProfileData('email'));
		 	console.log("별명",naver_id_login.getProfileData('nickname'));
		 	console.log("연령대",naver_id_login.getProfileData('age'));
		 	console.log("성별",naver_id_login.getProfileData('gender'));
		 	console.log("생년월일",naver_id_login.getProfileData('birthday'));
		 	console.log("출생연도",naver_id_login.getProfileData('birthyear'));
		 	console.log("전화번호",naver_id_login.getProfileData('mobile'));
		 	console.log("사진",naver_id_login.getProfileData('profile_image'));
		 	/*
		 	$.ajax({
		 		type : "get",
		 		url  : "${ctp}/member/naverLoginCertification",
		 		//async: false,
		 		data : {
		 			//mid : mid,
		 			name : name,
		 			email : email,
		 			nickName : nickName,
		 			age : age,
		 			gender : gender,
		 			birthday : birthday,
		 			birthyear : birthyear,
		 			tel : tel,
		 			profile_image : profile_image
		 		},
		 		success:function() {
				 	alert("2.로그인 성공!" + '${sLogin}' + '!');
				 	//opener.location.reload();
				 	opener.location.href = "${ctp}/member/memberNaverLogin";
					setTimeout(() => {
				  	window.close();		  
				  }, 300);
		 		},
		 		error : function() {
		 			alert("전송오류!");
		 		}
		 	});
		  // 콜백으로 돌아온후 현재 출력된 새창을 닫고 정보를 서버로 정송할 수 있게 처리한다.
		  
			//location.href = "${ctp}/member/memberNaverLogin";
		 	//myform.submit();
		 	*/
		 	var mid = email.split("@")[0];
		 	setTimeout(() => {
		  	window.close();		  
		  }, 300);
		 	opener.location.href = "${ctp}/member/memberNaverLogin?mid="+mid+"&email="+email+"&nickName="+nickName+"&name="+name;
	}
</script>