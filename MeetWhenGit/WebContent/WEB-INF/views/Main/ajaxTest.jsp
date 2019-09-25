<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>DB format & create</title>
<style>
	 .tabb {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
    font-weight:bold;
  }
  .tabb {
    background-color: #bbdefb;
  }
</style>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
function callCrawlA1(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawla1.mw",
				success : function(){
					$("#resultA1").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultA1").text("���� ����...!!");}
			});
	});
}
function callCrawlA2(){
	$(document).ready(function(){	
		$.ajax({
			type :"post",
			url : "/MeetWhen/Crawl/doCrawla2.mw",
			success : function(){
				$("#resultA2").text("���� �Ϸ�!");	}, 
			error : function(){
				$("#resultA2").text("���� ����...!!");}
		});	
	});
}
function callCrawlB1(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawlb.mw?dbNum=1",
				success : function(){
					$("#resultB1").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultB1").text("���� ����...!!");}
			});
	});
}
function callCrawlB2(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawlb.mw?dbNum=2",
				success : function(){
					$("#resultB2").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultB2").text("���� ����...!!");}
			});
	});
}
function callCrawlB3(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawlb.mw?dbNum=3",
				success : function(){
					$("#resultB3").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultB3").text("���� ����...!!");}
			});
	});
}
function callCrawlB4(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawlb.mw?dbNum=4",
				success : function(){
					$("#resultB4").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultB4").text("���� ����...!!");}
			});
	});
}
function callCrawlB5(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawlb.mw?dbNum=5",
				success : function(){
					$("#resultB5").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultB5").text("���� ����...!!");}
			});
	});
}
function callCrawlB6(){
	$(document).ready(function(){	
			$.ajax({
				type :"post",
				url : "/MeetWhen/Crawl/doCrawlb.mw?dbNum=6",
				success : function(){
					$("#resultB6").text("���� �Ϸ�!");	}, 
				error : function(){
					$("#resultB6").text("���� ����...!!");}
			});
	});
}

	function StartCrowling() {
		var sec = 1000;
		var min = sec * 60;
		var hour = min * 60;

		callCrawlA1();
		setInterval(callCrawlA1, min*10);//10��  min*10
		callCrawlA2();
		setInterval(callCrawlA2, min*15);//20��   min*15

		callCrawlB1();
		setInterval(callCrawlB1,  hour);//1�ð�  hour
		
		callCrawlB2();
		setInterval(callCrawlB2,  hour+min*10); //1�ð�  10�� hour
		
		callCrawlB3();
		setInterval(callCrawlB3,  hour+min*15); //1�ð�  15�� hour
		
		callCrawlB4();
		setInterval(callCrawlB4,  hour+min*20); //1�ð� 20��  hour
		
		callCrawlB5();
		setInterval(callCrawlB5,  hour+min*25); //1�ð� 25��  hour
		
		callCrawlB6();
		setInterval(callCrawlB6,  hour+min*30); //1�ð� 30�� hour
	}
</script>

</head>

<body onload="StartCrowling()">
	<h3>DB �ڵ� ���� �� ���� PAGE</h3>
	<table class="tabb">
		<tr>
			<td>���������� �⺻ ���� (���̹�):</td>
			<td><div id="resultA1"></div></td>
		</tr>
		<tr>
			<td>��������� �⺻ ���� (����):</td>
			<td><div id="resultA2"></div></td>
		</tr>
		<tr>
			<td>��� �˻�(��ü):</td>
			<td><div id="resultB1"></div></td>
		</tr>
		<tr>
			<td>��� �˻�(����):</td>
			<td><div id="resultB2"></div></td>
		</tr>
		<tr>
			<td>��� �˻�(������ī/�ߵ�):</td>
			<td><div id="resultB3"></div></td>
		</tr>
		<tr>
			<td>��� �˻�(ȣ��/�ƽþ�):</td>
			<td><div id="resultB4"></div></td>
		</tr>
		<tr>
			<td>��� �˻�(�Ϲ�):</td>
			<td><div id="resultB5"></div></td>
		</tr>
		<tr>
			<td>��� �˻�(����):</td>
			<td><div id="resultB6"></div></td>
		</tr>
	</table>

</body>
</html>