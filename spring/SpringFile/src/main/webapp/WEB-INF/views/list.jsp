<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/spring/resources/css/bootstrap.css">
<script src="/spring/resources/js/jquery-1.12.4.js"></script>
<style>
	main {
		width: 800px;
		margin: 0 auto;
	}
</style>
<script src="https://kit.fontawesome.com/7121714adf.js" crossorigin="anonymous"></script>
</head>
<body>

	<main>
		<h1>List</h1>
		
		<table class="table table-bordered">
			<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.seq}</td>
				<td>${dto.title}</td>
				<td>
					
					<c:forEach items="${dto.files}" var="fdto">
					<div>
						<c:choose>
							<c:when test="${fdto.mimetype == 'image/jpeg'}"><i class="fa-solid fa-file-image"></i></c:when>
							<c:when test="${fdto.mimetype == 'image/gif'}"><i class="fa-solid fa-file-image"></i></c:when>
							<c:when test="${fdto.mimetype == 'image/png'}"><i class="fa-solid fa-file-image"></i></c:when>
							<c:when test="${fdto.mimetype == 'text/plain'}"><i class="fa-solid fa-file-lines"></i></c:when>
							<c:when test="${fdto.mimetype == 'application/x-zip-compressed'}"><i class="fa-solid fa-file-zipper"></i></c:when>
						</c:choose>
						
						<span>${fdto.filename}</span>
						
						<span>${fdto.filesize}</span>
					</div>
					</c:forEach>
					
					<c:if test="${dto.files.size() == 0}">
						파일 없음
					</c:if>
				
				</td>
			</tr>
			</c:forEach>
		</table>
		
		<div>
			<input type="button" value="쓰기" class="btn btn-primary"
				onclick="location.href='/spring/write';">
		</div>
		
	</main>

	<script>
	
	</script>
</body>
</html>
















