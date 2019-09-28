<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head></head>
<body id="page-top">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <jsp:include page="/Main/boots_menubar.mw"/>
    <div id="searchForm">
        <form onsubmit="searchajax(); return false;">
            <input type="text" size="20" id="searchFromAll" name="searchFromAll"/>&nbsp;
            <button type="submit">검색</button>
        </form>    
    </div>
    <%--
    <c:forEach var="i" items="${flist}" begin="0" end="${flist.size() }" >
     <div id="smtest">ksm</div>
    </c:forEach>
 --%>
 	<div id="smtest"></div>


  
<jsp:include page="/Main/boots_footer.mw"/> 
<script>
var content ="";
var id = [];
var flist =[];
	function searchajax(){
		var words= $("#searchFromAll").val();	
			if(words==""){
				alert("키워드를입력해주세요");
			}else{
					$.ajax({
						type : 'POST',
						url : 'Sfri2.mw',
						data : {searchFromAll : words},
						success : function(data){
							$("#smtest").html(data);
						}
					})
				}
			};
</script>
</body>
</html>
