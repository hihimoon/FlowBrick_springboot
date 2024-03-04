<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FlowBrick-mypage</title>


<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/login.css" rel="stylesheet">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>

<script>
	$(document).ready(function() {
		var sessId = "${empResult.empno}"
		if (sessId == "") {
			alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
			location.href = "${path}/login.do"
		}

		$("#regBtn").click(function() {

			$("#mypageFrm").submit();
		})

		var msg = "${msg}"
		if (msg != "") {
			alert(msg)
		}
	})
</script>
<script type="text/javascript">
	
</script>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="inc/sliderBar.jsp"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<%-- <%@ include file="backendweb/z05_bootTmp/a03_topBar.jsp" %>   
				     <jsp:include page="${path}/z05_bootTmp/a03_topBar.jsp"/>
				--%>
				<!-- Topbar   %>  
				-->
				<%@ include file="inc/topBar.jsp"%>
				<!-- End of Topbar -->
				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">회원정보</h1>
					</div>

					<!-- Content Row -->

					<form method="post" id="mypageFrm">
						<!-- DataTales Example -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<label for="empno">사원번호</label> <input type="text" id="empno"
									class="h3 mb-2 text-gray-800 form-control form_c " name="empno"
									value="${empInfo.empno}" readonly>
							</div>
							<div class="card-header py-3">
								<label for="ename">이름</label> <input type="text" id="ename"
									class="h3 mb-2 text-gray-800 form-control form_c " name="ename"
									value="${empInfo.ename}" readonly>
							</div>

							<div class="card-header py-3">
								<label for="dname">부서</label> <input type="text" id="dname"
									class="h3 mb-2 text-gray-800 form-control form_c " name="dname"
									value="${empInfo.dname}" readonly>
							</div>

							<div class="card-header py-3">
								<label for="job">직급</label> <input type="text" id="job"
									class="h3 mb-2 text-gray-800 form-control form_c" name="job"
									value="${empInfo.job}" readonly>
							</div>

							<div class="card-header py-3">
								<label for="tel">휴대폰번호</label> <input type="text" id="tel"
									class="h3 mb-2 text-gray-800 form-control form_c" name="tel"
									value="${empInfo.tel}">
							</div>


							<div class="card-header py-3">
								<label for="email">이메일</label> <input type="text" id="email"
									class="h3 mb-2 text-gray-800 form-control form_c" name="email"
									value="${empInfo.email}" readonly>
							</div>

							<div class="card-header py-3">
								<label>비밀번호</label>
								<div>
									<a class="btn btn-danger" href="${path}/passwordChanges.do"><i
										class="fas fa-lock"></i>비밀번호 변경</a>
								</div>


							</div>
						</div>
						<!-- 첨부파일 -->
						<%-- <div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="form_c m-0 font-weight-bold text-primary">프로필사진</h6>
						</div>
						<div class="card-body d-sm-flex">
							<div>
							<img class="img-profile rounded-circle" src="/pms/a00_com/img/undraw_profile.svg">
							<img class="img_file" src="${path}/a00_com/img/file_icon.png">&nbsp&nbsp
							  </div>
							<input id="input-file" type="file" class="h3 mb-2 text-gray-800 form-control form_c bg-light"
									aria-label="Search" aria-describedby="basic-addon2" name="reports"
									multiple/>
							<!--
							<div class="input-group mb-3">
								<input id="input-file" type="file" name="reports"
									multiple />
							</div>
							-->	
						</div>
					</div> --%>
						<!-- 버튼 div -->
						<div class="my-2"></div>
						<div class="d-sm-flex justify-content-between">
							<div></div>

							<div>

								<a id="regBtn" class="btn btn-success btn-icon-split"> <span
									class="icon text-white-50"> <i
										class="fas fa-arrow-right"></i>
								</span> <span class="text">저장하기</span>
								</a>
							</div>
						</div>
					</form>

					<!-- /.container-fluid -->

				</div>
				<!-- End of Main Content -->

				<!-- Footer -->
				<footer class="sticky-footer bg-white">
					<div class="container my-auto">
						<div class="copyright text-center my-auto">
							<span>Copyright &copy; Your Website 2021</span>
						</div>
					</div>
				</footer>
				<!-- End of Footer -->

			</div>
			<!-- End of Content Wrapper -->

		</div>
		<!-- End of Page Wrapper -->

		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="far fa-angle-up"></i>
		</a>




		<!-- Logout Modal-->
		<%@ include file="inc/logout_modal.jsp"%>

		<!-- Bootstrap core JavaScript-->
		<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
		<script
			src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script
			src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>
</body>
</html>