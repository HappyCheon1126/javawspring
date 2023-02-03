<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<html>
<head>
  <title>dbCartList.jsp(장바구니)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    'use strict';
    
    function onTotal(){
      let total = 0;
      let maxIdx = document.getElementById("maxIdx").value;
      for(let i=1;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=2500;
      }
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);
    }

		// 상품 체크박스에 체크했을때 처리하는 함수
    function onCheck(){
      let maxIdx = document.getElementById("maxIdx").value;				// 출력되어있는 상품중에서 가장 큰 idx값이 maxIdx변수에 저장된다.

      let cnt=0;
      for(let i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          cnt++;
          break;
        }
      }
      if(cnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// allCheck 체크박스를 체크/해제할때 수행하는 함수
    function allCheck(){
      let maxIdx = document.getElementById("maxIdx").value;
      if(document.getElementById("allcheck").checked){
        for(let i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(let i=1;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// 장바구니에서 구매한 상품에 대한 '삭제'처리...
    function cartDelete(idx){
      let ans = confirm("선택하신 현재상품을 장바구니에서 제거 하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/dbShop/dbCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }
    
		// 장바구니에서 선택한 상품만 '주문'처리하기
    function order(){
      let maxIdx = document.getElementById("maxIdx").value;
      for(let i=1;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){
          document.getElementById("checkItem"+i).value="1";
        }
      }

      document.myform.baesong.value=document.getElementById("baesong").value;
      
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 주문처리할 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myform.submit();
      }
    }
    
		// 천단위마다 쉼표처리
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  </script>
  
  <style>
    .totSubBox {
      background-color:#ddd;
      border : none;
      width : 95px;
      text-align : center;
      font-weight: bold;
      padding : 5 0px;
      color : brown;
    }
    td { padding : 5px; }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">장바구니</h2>
	<br/>
	<form name="myform" method="post">
		<table class="table-bordered text-center" style="margin: auto; width:90%">
		  <tr class="table-dark text-dark">
		    <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
		    <th colspan="2">상품</th>
		    <th colspan="2">총상품금액</th>
		  </tr>
		    
		  <!-- 장바구니 목록출력 -->
		  <c:set var="maxIdx" value="0"/>
		  <c:forEach var="listVo" items="${cartListVos}">
		    <tr align="center">
		      <td><input type="checkbox" name="idxChecked" id="idx${listVo.idx}" value="${listVo.idx}" onClick="onCheck()" /></td>
		      <td><a href="${ctp}/dbShop/dbShopContent?idx=${listVo.productIdx}"><img src="${ctp}/dbShop/product/${listVo.thumbImg}" width="150px"/></a></td>
		      <td align="left">
		        <p class="contFont"><br/>
		          모델명 : <span style="color:orange;font-weight:bold;"><a href="${ctp}/dbShop/dbShopContent?idx=${listVo.productIdx}">${listVo.productName}</a></span><br/>
		          <span class="container pl-5 ml-4"><b><fmt:formatNumber value="${listVo.mainPrice}"/>원</b></span>
		        </p><br/>
		        <c:set var="optionNames" value="${fn:split(listVo.optionName,',')}"/>
		        <c:set var="optionPrices" value="${fn:split(listVo.optionPrice,',')}"/>
		        <c:set var="optionNums" value="${fn:split(listVo.optionNum,',')}"/>
		        <p style="font-size:12px">
		          - 주문 내역
		          <c:if test="${fn:length(optionNames) > 1}">(기타품목 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
		          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
		            &nbsp;&nbsp;ㆍ${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>원 / ${optionNums[i]}개<br/>
		          </c:forEach> 
		        </p>
		      </td>
		      <td>
		        <div class="text-center">
			        <b>총 : <fmt:formatNumber value="${listVo.totalPrice}" pattern='#,###원'/></b><br/><br/>
			        <span style="color:#270;font-size:12px" class="buyFont">주문일자 : ${fn:substring(listVo.cartDate,0,10)}</span>
			        <input type="hidden" id="totalPrice${listVo.idx}" value="${listVo.totalPrice}"/>
		        </div>
		      </td>
		      <td>
		        <button type="button" onClick="cartDelete(${listVo.idx})" class="btn btn-danger btn-sm m-1" style="border:0px;">구매취소</button>
		        <input type="hidden" name="checkItem" value="0" id="checkItem${listVo.idx}"/>	<!-- 구매체크가 되지 않은 품목은 '0'으로 체크된것은 '1'로 처리하고자 한다. -->
		        <input type="hidden" name="idx" value="${listVo.idx }"/>
		        <input type="hidden" name="thumbImg" value="${listVo.thumbImg}"/>
		        <input type="hidden" name="productName" value="${listVo.productName}"/>
		        <input type="hidden" name="mainPrice" value="${listVo.mainPrice}"/>
		        <input type="hidden" name="optionName" value="${optionNames}"/>
		        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
		        <input type="hidden" name="optionNum" value="${optionNums}"/>
		        <input type="hidden" name="totalPrice" value="${listVo.totalPrice}"/>
		        <input type="hidden" name="mid" value="${sMid}"/>
		      </td>
		    </tr>
		    <c:set var="maxIdx" value="${listVo.idx}"/>	<!-- 가장 마지막 품목의 idx값이 가장 크다. -->
		  </c:forEach>
		</table>
	  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
	  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
    <input type="hidden" name="baesong"/>
	</form>
  <p class="text-center">
    <b>실제 주문총금액</b>(구매하실 상품에 체크해 주세요. 총주문금액이 산출됩니다.)<br/>
    5만원 이상 구매하시면 배송비가 면제됩니다.
  </p>
	<table class="table-borderless text-center" style="margin:auto">
	  <tr>
	    <th>구매상품금액</th>
	    <th></th>
	    <th>배송비</th>
	    <th></th>
	    <th>총주문금액</th>
	  </tr>
	  <tr>
	    <td><input type="text" id="total" value="0" class="totSubBox" readonly/></td>
	    <td>+</td>
	    <td><input type="text" id="baesong" value="0" class="totSubBox" readonly/></td>
	    <td>=</td>
	    <td><input type="text" id="lastPrice" value="0" class="totSubBox" readonly/></td>
	  </tr>
	</table>
	<br/>
	<div class="text-center">
	  <button class="btn btn-primary" onClick="order()">주문하기</button> &nbsp;
	  <button class="btn btn-info" onClick="location.href='${ctp}/dbShop/dbProductList';">계속 쇼핑하기</button>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>