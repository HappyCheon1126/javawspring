<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrCode.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
    'use strict';
    
    function qrCreate(no) {
    	let mid = '';
    	let email = '';
    	let query = '';
    	let moveUrl = '';
    	
    	if(no == 1) {
    		mid = myform.mid.value;
    		email = myform.email.value;
    		query = {
    				mid : mid,
    				moveFlag : email
    		}
    	}
  		else if(no == 2) {
  			moveUrl = myform.moveUrl.value;
  		  query = {
  				moveFlag : moveUrl
  		  }
  		}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/study/qrCode",
    		data : query,
    		success:function(res) {
    			alert("qr코드가 생성되었습니다. 이름은? " + res);
    			$("#qrCodeView").show();
    			$("#qrView").html(res);
    			let qrImage = '<img src="${ctp}/data/qrCode/'+res+'.png"/>';
    			$("#qrImage").html(qrImage);
    		},
    		error : function() {
    			alert("전송오류!!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform">
	  <h2>QR Code 생성연습</h2>
	  <p>
	    <b>개인정보 입력</b> : <br/>
	    아이디 : <input type="text" name="mid" value="${vo.mid}" class="mb-2"/><br/>
	    이메일 : <input type="text" name="email" value="${vo.email}" class="mb-2"/><br/>
	    <input type="button" value="신상정보QR생성" onclick="qrCreate(1)" class="btn btn-success"/>
	  </p>
	  <hr/>
	  <h4>소개하고싶은 사이트 주소를 입력하세요.</h4>
	  <p>
	    이동할 주소 : <input type="text" name="moveUrl" value="cjsk1126.tistory.com" size="40"/>
	    						<input type="button" value="소개QR생성" onclick="qrCreate(2)" class="btn btn-primary"/>
	  </p>
	  <hr/>
	  <div id="qrCodeView" style="display:none;">
	    <h3>생성된 QR코드 확인하기</h3>
	    <div>
	      - 생성된 qr코드명 : <span id="qrView"></span><br/>
	      <span id="qrImage"></span>
	    </div>
	  </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>