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
  		  query = {moveFlag : moveUrl}
  		}
  		else if(no == 3) {
  			let movieName = myform.movieName.value;
  			let movieDate = myform.movieDate.value;
  			let movieTime = myform.movieTime.value;
  			if(movieName == "" || movieDate == "" || movieTime == "") {
  				alert("영화명과 상영일자와 상영시간을 모두 선택하셔야 합니다.");
  				return false;
  			}
  			moveUrl = movieName + "_";
  			moveUrl += movieDate + "_";
  			moveUrl += movieTime + "_A";
  			moveUrl += myform.movieAdult.value + "_C";
  			moveUrl += myform.movieChild.value;
  			query = {moveFlag : moveUrl}
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
    
    // 입력된 정보를 DB에 담아준다.
    function qrCreateDB() {
    	let mid = myform.mid.value;
    	let email = myform.email.value;
    	let movieName = myform.movieName.value;
			let movieDate = myform.movieDate.value;
			let movieTime = myform.movieTime.value;
			if(mid.trim() == "" || email.trim() == "" || movieName == "" || movieDate == "" || movieTime == "") {
				alert("아이디/이메일주소 입력 및 영화명과 상영일자와 상영시간을 모두 선택하셔야 합니다.");
				return false;
			}
    	let moveUrl = "아이디 : " + mid + " , ";
    	moveUrl += "이메일 : " + email + " , ";
  		moveUrl += "영화제목 : " + movieName + " , ";
  		moveUrl += "상영일자 : " + movieDate + " , ";
  		moveUrl += "상영시작시간 : " + movieTime + " , ";
  		moveUrl += "성인 : " + myform.movieAdult.value + "매 , ";
  		moveUrl += "어린이 : " + myform.movieChild.value + "매";
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/study/qrCode2",
    		data : {moveFlag : moveUrl},
    		success:function(res) {
    			alert("qr코드가 생성되었습니다. 이름은? " + res);
    			$("#qrCodeView").show();
    			$("#qrView").html(res);
    			let qrImage = '<img src="${ctp}/data/qrCode/'+res+'.png"/>';
    			$("#qrImage").html(qrImage);
    			

    			let idx = res.substring(res.length - 8);
    			$("#bigo").val(idx);
    		},
    		error : function() {
    			alert("전송오류!!");
    		}
    	});
    }
    
    // 검색버튼 클릭시 DB에 담아있는 내용을 vo로 담아와서 뿌려준다.
    function bigoCheck() {
    	let idx = myform.bigo.value;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/study/qrCodeSearch",
    		data : {idx : idx},
    		success:function(vo) {
    			let bigoArr = vo.bigo.split(",");
    			let str = '';
    			for(let i=0; i<bigoArr.length; i++) {
    				str += bigoArr[i] + '<br/>';
    			}
    			
    			$("#demoBigo").html(str);
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
	    <b>1.개인정보 입력</b> : <br/>
	    아이디 : <input type="text" name="mid" value="${vo.mid}" class="mb-2"/><br/>
	    이메일 : <input type="text" name="email" value="${vo.email}" class="mb-2"/><br/>
	    <input type="button" value="신상정보QR생성" onclick="qrCreate(1)" class="btn btn-success"/>
	  </p>
	  <hr/>
	  <h4>소개하고싶은 사이트 주소를 입력하세요.</h4>
	  <p>
	    2.이동할 주소 : <input type="text" name="moveUrl" value="cjsk1126.tistory.com" size="40"/>
	    						<input type="button" value="소개QR생성" onclick="qrCreate(2)" class="btn btn-primary"/>
	  </p>
	  <hr/>
	  <div>
	    3.티켓예매 : 생성된 QR코드를 메일로 보내드립니다.<br/>
      QR코드를 영화관 입장시 매표소에 제시해주세요.(아래사항은 관리자가 DB에 저장시키고 aJax로 불러온다.)<br/>
      <table class="table table-borderess">
        <tr>
          <td>
			      <select name="movieName" class="form-control">
			      	<option value="">영화선택</option>
			      	<option value="교섭">교섭</option>
			      	<option value="유령">유령</option>
			      	<option value="아바타2">아바타2</option>
			      	<option value="영웅">영웅</option>
			      	<option value="더 퍼스트 슬램덩크">더 퍼스트 슬램덩크</option>
			      </select>
	        </td>
	        <td>
			      <select name="movieDate" class="form-control">
			      	<option value="">상영일자선택</option>
			      	<option value="2023-01-17">2023-01-17</option>
			      	<option value="2023-01-17">2023-01-17</option>
			      	<option value="2023-01-17">2023-01-18</option>
			      	<option value="2023-01-17">2023-01-19</option>
			      </select>
	        </td>
	        <td>
			      <select name="movieTime" class="form-control">
			      	<option value="">상영시간선택</option>
			      	<option value="16시00분">16시00분</option>
			      	<option value="18시30분">18시30분</option>
			      	<option value="21시00분">21시00분</option>
			      	<option value="23시30분">23시30분</option>
			      </select>
	        </td>
        </tr>
	      <tr>
	        <td class="text-center">인원수</td>
	        <td>성인 <input type="number" name="movieAdult" value="1" class="form-control" /></td>
	      	<td>어린이 <input type="number" name="movieChild" value="0" class="form-control" /></td>
	      </tr>
	      <tr>
	        <td colspan="3" class="text-center">
	          <div class="row">
	          	<div class="col"><input type="button" value="티켓예매" onclick="qrCreate(3)" class="btn btn-success form-control"/></div>
	            <div class="col"><input type="button" value="티켓예매(DB)" onclick="qrCreateDB()" class="btn btn-info form-control"/></div>
	            <div class="col"><input type="reset" value="다시선택" class="btn btn-warning form-control"/></div>
	          </div>
	        </td>
	      </tr>
	    </table>
    </div>
	  <hr/>
	  <div id="qrCodeView" style="display:none;">
	    <h3>생성된 QR코드 확인하기</h3>
	    <div>
	      - 생성된 qr코드명 : <span id="qrView"></span><br/>
	      <span id="qrImage"></span>
	    </div>
	    <hr/>
		  <div>
		    - 앞에서 생성된 QR코드를 찍어보고 아래 검색버튼을 눌러서 출력자료와 비교해 봅니다.<br/>
		    <input type="text" name="bigo" id="bigo" />
		    <input type="button" value="검색" onclick="bigoCheck()" class="btn btn-success"/>
		  </div>
		  <div id="demoBigo"></div>
	  </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>