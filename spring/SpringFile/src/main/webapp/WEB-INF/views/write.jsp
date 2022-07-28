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
	
	#attach {
		height: 150px;
		overflow: auto;
	}
	
	#attach .item {
		display: flex;
		justify-content: space-between;
	}
	
	#attachlist {
		display: none;
	}
	
	table th {
		width: 150px;
	}
	
</style>
</head>
<body>

	<main>
		<h1>Write</h1>
		
		<form method="POST" action="/spring/writeok" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" class="form-control"></td>
				</tr>
				<tr>
					<th>파일</th>
					<td><div id="attach" class="form-control"></div></td>
				</tr>
			</table>
			
			<div>
				<input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="location.href='/spring/list';">
				<input type="submit" value="쓰기" class="btn btn-primary">
			</div>
			
			<input type="file" id="attachlist" name="attachlist">
		</form>
		
	</main>

	<script>
	
		//첨부 파일 배열
		let fileList = [];
		
		$("#attach")
			.on("dragenter", function(e) {
				e.preventDefault();
				e.stopPropagation();
			})
			.on("dragover", function(e) {
				e.preventDefault();
				e.stopPropagation();
				$(this).css("background-color", "gold");
			})
			.on("dragleave", function(e) {
				e.preventDefault();
				e.stopPropagation();
				$(this).css("background-color", "white");
			})
			.on("drop", function(e) {
				
				e.preventDefault();
				
				let files = e.originalEvent.dataTransfer.files;
				
				//console.log(files);
				
				if (files != null & files != undefined) {
					
					let temp = '';
					
					for (let i=0; i<files.length; i++) {
						
						let f = files[i];
						
						fileList.push(f);
						
						let filename = f.name;
						let filesize = f.size / 1024 / 1024;
						filesize = filesize < 1 ? filesize.toFixed(2) : filesize.toFixed(1);
						
						
						temp += `<div class='item'>
									<span>\${filename}</span>
									<span>\${filesize}MB</span>
								 </div>`;
						
					}
					
					$(this).append(temp);
				}
				
				$(this).css("background-color", "white");

				$("#attachlist").prop("files", files);
				
			});
	
	</script>
</body>
</html>




















