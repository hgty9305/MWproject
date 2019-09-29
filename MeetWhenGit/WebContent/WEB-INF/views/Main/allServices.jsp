<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>main</title>
</head>
<style>
.top-container{
  display: inline;
  padding: 10px;
 }
</style>
<body id="page-top" onload="fetchPage('allServicesA.mw')">
	<jsp:include page="boots_menubar.jsp" />
	
	<div class="top-container">
		<span><button type="button" class="btn btn btn-dark"
		onclick="fetchPage('allServicesA.mw')">주제별</button></span>
		<span><button type="button" class="btn btn btn-dark"
		onclick="fetchPage('allServicesB.mw')">가나다순</button></span>
	</div>
	<div id="AllContents"></div>
	<script>
		function fetchPage(name) {
			fetch(name).then(function(response) {
				response.text().then(function(text) {
					document.querySelector('#AllContents').innerHTML = text;
				})
			});
		}
	</script>
	<jsp:include page="boots_footer.jsp" />
</body>

</html>
