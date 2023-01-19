<%-- kakaoMenu.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<div>
  <p>
    <a href="${ctp}/study/kakaomap/kakaoEx1" class="btn btn-success" title="클릭한위치한 위치를 마커표시하고 내DB에 저장하기">마커표시/DB저장</a>&nbsp;
    <a href="${ctp}/study/kakaomap/kakaoEx2" class="btn btn-primary">DB에저장된지명검색/삭제</a>&nbsp;
    <a href="${ctp}/study/kakaomap/kakaoEx3" class="btn btn-warning" title="카카오DB의 자료검색후 내DB에 저장한다.">지역검색후DB에저장</a>&nbsp;
    <a href="${ctp}/study/kakaomap/kakaoEx4" class="btn btn-info" title="내DB의 자료로 지역검색후, 그 주변검색처리">특정지역의주변검색</a>&nbsp;
    <a href="${ctp}/study/kakaomap/kakaoEx5" class="btn btn-danger" title="특정지역을 기준으로 거리계산하기">거리 계산 해보기</a>&nbsp;
  </p>
</div>