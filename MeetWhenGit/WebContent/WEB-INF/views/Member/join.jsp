<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <script type="text/JavaScript">
      function checkReg() {
         //var member = eval("document.member");
         var member = document.member;
         
         var regPw = member.m_pw.value;
         var regPwcheck = member.pwcheck.value;
         var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;

         if (member.m_name.value == "") {
             alert("이름을 입력하세요");
             return;
          }
         if (member.m_id.value == "") {
             alert("아이디을 입력하세요");
             return;
          }
         if (member.m_pw.value == "") {
             alert("비밀번호를 입력하세요");
             return;
          }
         if (member.m_pwcheck.value == "") {
             alert("비밀번호 확인을 입력하세요");
             return;
          }
         if (member.m_nickname.value == "") {
             alert("별명을 입력하세요");
             return;
          }
         if (member.m_phone.value == "") {
             alert("전화번호를 입력하세요");
             return;
          }
         if (member.m_email.value == "") {
             alert("이메일을입력하세요");
             return;
          }
         if (regPw != regPwcheck) {
            alert("비밀번호가 일치하지않습니다.");
            member.pwcheck.focus();
            return false;
         }
         if (!regPhone.test(member.m_phone.value)) {
             alert("010-0000-0000 형식으로 입력하세요");
             member.m_phone.focus();
             return false;
          }
      }
      // 아이디 중복 여부를 판단
      function openConfirmid(member) {
 
         // url과 사용자 입력 id를 조합합니다.
         url = "confirmId.mw?m_id=" + member.m_id.value;

         // 새로운 윈도우를 엽니다.
         open(
               url,
               "confirm",
               "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
      }
      function openEmailAuth(member){
    	 if(member.email!=null){
             url = "emailAuth.mw?m_email" + member.m_email_1.value+member.m_email_2.value;
             open(
                   url,
                   "emailAuth",
                   "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");
    	 }
      }
   </script>
   <%
      request.setCharacterEncoding("UTF-8");
   %>
<html lang="en">
<jsp:include page="/MeetWhenGit/Main/boots_menubar.mw"/>
<body id="page-top">
<div id="container">
   <form action="/MeetWhenGit/member/boots_joinpro.mw" name="member" method="post" align="center" enctype="multipart/form-data">
      <table width="850" align="center">
         <br><br>
         <tr height="50" bgcolor="#FDD262">
            <th colspan="3"><font color="white">회원가입</font></th>
         </tr>
         <tr height="50">
            <th>이 름(실명)</th>
            <th><input type="text" autofocus name="m_name" required /></th>
         </tr>
         <tr height="50">
            <th>ID</th>
            <th><input type="text" autofocus name="m_id" required /> </th>  
            <th><input type="button" value="중복확인" name="confirm_id"
               onclick="openConfirmid(this.form)" /></th>
         </tr>
           <tr height="50">
            <th>비밀번호</th>
            <th><input type="password" name="m_pw" required /></th>
         </tr>
         <tr height="50">
            <th>비밀번호 확인</th>
            <th><input type="password" name="m_pwcheck" required /></th>
         </tr>
    
         <tr height="50">
            <th>전화번호</th>
            <th><input type="text" placeholder="010-0000-0000"
               name="m_phone" required /></th>
         </tr>
         <tr height="50">
            <th>이메일</th>
            <th><input type="text" name="m_email_1"/>           	
            </th>
             <td><select name = "m_email_2">
               <option>@naver.com</option>
               <option>@gmail.com</option>
               <option>@daum.com</option>
            </select>
            </td>
            <td><input type="button" value ="이메일인증" onclick="openEmailAuth(this.form)"></td>
         </tr>
   			<tr height="50">
   			<th>프로필 사진</th>
   			<th><input type="file" align="center" name="m_profile_img"/></th>
   		</tr>
      </table>
      <br/> <input type="submit" value="가입하기"
         style="height: 50px; width: 500px;" onclick="return checkReg()" /> <br/>
      <br /> <a href="/MeetWhenGit/Member/boots_login.mw">이미 회원이세요?</a>
   </form>
  </div>
   <hr>
 <jsp:include page= "/MeetWhenGit/Main/boots_footer.mw"/>
</body>

</html>