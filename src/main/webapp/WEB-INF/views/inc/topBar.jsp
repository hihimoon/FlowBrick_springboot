<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<nav
	class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

	<!-- Sidebar Toggle (Topbar) -->
	<button id="sidebarToggleTop"
		class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>

	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">


		<!-- 내정보 섹션 -->
		<li class="nav-item dropdown no-arrow"><a
			class="nav-link dropdown-toggle" href="#" id="userDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <span
				class="mr-2 d-none d-lg-inline text-gray-600"> 
				<c:if test="${not empty empResult.ename}">
					<c:choose>
						<c:when test="${empResult.auth ne '일반'}">
      						[${empResult.auth}]${empResult.ename} ${empResult.job}
						</c:when>
						<c:otherwise>
    					${empResult.ename} ${empResult.job}
   						 </c:otherwise>
						</c:choose>
					</c:if>
					</span> <img class="img-profile rounded-circle"
				src="${path}/a00_com/img/undraw_profile.svg">
		</a> <!-- Dropdown - User Information -->
			<div
				class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
				aria-labelledby="userDropdown">
				<a class="dropdown-item" href="${path}/mypage.do"> <i
					class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필 <%-- </a> <a class="dropdown-item" href="${path}/mypage.do"> <i
					class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 계정관리
				</a> --%> <!-- <a class="dropdown-item" href="#"> <i
					class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
					Log
				</a> -->
					<div class="dropdown-divider"></div> <a class="dropdown-item"
					href="${path}/logout.do"> <i
						class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
						로그아웃
				</a>
			</div></li>

	</ul>

</nav>
