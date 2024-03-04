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
<title>deptList</title>

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
<link href="${path}/a00_com/css/css2.css" rel="stylesheet">
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
		searchDeptList()

		$("#schBtn").click(function() {
			searchDeptList()
		})

		$("[name=dname]").keyup(function() {
			searchDeptList()
		})

		var sessId = "${empResult.empno}"
		var auth = "${empResult.auth}"
		if (sessId == "") {
			alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
			location.href = "${path}/login.do"
		} else if (auth !== "인사관리자" && auth !== "관리자") {
			alert("관리자 or 인사관리자만 접근 가능합니다\n메인 메이지로 이동")
			location.href = "${path}/index.do"
		}
	})

	function goDetail(deptno) {
		location.href = "${path}/deptDetail?deptno=" + deptno
	}

	function searchDeptList() {
		$.ajax({
			type : "POST",
			url : "${path}/deptListJson",
			data : $("#frm01").serialize(),
			dataType : "json",
			success : function(deptPage) {
				console.log(deptPage)
				var sch = deptPage.sch;
				$("#totCnt").text("총:" + sch.count + "건")
				$("[name=curPage]").val(sch.curPage)
				pageFunc(sch.startBlock, sch.endBlock)
				var html = ""
				$(deptPage.dlist).each(function(idx, dept) {
					html += "<tr ondblclick='goDetail(" + dept.deptno + ")'>"
					html += "<td>" + dept.cnt + "</td>"
					html += "<td>" + dept.deptno + "</td>"
					html += "<td>" + dept.dname + "</td>"
					html += "</tr>"
				})
				$("tbody").html(html)
			},
			error : function(err) {
				console.log(err)
			}
		})
	}
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
					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">부서관리</h1>
					<p class="mb-4">부서 목록입니다.</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary"></h6>
						</div>
						<nav
							class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
							<!-- Sidebar Toggle (Topbar) -->
							<button id="sidebarToggleTop"
								class="btn btn-link d-md-none rounded-circle mr-3">
								<i class="fa fa-bars"></i>
							</button>
							<!-- 제목 검색폼 -->
							<form id="frm01"
								class="d-sm-flex d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 justify-content-between go"
								method="post">
								<input type="hidden" name="curPage" value="1" />
								<div class="input-group">
									<input id="schDname" type="text"
										class="form-control bg-light border-0 small"
										placeholder="부서명 검색" aria-label="Search"
										aria-describedby="basic-addon2" name="dname"
										value="${sch.dname}">
									<div class="input-group-append">
										<button id="schBtn" class="btn btn-primary" type="button">
											<i class="fas fa-search fa-sm"></i>
										</button>
									</div>
								</div>

								<!-- 보일 페이지수 설정 -->
								<div class="input-group mt-3 mb-0">
									<span class="input-group-text" id="totCnt"></span> <span
										class="input-group-text">페이지수</span> <select name="pageSize"
										class="form-control" aria-label="Page size">
										<option>3</option>
										<option selected>5</option>
										<option>10</option>
										<option>20</option>
										<option>50</option>
									</select>
								</div>
								<script type="text/javascript">
									$("[name=pageSize]").change(function() {
										$("[name=curPage]").val(1)
										$("#schBtn").click()
									})
								</script>
							</form>
						</nav>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-hover table-bordered" id="dataTable"
									width="100%" cellspacing="0">
									<col width="10%">
									<col width="20%">
									<col width="70%">
									<thead>
										<tr class="text-center">
											<th>번호</th>
											<th>부서번호</th>
											<th>부서명</th>
										</tr>
									</thead>
									<tbody>

									</tbody>
								</table>

								<ul class="pagination ga">

								</ul>
								<script type="text/javascript">
									function pageFunc(stBlk, enBlk) {
										var curPg = $("[name=curPage]").val()
										var pageHTML = '<li class="page-item"><a class="page-link" href="javascript:goPage('
												+ (stBlk - 1)
												+ ')">Previous</a></li>'
										for (var pNo = stBlk; pNo <= enBlk; pNo++) {
											pageHTML += '<li class="page-item '
													+ (pNo == curPg ? 'active'
															: '') + '">'
											pageHTML += '<a class="page-link" href="javascript:goPage('
													+ pNo
													+ ')">'
													+ pNo
													+ '</a>'
											pageHTML += '</li>'
										}
										pageHTML += '<li class="page-item"><a class="page-link" href="javascript:goPage('
												+ (enBlk + 1)
												+ ')">Next</a></li>'
										console.log(pageHTML)
										$(".pagination").html(pageHTML)
									}

									function goPage(no) {
										//alert(no)
										$("[name=curPage]").val(no)
										$("#schBtn").click()
									}
								</script>
							</div>
						</div>
					</div>

					<div class="my-2"></div>
					<c:if test="${empResult.auth == '인사관리자'}">
						<div class="d-sm-flex justify-content-between">
							<div></div>
							<a id=regBtn href=${path}/deptReg.do
								class="btn btn-success btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
							</span> <span class="text">부서등록</span>
							</a>
						</div>
					</c:if>
					<div class="my-2"></div>
					<!-- buttons -->

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

	<!-- Page level plugins -->
	<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>

</body>
</html>