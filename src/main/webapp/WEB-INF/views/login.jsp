<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pms-login</title>




<%--
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>

<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
 --%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("#loginBtn").click(function() {

			//초기화 구문
			$('.failurePassword-message').addClass('hide');
		
			// 입력 필드 검증
			var empno = $("#empno").val();
			var password = $("#password").val();

			if (empno === "") {
				$("#empno").focus();
				$('.failureId-message').removeClass('hide');

				return; // 사원번호가 비어있으면 처리 중단
			} else {
				$('.failureId-message').addClass('hide');
			}

			if (password === "") {
				$("#password").focus();
				$('.failurePassword-message').removeClass('hide');
				return; // 비밀번호가 비어있으면 처리 중단
			}

			// 모든 검증이 통과되면 폼 제출
			$("#loginFrm").submit();
		})

		$("#empno, #password").keyup(function(event) {
			if (event.keyCode === 13) {
				$("#loginBtn").click();
			}
		});

		// 이전화면에서 요청된 내용을 선택하게 하게, 선택할 때, 서버에 언어 선택 내용 전달.
		$("#selectLan").val("${param.lang}").change(function() {
			var chVal = $(this).val()
			if (chVal != '') {
				location.href = "${path}/multiLang?lang=" + chVal

			}
		})
		//로그인 처리
		var empno = "${emp.empno}"
		var sessEmpno = "${empResult.empno}"
			var sessPwd = "${empResult.password}"
		if (empno != "") {
			if (sessEmpno != "") {
				location.href = "${path}/index.do";
			} else {
				alert(sessPwd+sessEmpno+"로그인 실패\n사원번호 또는 비밀번호가 틀렸습니다.");
			}
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
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap"
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
							<div class="col-lg-6 d-none d-lg-block login-image">
								<img src="${path}/a00_com/img/login.jpg">
							</div>
							<div class="col-lg-6">
								<div class="p-5">

									<div class="brand-icon">
										<img class='img-icon' src="${path}/a00_com/img/FB_icon4.png">
									</div>

									<div class="input-group-prepend">
										<select class="form-control" id="selectLan">
											<option value="" selected disabled><spring:message
													code="chlange" /></option>
											<option value="ko"><spring:message code="ko" /></option>
											<option value="en"><spring:message code="en" /></option>
										</select>
									</div>
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">
											<spring:message code="login" />
										</h1>
									</div>
									<form class="user" method="post" id="loginFrm"
										action="${path}/login.do">
										<div class="form-group">
											<input type="number" maxlength="5"
												oninput="checkMaxLength(this)" name="empno"
												class="form-control form-control-user" id="empno"
												placeholder='<spring:message
							code="empno" />'>
										</div>
										<div class="failureId-message hide error-message">
											<spring:message code="failureId-message" />
										</div>
										<div class="form-group">
											<input type="password" maxlength="20"
												oninput="checkMaxLength(this)" name="password"
												class="form-control form-control-user" id="password"
												placeholder='<spring:message
							code="pwd" />'>
										</div>
										<div class="failurePassword-message hide error-message">
											<spring:message code="failurePassword-message" />
										</div>
										<!-- <div class="form-group">
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input"
													id="customCheck"> <label
													class="custom-control-label" for="customCheck">Remember
													Me</label>
											</div>
										</div> -->
										<button type="button"
											class="btn btn-primary btn-user btn-block" id=loginBtn>
											<spring:message code="login" />
										</button>

									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="${path}/forgotEmpno"><spring:message
												code="forgot-empno" /></a> <a class="small"
											href="${path}/forgotPwd">· <spring:message
												code="forgot-password" /></a>
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