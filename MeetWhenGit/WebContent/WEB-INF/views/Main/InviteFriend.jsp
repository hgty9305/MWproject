<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
	.right{
	float:right
	}
</style>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<body id="page-top">
	<p>${groupId}</p>
	<section class="page-section">
		<div class="container">
			<div class="col-lg-12 text-center">
				<h2 class="section-heading text-uppercase">아이디로 친구 검색</h2>
          		<h3 class="section-subheading text-muted">친구의 아이디를 이용하여, 그룹을 만들어보세요.</h3>
          	</div>
			<div id="searchForm">
        		<form onsubmit="searchajax(); return false;">
            		<input type="text" size="20" id="searchFromAll" name="searchFromAll"/>&nbsp;
            		<button type="submit">검색</button>
        		</form>    
    		</div><br>


			   <c:forEach var="i" items="${flist}" begin="0" end="${flist.size() }" >
			    <div id="smtest">ksm</div>
			   </c:forEach>

     		<div id="searchResult">${i.m_id}</div><br><br>
     		
     		
     		<div class="right">
     		<c:set value="${addresslist}" var="adlist"/>
     	
			
			</div>
		</div>
	</section>
	
<script type="text/javascript">
		var content ="";
		var id = [];
		function searchajax(){
			var words= $("#searchFromAll").val();
			if(words==""){
				alert("키워드를입력해주세요");
			}else{
				$.ajax({
					type : 'POST',
					url : 'searchResult.mw?',
					data : {searchFromAll : words},
					success : function(data){
						$("#searchResult").html(data);
						
					}
				})
			}
		};

</script>
</body>
