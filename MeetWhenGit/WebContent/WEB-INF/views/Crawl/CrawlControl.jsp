<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Crawling > DB format & create</title>
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
	alert("[CrawlA1 : �� ����&����_15�� ����]");
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
	alert("[CrawlA2 : �� ����&����_15�� ����]");
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
	alert("[CrawlB1 : �� ����&����_30�� ����]");
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
	alert("[CrawlB2 : �� ����&����_30m�� ����]");
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
	alert("[CrawlB3 : �� ����&����_30�� ����]");
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
	alert("[CrawlB4 : �� ����&����_30�� ����]");
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
	alert("[CrawlB5 : �� ����&����_30�� ����]");
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
	alert("[CrawlB6 : �� ����&����_30�� ����]");
}

	function StartCrowling() {
		var sec = 1000;
		var min = sec * 60;
		var hour = min * 60;
        msg=" First Format&Create ����";
        
	
		alert("1�� �� ���� �ڵ� ũ�Ѹ��� �����մϴ�.");
		
		setTimeout(function(){
			alert("[CrawlA1"+msg+"]");
			callCrawlA1();
		},min*1) //1�еڿ� ����
		setInterval(callCrawlA1, min*15); 
		
		setTimeout(function(){
			alert("[CrawlA2"+msg+"]");
			callCrawlA2();
		},min*2+sec*30) //2��30�� �ڿ� ����
		setInterval(callCrawlA2, min*15);

		
		setTimeout(function(){
			alert("[CrawlB1"+msg+"]");
			callCrawlB1();
		},min*5) //5�еڿ� ���� 
		setInterval(callCrawlB1, min*30); 
		
		setTimeout(function(){
			alert("[CrawlB2"+msg+"]");
			callCrawlB2();
		},min*5+sec*15) //5��15�� �ڿ� ���� 
		setInterval(callCrawlB2,  min*30);  
		
		setTimeout(function(){
			alert("[CrawlB3"+msg+"]");
			callCrawlB3();
		},min*5+sec*30) //5��30�� �ڿ� ���� 
		setInterval(callCrawlB3,  min*30); 
		
		setTimeout(function(){
			alert("[CrawlB4"+msg+"]");
			callCrawlB4();
		},min*5+sec*45) //5��45�� �ڿ� ���� 
		setInterval(callCrawlB4,  min*30);  
		
		setTimeout(function(){
			alert("[CrawlB5"+msg+"]");
			callCrawlB5();
		},min*6) //6�� �ڿ� ����  
		setInterval(callCrawlB5,  min*30); 
		
		setTimeout(function(){
			alert("[CrawlB6"+msg+"]");
			callCrawlB6();
		},min*6+sec*15) //6��15�� �ڿ� ����
		setInterval(callCrawlB6,  min*30); 
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