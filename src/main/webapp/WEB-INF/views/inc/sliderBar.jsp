<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<ul
	class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
	id="accordionSidebar">

	<!-- 로고 이미지 -->
	<a
		class="sidebar-brand d-flex align-items-center justify-content-center"
		href="${path}/index.do">
		<div class="sidebar-brand-icon">
			<img width="30px" class='img-icon'
				src="${path}/a00_com/img/FB_icon2.png">
		</div>
		<div class="sidebar-brand-text ml-2 mx-1">FLOW BRICK</div>
	</a>

	<hr class="sidebar-divider my-0">

	<!-- Dashboard -->
	<li class="nav-item active"><a class="nav-link"
		href="${path}/index.do"> <i class="fas fa-fw fa-tachometer-alt"></i>
			<span>대시보드</span></a></li>

	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">업무</div>

	<!-- 프로젝트 -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapsePages"
		aria-expanded="true" aria-controls="collapsePages"> <i
			class="fas fa-fw fa-folder"></i> <span>프로젝트</span>
	</a>
		<div id="collapsePages" class="collapse"
			aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">내 프로젝트</h6>
				<a class="collapse-item" href="${path}/projectList">프로젝트 리스트</a> <a
					class="collapse-item" href="${path}/riskList">리스크 리스트</a>
			</div>
		</div></li>



	<!-- 일정 -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#collapseCalendar"
		aria-expanded="true" aria-controls="collapsePages"> <i
			class="fas fa-fw fa-table"></i> <span>일정</span>
	</a>
		<div id="collapseCalendar" class="collapse"
			aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">캘린더</h6>
				<a class="collapse-item" href="${path}/calendar">캘린더</a>
				<h6 class="collapse-header">간트차트</h6>
				<a class="collapse-item" href="${path}/gantt.do">간트차트</a>
			</div>

		</div></li>



	<!-- 채팅 -->
	<li class="nav-item" id="chatting"><a class="nav-link"
		href="${path}/chatting"> <i class="fas fa-comments"></i> <span>채팅</span>
	</a></li>

	<c:if test="${empResult.auth == '관리자'||empResult.auth == '인사관리자'}">
	<hr class="sidebar-divider d-none d-md-block">
		<!-- Heading -->
		<div class="sidebar-heading">기타기능</div>

		<!-- 관리자모드 -->

		<li class="nav-item"><a class="nav-link collapsed" href="#"
			data-toggle="collapse" data-target="#collapseTwo"
			aria-expanded="true" aria-controls="collapseTwo"> <i
				class="fas fa-fw fa-cog"></i> <span>관리자모드</span>
		</a>
			<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
				data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<c:if test="${empResult.auth == '관리자'||empResult.auth == '인사관리자'}">
						<h6 class="collapse-header">사원관리</h6>
						<a class="collapse-item" href="${path}/empList.do">사원목록</a>

						<h6 class="collapse-header">부서관리</h6>
						<a class="collapse-item" href="${path}/deptList.do">부서목록</a>
					</c:if>
					<c:if test="${empResult.auth=='관리자'}">
						<h6 class="collapse-header">프로젝트관리</h6>
						<a class="collapse-item" href="${path}/riskManage">리스크 승인대기</a>
					</c:if>
				</div>
			</div></li>
	</c:if>



	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>

	<!-- Sidebar Message -->
	<div class="sidebar-card d-none d-lg-flex">
		<img class="sidebar-card-illustration mb-2"
			src="${path}/a00_com/img/undraw_rocket.svg" alt="...">
		<%--	
				<p class="text-center mb-2">
					<strong>SB Admin Pro</strong> is packed with premium features,
					components, and more!
				</p>
				<a class="btn btn-success btn-sm"
					href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to
					Pro!</a>
				 --%>
	</div>

</ul>