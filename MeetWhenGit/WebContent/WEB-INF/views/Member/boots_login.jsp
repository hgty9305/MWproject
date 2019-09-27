<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>Login Demo - Kakao JavaScript SDK</title>
</head>
<body id="page-top">
 <jsp:include page="/Main/boots_menubar.mw"/>

 <DIV id="container">
	<hr/>
	<div class="row">
	    <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
	    <div class="card card-signin my-5">
	    <h5 class="card-title text-center">로그인</h5>
		<form class="login-form" action="boots_loginpro.mw" method="post">
		  <div class="login-wrap">
		    <p class="login-img"><i class="icon_lock_alt"></i></p>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="icon_profile"></i></span>
		      <input type="text" name="m_id" class="form-control" placeholder="ID를입력하세요">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="icon_key_alt"></i></span>
		      <input type="password" name="m_pw" class="form-control" placeholder="Password를입력하세요">
		    </div>
		    <button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
		  </div>
		</form>
		<a href="boots_join.mw">회원가입</a> 
		</div>	
		</div>	
	</div>
	<hr/>  
</DIV>
<jsp:include page="/Main/boots_footer.mw"/>
<c:if test="${loginState eq false}">
	<script>
	 	alert("아이디와 비밀번호가 일치하지않습니다");
	</script>
</c:if>
</body>

</html>
