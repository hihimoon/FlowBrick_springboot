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
<title>pms-forgotEmployeeID</title>


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script type="text/javascript">
	document.addEventListener('keydown', function(event) {
		if (event.key === "Enter") {
			event.preventDefault();
		}
	});
	$(document).ready(function() {

		$("#forgotBtn").click(function() {
			// 입력 필드 검증
			var email = $("#email").val();
			if (email === "" || emailFormat(email) === false) {
				$("#email").focus();
				$('.failureEmail-message').removeClass('hide');
				return; // 이메일이 비어있으면 처리 중단
			}
			// 모든 검증이 통과되면 폼 제출
			$("#forgotFrm").submit();
		});

		$("#email").keyup(function(event) {
			if (event.keyCode === 13) {
				$("#forgotBtn").click();
			}
		});
		// emailFormat 함수 정의
		function emailFormat(str) {
			return /^[A-Za-z0-9_.-]+@[A-Za-z0-9-]+\.[A-Za-z0-9-.]+$/.test(str);
		}

		var msg = "${msg}"
		var emailMsg = "${emailMsg}"
		if (msg !== "") {
			var confirmMessage = msg;

			if (emailMsg !== "") {
				confirmMessage += "\n" + emailMsg;
			}
			alert(confirmMessage)
		}

	});
	function checkMaxLength(e) {
		if (e.value.length > e.maxLength) {
			e.value = e.value.slice(0, e.maxLength);
		}
	}
</script>







<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${path}/a00_com/css/login.css" rel="stylesheet">


</head>





<body class="bg-gradient-primary">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block forgot-image">
								<img src="${path}/a00_com/img/forgot.jpg">
							</div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<div class="brand-icon">
											<img class='img-icon' src="${path}/a00_com/img/FB_icon4.png">
										</div>
										<h1 class="h4 text-gray-900 mb-4">사원번호 찾기</h1>
										<p class="mb-4">
											이메일 주소를 입력하시면,<br> 해당 이메일로 사원번호를 보내드립니다.
										</p>
									</div>
									<form class="user" method="post" id="forgotFrm">
										<div class="form-group">
											<input type="email" name="email" maxlength="30"
												oninput="checkMaxLength(this)"
												class="form-control form-control-user" id="email"
												placeholder="이메일 입력">
										</div>
										<div class="failureEmail-message hide error-message">올바른
											이메일 형식이 아닙니다.</div>

										<button type="button"
											class="btn btn-primary btn-user btn-block" id=forgotBtn>사원번호
											찾기</button>

									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="${path}/login.do">로그인페이지로 이동</a> · <a
											class="small" href="${path}/forgotPwd">비밀번호 찾기</a>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>


	<!-- Bootstrap core JavaScript-->
	<script src="${path}/a00_com/vendor/jquery/jquery.min.js"></script>
	<script
		src="${path}/a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${path}/a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${path}/a00_com/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>


</body>
</html>