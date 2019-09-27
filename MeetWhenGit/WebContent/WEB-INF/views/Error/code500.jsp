<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body, html {
	height: 100%;
	margin: 0;
}

.bg {
	/* The image used */
	background-image: url("/MeetWhenGit/img/error/code500.gif");
	/* Full height */
	height: 100%;
	/* Center and scale the image nicely */
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</head>
<body>
	<%
	response.setStatus(HttpServletResponse.SC_OK);
%>

	<div class="bg"></div>

</body>
</html>