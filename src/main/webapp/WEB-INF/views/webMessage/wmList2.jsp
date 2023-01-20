<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
    setTimeout("location.reload()", 1000*10);
    
    // 보낸 메세지함에서는 삭제처리만 할 수 있게 했다.
    function msgDel(idx) {
    	let ans = confirm("선택된 메세지를 삭제하시겠습니까?");
    	if(!ans) return false;
    	let query = {
    			idx   : idx,
    			mFlag : '${mSw}'
    	}
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/webMessage/wmDelete",
    		data  : query,
    		success:function() {
    			alert("메세지가 삭제되었습니다.");
    			location.reload();
    		}
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸사람</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
      </th>
      <th>제목</th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸/확인(날짜)</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은날짜</c:if>
      </th>
    </tr>
<!-- 
  mSw   => 1:받은메세지, 2:새메세지, 3:보낸메세지, 4:수진확인, 5:휴지통, 6:메세지상세보기 0:메세지작성
  mFlag => 1:받은메세지, 2:새메세지, 3:보낸메세지, 5:휴지통
-->
		<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}">
		  <tr>
		    <td>${curScrStartNo}</td>
		    <td>
		    	<c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
        	<c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
		    </td>
		    <td>
		      <a href="webMessage?mSw=6&mFlag=${param.mSw}&idx=${vo.idx}&receiveSw=${vo.receiveSw}">
		      	${vo.title}
		      </a>
		      <c:if test="${vo.receiveSw=='n'}"><img src="${ctp}/images/new.gif"/></c:if>
		      <c:if test="${mSw == 3 || mSw == 5}">
		        <a href="javascript:msgDel(${vo.idx})" class="badge badge-danger">삭제</a>
		      </c:if>
		    </td>
		    <td>
		      <span style="font-size:0.8em">${fn:substring(vo.receiveDate,0,19)}</span>
		    </td>
		  </tr>
		  <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		</c:forEach> 
		<tr><td colspan="4" class="m-0 p-0"></td></tr>   
  </table>
</div>
<p></p>
</body>
</html>