<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${listSize eq 0}">
	<h1>현재 DB${num}의 내용이 존재하지 않습니다.</h1>
</c:if>
<c:if test="${listSize ne 0}">
<h1>
	<c:if test="${num eq 1}">CONTRY</c:if>
	<c:if test="${num eq 2}">LCONTRY</c:if>
	<c:if test="${num eq 3}">Region</c:if>
	<c:if test="${num eq 4}">LRegion</c:if>
	<c:if test="${num eq 5}">SubwayInfo</c:if>
	<c:if test="${num eq 6}">Member</c:if>
	<c:if test="${num eq 7}">Address</c:if>
	<c:if test="${num eq 8}">LinkInfo</c:if>
	<c:if test="${num eq 9}">Calendar</c:if>
	의 정보</h1>
</c:if>

<c:forEach items="${dataList}" var="ent" begin="0" step="1" end="${listSize}">
	<c:if test="${num==1}"><%--Contry --%>
		<span>${ent.c_num}) ${ent.c_con} : ${ent.c_cnt}</span><br>
	</c:if>
	<c:if test="${num==2}"><%--LContry --%>
		<span>${ent.lc_num}) ${ent.lc_con} : ${ent.lc_cnt}, ${ent.lc_lat}, ${ent.lc_lon}</span><br>
	</c:if>
	<c:if test="${num==3}"><%--Region --%>
		<span>${ent.r_num}) ${ent.r_reg} : ${ent.r_cnt}</span><br>
	</c:if>
	<c:if test="${num==4}"><%--LRegion --%>
		<span>${ent.lr_num}) ${ent.lr_reg} : ${ent.lr_cnt}, ${ent.lr_lat}, ${ent.lr_lon}</span><br>
	</c:if>
	
	<c:if test="${num==5}"><%--SubwayInfo --%>
		<span>[${ent.ARSID})] ${ent.SUBWAYNAME}(${ent.SUBLINE}:${ent.OUTCODE}) =${ent.XLAT}, ${ent.YLAT}</span><br>
	</c:if>
	
	<c:if test="${num==6}"><%--Member --%>
		<span>[${ent.registrationdate}] [${ent.m_serialnumber}] _ [ID:${ent.m_id}/PW:${ent.m_pw}] : (NAME_${ent.m_name}), (EMAIL_${ent.m_email}),(IMG_${ent.m_profile_img})</span><br>
	</c:if>
	<c:if test="${num==7}"><%--Address --%>
		<h4>ID [${ent.m_id}]의 주소 정보</h4>
		<ul style="list-style:none; padding-left:0px">
			<li>주소1 : [${ent.address1} :${ent.lat1}/${ent.long1}]</li>
			<li>주소2 : [${ent.address2} :${ent.lat2}/${ent.long2}]</li>
			<li>주소3 : [${ent.address3} :${ent.lat3}/${ent.long3}]</li>
		</ul>
	</c:if>
	<c:if test="${num==8}"><%--LinkInfo --%>
		<span>[${ent.request_date}] ${ent.m_id}가 친구추가한 ID --> ${ent.link_m_id}</span><br>
	</c:if>
	<%--Calendar
	<c:if test="${num==9}">
		<span>${ent.M_id}_[${ent.groupid}/${ent.title}] : ${ent.c_start}~${ent.c_end},${ent.type}</span><br>
	</c:if>
	 --%>
</c:forEach>
