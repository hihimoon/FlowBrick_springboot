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
<title>FlowBrick-deptReg</title>


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
<script type="text/javascript">
	document.addEventListener('keydown', function(event) {
		if (event.key === "Enter") {
			event.preventDefault();
		}
	});

	$(document).ready(function() {
		var sessId = "${empResult.empno}"
		var auth = "${empResult.auth}"
		
		if (sessId == "") {
			alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
			location.href = "${path}/login.do"
		}
		if (auth !== "인사관리자") {
			alert("인사관리자만 접근 가능합니다\n메인 메이지로 이동")
			location.href = "${path}/index.do"
		}

		var msg = "${msg}"
		if (msg != "") {
			if (!confirm(msg + "\n계속 등록하시겠습니까?")) {
				location.href = "${path}/deptList.do"
			}
		}

		$("[name=deptno]").keyup(function(event) {
			if (event.keyCode == 13) {
				ckDeptno()
			}
		});

		$("#regBtn").click(function() {
			if (confirm("등록하시겠습니까?")) {
				if ($("[name=deptno]").val() == "") {
					alert("부서번호는 2자리 숫자형이어야 합니다.")
					return;
				}
				if ($("[name=ckDeptno]").val() != "Y") {
					alert("부서번호 중복 체크 하셔야 등록가능합니다.")
					return;
				}
				$("#deptRegFrm").submit()
			}
		});
	});

	function ckDeptno() {
		var deptno = $("[name=deptno]").val();

		if (deptno.length == 2) {
			$.ajax({
				url : "${path}/checkDupDetpnoJson",
				method : "get",
				data : "deptno=" + deptno,
				dataType : "json",
				success : function(cnt) {
					if (cnt > 0) {
						alert("등록된 부서번호가 있습니다.\n다른 번호로 입력하세요")
						$("[name=deptno]").val("").focus()
					} else {
						alert("등록가능한 부서번호입니다")
						$("[name=ckDeptno]").val("Y")
						$("[name=deptno]").attr("readonly", true)
						// 부서번호 중복을 체크해서 중복이 안 될 때에만 등록이 가능하게
						// hidden으로 설정 처리..
						// 중복확인이 완료되었을 때, 더 이상 변경하지 못 하게 처리.
					}
				}
			})
		} else {
			alert('부서번호는 2자리 숫자형이어야 합니다.')
			$("[name=deptno]").val("").focus()

		}
	}
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
						<h1 class="h3 mb-0 text-gray-800">부서등록</h1>
					</div>

					<!-- Content Row -->

					<form method="post" id="deptRegFrm">
						<!-- DataTales Example -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<label for="deptno">부서번호</label> 
								<input type="number" id="deptno" 
								class="h3 mb-2 text-gray-800 form-control form_c "
									name="deptno" placeholder="부서번호 enter입력시 중복확인"> 
									<input type="hidden" name="ckDeptno" value="N" />
							</div>
							<div class="card-header py-3">
								<label for="dname">부서명</label> <input type="text" id="dname"
									class="h3 mb-2 text-gray-800 form-control form_c " name="dname">
							</div>

						</div>

						<!-- 버튼 div -->
						<div class="my-2"></div>
						<div class="d-sm-flex justify-content-between">
							<div></div>

							<div>


								<a id="regBtn" class="btn btn-success btn-icon-split"> <span
									class="icon text-white-50"> <i
										class="fas fa-arrow-right"></i>
								</span> <span class="text">등록하기</span>
								</a> <a href="${path}/deptList.do"
									class="btn btn-secondary btn-icon-split"> <span
									class="icon text-white-50"> <i
										class="fas fa-arrow-right"></i>
								</span> <span class="text">부서목록으로</span>
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
			class="fas fa-angle-up"></i>
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

		<!-- Page level plugins -->
		<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>

		<!-- Page level custom scripts -->
		<script src="${path}/a00_com/js/demo/chart-area-demo.js"></script>
		<script src="${path}/a00_com/js/demo/chart-pie-demo.js"></script>
</body>
</html>