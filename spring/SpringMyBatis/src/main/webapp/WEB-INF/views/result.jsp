<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>결과</h1>

	<div>result: ${result}</div>
	
	<hr>
	
	<div>price: ${price}</div>
	
	<hr>
	
	<div>seq: 	  ${dto.seq}</div>
	<div>item:    ${dto.item}</div>
	<div>price:   ${dto.price}</div>
	<div>regdate: ${dto.regdate}</div>
	
	<hr>
	
	<c:forEach items="${nlist}" var="item">
		<div>${item}</div>
	</c:forEach>
	
	<hr>
	
	<c:forEach items="${list}" var="dto">
		<div>${dto.seq} ${dto.item} ${dto.price} ${dto.regdate}</div>
	</c:forEach>
	
	<hr>
	
	<div>count: ${count}</div>

</body>
</html>




























