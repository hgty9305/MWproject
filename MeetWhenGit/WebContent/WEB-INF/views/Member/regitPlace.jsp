<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%request.setCharacterEncoding("UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
<script language="javascript">
function goPopup(){
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrCoordUrl.do)를 호출하게 됩니다.
    var pop = window.open("jusoPopup.mw","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn
						, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno
						, emdNo, entX, entY){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.form.roadAddrPart1.value = roadAddrPart1;
	document.form.roadAddrPart2.value = roadAddrPart2;
	document.form.addrDetail.value = addrDetail;
	document.form.zipNo.value = zipNo;
	document.form.entX.value = entX;
	document.form.entY.value = entY;
}
</script>
</head>

<body id="page-top">
 <jsp:include page="/Main/boots_menubar.mw"/>
<form name="form" id="form" method="post" action="regitPlacePro.mw">
	<input type="hidden" id="addressTarget" name="addressTarget" value="${param.id}" />
	<table >
			<colgroup>
				<col style="width:20%"><col>
			</colgroup>
			<tbody>			
				<tr>
					<th>우편번호</th>
					<td>
					    <input type="hidden" id="confmKey" name="confmKey" value=""  >
						<input type="text" id="zipNo" name="zipNo" readonly style="width:100px">
						<input type="button"  value="주소검색" onclick="goPopup();">
					</td>
				</tr>
				<tr>
					<th><label>도로명주소</label></th>
					<td><input type="text" id="roadAddrPart1" name ="roadAddrPart1" style="width:85%"></td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td>
						<input type="text" id="addrDetail" name ="addrDetail" style="width:40%" value="">
						<input type="text" id="roadAddrPart2"name="roadAddrPart2"  style="width:40%" value="">
					</td>
				</tr>
				<tr>
					<th>좌표정보</th>
					<td>
						<input type="text" id="entY" name="entY"style="width:40%" value="">
						<input type="text" id="entX" name="entX" style="width:40%" value="">
					</td>
				</tr>
			</tbody>
			</table>
		<input type ="submit" value ="장소등록"/>
</form>
<jsp:include page="/Main/boots_footer.mw"/>
</body>
</html>
