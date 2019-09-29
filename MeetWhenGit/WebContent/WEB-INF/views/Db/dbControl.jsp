<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%-- DB내용 이용해서 정보 보여주기.--%>
<%--
1. 엑셀 정규화 정보 저장DB
2. ggmap이용해 위도경도 추가한 DB 저장
 --%>
 
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
.btn {
  border: none;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}

.success {background-color: #4CAF50;} /* Green */
.success:hover {background-color: #46a049;}

.info {background-color: #2196F3;} /* Blue */
.info:hover {background: #0b7dda;}

.warning {background-color: #ff9800;} /* Orange */
.warning:hover {background: #e68a00;}

.danger {background-color: #f44336;} /* Red */ 
.danger:hover {background: #da190b;}

</style>
<script type="text/javascript">
	/*
	$(document).ready(function(){
		$('button').click(function(){
			alert("클릭함"+$(this).val());
			});
	});
	*/
	
	// 삭제 전 다시 질문 하기
	function deleteInfo(num){
		var msg = confirm("해당 DB의 내용을 삭제하시겠습니까?");
		if(msg){
			alert("삭제를 진행합니다.");
			location.href="/MeetWhenGit/Db/dbDelete.mw?num="+num;
		}
		//else는 아무동작 x
	}
</script>
</head>
<body>
	
	<button class="btn btn-secondary btn-lg" style="background-color:black;"
		onclick="window.location.href='/MeetWhenGit/Member/myPage.mw'">관리자페이지 HOME</button>
	<br><br>
	<h1>DB-Control PAGE</h1><br>
	<h3>지하철 교통 정보 DB [SubwayInfo]</h3>
	<table>
			<tr>
				<td><button name="num" value="5" id=checkDb class="btn info"
					onclick="fetchPage2('dbInfoCheck.mw?num=5')">SubwayInfo</button></td>
					<td><button name="num" value="5" id=checkDb class="btn light-ark"
					onclick="location.reload()">X</button></td>
			</tr>
	</table>
	<article id="subwayDB"></article><hr><br>
	
	<h3>회원 관련 정보 DB [MWMember/MWAddress/MWMeetGroup/MWLinkInfo/Calendar]</h3>
	<table>
			<tr>
				<td><button name="num" value="6" id=checkDb class="btn info"
					onclick="fetchPage3('dbInfoCheck.mw?num=6')">Member</button></td>
				<td><button name="num" value="7" id=checkDb class="btn info"
					onclick="fetchPage3('dbInfoCheck.mw?num=7')">Address</button></td>	
				<td><button name="num" value="8" id=checkDb class="btn info"
					onclick="fetchPage3('dbInfoCheck.mw?num=8')">LinkInfo</button></td>
					<%-- 
				<td><button name="num" value="9" id=checkDb class="btn info"
					onclick="fetchPage3('dbInfoCheck.mw?num=9')">Calendar</button></td>--%>
				<td><button class="btn light-dark"	onclick="location.reload()">X</button></td>
			</tr>
	</table>
	<article id="memberDB"></article><hr><br>
	
	<h3>GoogleMap에 사용되는 DB [Contry/LContry/Region/LRegion]</h3>
	※ 아래 DB 정보 생성은 순차적으로 진행하셔야합니다.<br>
	※ LContry,LRegion Tabled은 경도위도 정보를 geocode로 추출해내기때문에, 다소 시간이 걸릴 수 있습니다.<br>
	※ Contry, Region: 5초 ~ 최대 20초 소요.<br>
	※ Lcontry:15초 ~ 최대 40초  / LRegion:최대 1분 소요.<br>
	<form id="createfrm" action="dbCreate.mw">
		<table>
			<tr>
				<th>DB정보 생성</th>
				<td><button name="num" value="1" id=crtDb class="btn success">Contry</button></td>
				<td><button name="num" value="2" id=crtDb class="btn success">LContry</button></td>
				<td><button name="num" value="3" id=crtDb class="btn success">Region</button></td>
				<td><button name="num" value="4" id=crtDb class="btn success">LRegion</button></td>
			</tr>
		</table>
	</form>

	<table>
		<tr>
			<th>DB내용 삭제</th>
			<td><button name="num" value="1" id=deleDb class="btn danger"
					onclick="deleteInfo(1)">Contry</button></td>
			<td><button name="num" value="2" id=deleDb class="btn danger"
					onclick="deleteInfo(2)">LContry</button></td>
			<td><button name="num" value="3" id=deleDb class="btn danger"
					onclick="deleteInfo(3)">Region</button></td>
			<td><button name="num" value="4" id=deleDb class="btn danger"
					onclick="deleteInfo(4)">LRegion</button></td>
		</tr>
	</table>

	<table>
		<tr>
			<th>DB내용 확인</th>
			<td><button name="num" value="1" id=checkDb class="btn info"
					onclick="fetchPage('dbInfoCheck.mw?num=1')">Contry</button></td>
			<td><button name="num" value="2" id=checkDb class="btn info"
					onclick="fetchPage('dbInfoCheck.mw?num=2')">LContry</button></td>
			<td><button name="num" value="3" id=checkDb class="btn info"
					onclick="fetchPage('dbInfoCheck.mw?num=3')">Region</button></td>
			<td><button name="num" value="4" id=checkDb class="btn info"
					onclick="fetchPage('dbInfoCheck.mw?num=4')">LRegion</button></td>
			<td><button name="num" value="5" id=checkDb class="btn light-ark"
					onclick="location.reload()">X</button></td>		
		</tr>
	</table>

	<article id="mapDB"></article>
	<script>
    //onclick에 삽입되는 중복코드를 간결하게 하기위한, 함수 정의 
  	function fetchPage(name){
  		fetch(name).then(function(response){   
		    response.text().then(function(text){ 
		       document.querySelector('#mapDB').innerHTML = text;	        
		       //var cut =name.indexOf('?');
		       //console.log(name.substr(cut));
		       //console.log('RealPath=http://localhost:8080/MeetWhenGit/Db/dbInfoCheck.mw'+name.substr(cut));
		    })
		});
  	} 	
  	function fetchPage2(name){
  		fetch(name).then(function(response){   
		    response.text().then(function(text){ 
		       document.querySelector('#subwayDB').innerHTML = text;
		    })
		});
  	} 	
	function fetchPage3(name){
  		fetch(name).then(function(response){   
		    response.text().then(function(text){ 
		       document.querySelector('#memberDB').innerHTML = text;
		    })
		});
  	} 	
  </script>
  <br><hr>
  <h3>크롤링 정보저장 DB [CrawlA1/CrawlA2/CrawlB1/CrawlB2/CrawlB3/CrawlB4/CrawlB5//CrawlB6]</h3>
  <button class="btn warning"
	onclick="location.href='/MeetWhenGit/Crawl/CrawlControl.mw'">크롤링관련 리셋&생성 페이지</button>
</body>
</html>
