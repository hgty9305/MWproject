<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<style>

</style>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<body id="page-top">
   
   <jsp:include page="/Main/boots_menubar.mw"/>
   <section class="page-section">
      <div class="container" style="position:relative" height = "50px">
         <div class="col-lg-12 text-center">
            <h2 class="section-heading text-uppercase">아이디로 친구 검색</h2>
                <h3 class="section-subheading text-muted">친구의 아이디를 이용하여, 그룹을 만들어보세요.</h3>
             </div>
             <div style="float:left"><img src="/MeetWhenGit/img/friend.jpg" style ="float:left" width ="400" height ="600"></div>

           
           <div id = "addresult"></div>

           <div>
           <c:set value="${addresslist}" var="adlist"/>
         </div>
      </div>
   </section>
   <div >
            
              <form onsubmit="searchajax(); return false;">
                  <input type="text" size="20" id="searchFromAll" name="searchFromAll"/>&nbsp;
                  <button type="submit" class="mx-auto rounded-circle">검색</button>
              </form>
 
   <div id="searchResult" style="float : center">${i.m_id}</div><br><br>  
   
   </div>
   <jsp:include page="/Main/boots_footer.mw"/>
</body>
<script>
var content ="";
var id = [];
function searchajax(){
   var words= $("#searchFromAll").val();
   if(words==""){
      alert("키워드를입력해주세요");
   }else{
      $.ajax({
         type : 'POST',
         url : 'searchResult.mw',
         data : {searchFromAll : words},
         success : function(data){
            $("#searchResult").html(data);
            
         }
      })
   }
};
/* function openPop(){
   
   var url = "searchFriendsPop.mw";
   var name = "친구 추가 확인";
   var option = "width = 300, height = 250, top = 100, left = 200, location = no";
   window.open(url,name,option);
}; */

</script>