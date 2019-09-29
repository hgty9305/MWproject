<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Boot Footer</title>
<style>
a{
	color:black;
}
</style>
<script>
function noAccess(){
	alert("관리자만 접근 가능합니다.");
}
</script>
</head>
<body>
 <!-- Footer -->
   <!-- Navigation -->
  
  <footer class="footer">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-4">
          <span class="copyright">Copyright &copy; MeetWhen 2019</span>
        </div>
        <div class="col-md-4">
          <ul class="list-inline social-buttons">
            <li class="list-inline-item">
              <a href="#">
                <i class="fab fa-twitter"></i>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="#">
                <i class="fab fa-facebook-f"></i>
              </a>
            </li>
            <li class="list-inline-item">
              <a href="#">
                <i class="fab fa-linkedin-in"></i>
              </a>
            </li>
          </ul>
        </div>
        <div class="col-md-4">
          <ul class="list-inline quicklinks">
            <li class="list-inline-item">
              <a href="#">Privacy Policy</a>
            </li>
            <li class="list-inline-item">
              <a href="/MeetWhenGit/Main/allServices.mw">서비스 전체 보기</a>
            </li>
            <li class="list-inline-item">
            	<c:if test="${sessionScope.loginUser eq 'admin'}">
              		<a href="/MeetWhenGit/Member/myPage.mw">ADMIN</a>
              </c:if>
              <c:if test="${sessionScope.loginUser ne 'admin'}">
              		<a onclick="noAccess()">ADMIN</a>
              </c:if>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="/MeetWhenGit/vendor/jquery/jquery.min.js"></script>
  <script src="/MeetWhenGit/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- Plugin JavaScript -->
  <script src="/MeetWhenGit/vendor/jquery-easing/jquery.easing.min.js"></script>
  <!-- Contact form JavaScript -->
  <script src="/MeetWhenGit/js/jqBootstrapValidation.js"></script>
  <script src="/MeetWhenGit/js/contact_me.js"></script>
  <!-- Custom scripts for this template -->
  <script src="/MeetWhenGit/js/agency.min.js"></script>
</body>
</html>