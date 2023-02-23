<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Google/Naver 로그아웃창</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
    /* 
    setTimeout(() => {
    	window.close();		  
	  }, 500);
     */
    //location.href = "${ctp}/member/memberLogin";
    //alert('현재 로그인 된 곳 : ${sLogin}');
    if('${sLogin}' == 'naver') {
    	location.href = "http://nid.naver.com/nidlogin.logout";
    }
    else if('${sLogin}' == 'google') {
      //alert('현재 로그인 된 곳 : ${sLogin}');
    	location.href = "https://accounts.google.com/logout";
    }
  </script>
</head>
<body>

</body>
</html>