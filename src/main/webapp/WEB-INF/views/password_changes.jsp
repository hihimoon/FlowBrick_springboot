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
<title>pms-password_changes</title>

<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/login.css" rel="stylesheet">

<style type="text/css">
.input-file-button {
	padding: 6px 25px;
	background-color: #FF6600;
	border-radius: 4px;
	color: white;
	cursor: pointer;
}

.fileform {
	display: none;
}

input[type=file]::file-selector-button {
	width: 100px;
	height: 30px;
	background: #fff;
	border: 1px solid rgb(77, 77, 77);
	border-radius: 10px;
	cursor: pointer; &: hover { background : rgb( 77, 77, 77);
	color: #fff;
}

}
#chatArea {
	width: 98%;
	margin: auto;
	height: 400px;
	overflow-y: auto;
	text-align: left;
	border: 0.5px solid green;
}
</style>

<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
	function checkMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	}
	$(document)
			.ready(
					function() {
						var sessId = "${empResult.empno}"
						var sessPwd = "${empResult.password}"

						if (sessId == "") {
							alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
							location.href = "${path}/login.do"
						}

						var msg = "${msg}"
						if (msg != "") {
							alert(msg)
						}
						$("#pwdUptBtn")
								.click(
										function() {
											var currentPwd = $("#currentPwd")
													.val();
											var newPwd = $("#password").val();
											var newPwd2 = $("#newPwd2").val();

											if (sessPwd != currentPwd) {
												$("#currentPwd").focus();
												alert("현재 비밀번호 값이 일치하지 않습니다.");
												return;
											}
											if (currentPwd === "") {
												$("#currentPwd").focus();
												alert("현재 비밀번호를 입력해주세요");
												return;
											}
											if (newPwd === ""
													|| strongPassword(newPwd) === false) {
												$("#password").focus();
												alert("8글자 이상, 영문, 숫자, 특수문자(@$!%*#?&)를 사용하세요");
												return;
											}
											if (!isMatch(newPwd, newPwd2)) {
												alert("새 비밀번호 확인 값이 일치하지 않습니다.");
												return;
											}

											// 현재 비밀번호가 일치하면 폼을 제출
											$("#pwdUptFrm").submit();

										});
						$("#currentPwd, #password,#newPwd2").keyup(
								function(event) {
									if (event.keyCode === 13) {
										$("#pwdUptBtn").click();
									}
								});
						function strongPassword(str) {
							return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/
									.test(str);
						}
						function isMatch(newPwd, newPwd2) {
							return newPwd === newPwd2;
						}

					})
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

				<!-- Topbar    -->
				<%@ include file="inc/topBar.jsp"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">비밀번호 변경</h6>
						</div>
						<div class="card-body">
							<form method="post" id="pwdUptFrm">
								<div class="input-group mb-3">
									<input type="hidden" name="empno" class="form-control"
										value="${empResult.empno}" />
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											현재 비밀번호*</span>
									</div>
									<input type="password" maxlength="20"
										oninput="checkMaxLength(this)" id="currentPwd"
										class="form-control" placeholder="현재 비밀번호를 입력해주세요" />
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											새 비밀번호*</span>
									</div>
									<input type="password" maxlength="20"
										oninput="checkMaxLength(this)" id="password" name="password"
										class="form-control"
										placeholder="최소 8글자 이상(알파벳, 숫자, 특수문자(@$!%*#?&)필수)" />
								</div>


								<div class="input-group mb-3">
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											새 비밀번호 확인*</span>
									</div>
									<input type="password" maxlength="20"
										oninput="checkMaxLength(this)" id="newPwd2"
										class="form-control" placeholder="새 비밀번호를 한번 더 입력해주세요" />
								</div>
								<div class="failureNewPwd2-message hide error-message">새
									비밀번호 확인을 입력해주세요</div>

							</form>
							<!-- 버튼 div -->
							<div class="my-2"></div>
							<div class="d-sm-flex justify-content-between">
								<div></div>

								<div>
									<a id="pwdUptBtn" class="btn btn-primary btn-icon-split"> <span
										class="icon text-white-50"> <i
											class="fas fa-arrow-right"></i>
									</span> <span class="text">변경하기</span>
									</a> <a href="${path}/mypage.do"
										class="btn btn-secondary btn-icon-split"> <span
										class="icon text-white-50"> <i
											class="fas fa-arrow-right"></i>
									</span> <span class="text">내 프로필페이지</span>
									</a>
								</div>
							</div>
						</div>
					</div>

				</div>
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
		class="fas fa-angle-up"></i>
	</a>

	<!-- Bootstrap core JavaScript-->
	<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
	<script
		src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

</body>
</html>