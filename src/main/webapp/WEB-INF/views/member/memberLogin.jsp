<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>		<!-- 카카오로그인 js파일 -->
  
  <!-- 아래는 구글 로그인을 위한 코드(3줄) -->
  <!-- 
  <meta name="google-signin-scope" content="profile email">
  <meta name="google-signin-client_id" content="1007457813868-2orhbm2mlgbfhga5c22gcv9fq8m8oi46.apps.googleusercontent.com">
  <script src="https://apis.google.com/js/platform.js" async defer></script>
   -->
  <script src="https://accounts.google.com/gsi/client" async defer></script>		<!-- 구글 로그인 js파일 -->
  
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>		<!-- 네이버로그인 js파일 -->
  
	<script>
  	//'use strict';
  	
  	// 카카로그인을 위한 자바스크립트 키
  	window.Kakao.init("158c673636c9a17a27b67c95f2c6be5c");
  
    // 카카오 로그인
  	function kakaoLogin() {
  		window.Kakao.Auth.login({
  			scope: 'profile_nickname, account_email',
  			success:function(autoObj) {
  				console.log(Kakao.Auth.getAccessToken(),"로그인 OK");
  				console.log(autoObj);
  				window.Kakao.API.request({
  					url : '/v2/user/me',
  					success:function(res) {
  						const kakao_account = res.kakao_account;
  						console.log(kakao_account);
  						//alert(kakao_account.email + " / " + kakao_account.profile.nickname);
  						location.href="${ctp}/member/memberKakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email;
  					}
  				});
  			}
  		});
  	}
  	
  	// 카카오 로그아웃
  	function kakaoLogout(kakaoKey) {
  		// 다음에 로그인시에 동의항목 체크하고 로그인할 수 있도록 로그아웃시키기
  		/*
			Kakao.API.request({
	      url: '/v1/user/unlink',
	    })
	    */
  		Kakao.Auth.logout(function() {
  			console.log(Kakao.Auth.getAccessToken(), "토큰 정보가 없습니다.(로그아웃되셨습니다.)");
  		});
  	}
  	
  	// 구글 로그인
  	function googleOnSignIn(googleUser) {
	    // decodeJwtResponse() is a custom function defined by you
	    // to decode the credential response.
	    const googleUserPayload = parseJwt(googleUser.credential);

	    console.log("ID: " + googleUserPayload.sub);
	    console.log('Full Name: ' + googleUserPayload.name);
	    console.log('Given Name: ' + googleUserPayload.given_name);
	    console.log('Family Name: ' + googleUserPayload.family_name);
	    console.log("Email: " + googleUserPayload.email); 
	    console.log("Image URL: " + googleUserPayload.picture);
  	    
  	  location.href="${ctp}/member/memberGoogleLogin?nickName="+googleUserPayload.given_name+"&email="+googleUserPayload.email;
  	};
  	function parseJwt(token) {
  	    var base64Url = token.split('.')[1];
  	    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
  	    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
  	        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
  	    }).join(''));

  	    return JSON.parse(jsonPayload);
  	};
  	
  	// 구글 로그아웃
  	/* 
  	function signOut() {
  		gapi.auth2.getAuthInstance().disconnect();
  	}
		*/
  	// 구글 로그아웃2
  	/* 
	  function signOut() {
	    var auth2 = gapi.auth2.getAuthInstance();
	    auth2.signOut().then(function () {
	      console.log('User signed out.');
	    });
	  }
  	 */
  	/*
    const button = document.getElementById('signout_button');
    button.onclick = () => {
      google.accounts.id.disableAutoSelect();
    }
    */
    
	  function signOut() {
	    google.accounts.id.disableAutoSelect();
	    alert("로그아웃 되었습니다.");
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="container" style="padding:30px">
			  <form name="myform" method="post" class="was-validated">
			    <h2>회원 로그인</h2>
			    <p>회원 아이디와 비밀번호를 입력해 주세요</p>
			    <div class="form-group">
			      <label for="mid">회원 아이디 :</label>
			      <input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요." required autofocus />
			      <div class="valid-feedback">입력성공!!</div>
			      <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다.</div>
			    </div>
			    <div class="form-group">
			      <label for="pwd">비밀번호 :</label>
			      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required />
			      <div class="invalid-feedback">회원 비밀번호는 필수 입력사항입니다.</div>
			    </div>
			    <div class="form-group">
				    <button type="submit" class="btn btn-primary">로그인</button>
				    <button type="reset" class="btn btn-primary">다시입력</button>
				    <button type="button" onclick="location.href='${ctp}/';" class="btn btn-primary">돌아가기</button>
				    <button type="button" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary">회원가입</button>
			    </div>
			    <div class="ml-1 mb-2 row">
			      <div><a href="javascript:kakaoLogin();"><img src="${ctp}/images/kakao_login_medium_narrow.png" /></a></div>			      
				    <!-- <a href="javascript:kakaoLogout();" class="btn btn-danger">로그아웃</a> -->
				  </div>			      
			    <div class="ml-1 mb-3 row">
		        <span id="g_id_onload"
					     data-client_id="1007457813868-2orhbm2mlgbfhga5c22gcv9fq8m8oi46.apps.googleusercontent.com"
					     data-callback="googleOnSignIn">
					  </span>
					  <span class="g_id_signin" data-type="standard" data-text="signin_with" data-shape="rectangular" ></span>
				    <!-- <span><a href="javascript:signOut();" class="btn btn-danger">로그아웃</a></span> -->
				    &nbsp;&nbsp;
				    <!-- 네이버로그인 -->
						<!-- 네이버 로그인 버튼 노출 영역 -->
						<div id="naver_id_login"></div>
			    </div>
			    <div class="row" style="font-size:12px">
			      <span class="col"><input type="checkbox" name="idCheck" checked /> 아이디 저장</span>
			      <span class="col">
			        [<a href="${ctp}/member/memberIdSearch">아이디찾기</a>] /
			        [<a href="${ctp}/member/memberPwdSearch">비밀번호찾기</a>]
			      </span>
			    </div>
			  </form>
		  </div>
		</div>
	</div>
</div>
<p><br/></p>
<!-- 네이버 로그인 버튼 노출 영역 -->
<script type="text/javascript">
	var naver_id_login = new naver_id_login("xW0p5VrP1n8uMwTEuZtY", "http://localhost:9090/javawspring/member/memberLoginNew");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain("http://localhost:9090/javawspring/member/memberLoginNew");
	naver_id_login.setState(state);
	naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
</script>
<script type="text/javascript">
	/*
	//var naver_id_login = new naver_id_login("xW0p5VrP1n8uMwTEuZtY", "http://localhost:9090/javawspring/member/memberLogin");
  // 접근 토큰 값 출력
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  
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
	 	alert("1.로그인 성공!");
	 	
	 	$.ajax({
	 		type : "get",
	 		url  : "${ctp}/member/naverLoginCertification",
	 		async: false,
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
				setTimeout(() => {
			  	window.close();		  
			  }, 300);
			 	opener.location.href = "${ctp}/member/memberLogin";
	 		},
	 		error : function() {
	 			alert("전송오류!");
	 		}
	 	});
	  // 콜백으로 돌아온후 현재 출력된 새창을 닫고 정보를 서버로 정송할 수 있게 처리한다.
	  
		//location.href = "${ctp}/member/memberNaverLogin";
	 	//myform.submit();
  }
  */
</script>
<script>
  /*
	if('${sLogin}' != "") {
		alert("sLogin : " + sLogin);
		if('${sLogin}' == 'naver') {
	 		myform.action = "${ctp}/member/memberNaverLogin";
		}
		myform.submit();
	}
  */
</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>