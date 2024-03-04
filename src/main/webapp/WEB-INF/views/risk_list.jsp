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
<title>Risk List</title>




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
 
 
     <!-- Custom fonts for this template-->
    <link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
 <script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var sessId = "${empResult.empno}"
			if (sessId == "") {
				alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
				location.href = "${path}/login.do"
			}
		$("#regBtn").click(function(){
			location.href="${path}/insertRiskFrm"
		})
		// 선택된 페이지 사이즈를 다음 호출된 페이지에서 출력
		$("[name=pageSize]").val("${sch.pageSize}")
		// 페이지크기를 변경했을 때, 선택된 페이지를 초기페이지로 설정..
		$("[name=pageSize]").change(function(){
			$("[name=curPage]").val(1)
			$("form").submit()
		})
	});
	function goPage(pcnt){
		$("[name=curPage]").val(pcnt)
		$("form").submit();
	}
	function goDetail(riskNo){
		location.href="${path}/riskDetail?riskNo="+riskNo
	}
</script>
 
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="inc/sliderBar.jsp" %>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar    -->
				<%@ include file="inc/topBar.jsp" %>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

                     <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Risk List</h1>

<p>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Risk Tables</h6>
							<!-- Topbar Search -->
							<form id="frm01" method="post"
								class="d-none d-sm-inline-block form-inline mr-ml-md-3 my-2 my-md-0 w-100 navbar-search">
								<div class="input-group mt-3 mb-0">
										<input type="hidden" name="curPage" value="${sch.curPage}"/>
									<div class="input-group mr-3">
										<input name="prjName" id="schPrj" type="text" class="form-control border-0 small w-70"
											value="${sch.prjName}" placeholder="Project Name" aria-label="Search"
											aria-describedby="basic-addon2">
									</div>
									<div class="input-group mr-3">
										<input name="ename" id="schEname" type="text" class="form-control border-0 small w-70"
											value="${sch.ename}" placeholder="Writer Name" aria-label="Search"
											aria-describedby="basic-addon2">
									</div>
									<div class="input-group mr-3">
										<input name="riskName" id="schRiskName" type="text" class="form-control border-0 small w-70"
											value="${sch.riskName}" placeholder="Risk Name" aria-label="Search"
											aria-describedby="basic-addon2">
									</div>
									<div class="input-group mr-3">
										<button id="schBtn" class="btn btn-primary" type="submit">
											<i class="fas fa-search fa-sm"></i>
										</button>
									</div>
									<div class="input-group ml-auto">
									    <span class="input-group-text" id="totCnt">총 ${sch.count} 건</span>
									    <span class="input-group-text">리스트 수</span>
									    <select name="pageSize" class="form-control" aria-label="Page size">
									        <option>3</option>
									        <option>5</option>
									        <option>10</option>
									        <option>20</option>
									        <option>50</option>
									    </select>
									</div>
								</div>
							</form>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>                                        	
                                            <th>번호</th>
                                            <th>프로젝트명</th>
                                            <th>리스크명</th>                                            
                                            <th>위험도</th>                                            
                                            <th>등록일자</th>
                                            <th>완료일자</th>
                                            <th>등록자</th>
                                            <th>상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<c:forEach var="rl" items="${riskList}">
											<tr ondblclick="goDetail(${rl.riskNo})">
												<td class="text-center">${rl.cnt}</td>
												<td>${rl.prjName}</td>
												<td>${rl.riskName}</td>
												<td>${rl.dangerStep}</td>
												<td><fmt:formatDate value="${rl.uploadDate}" pattern="yyyy-MM-dd"/></td>
												<td><fmt:formatDate value="${rl.completeDate}" pattern="yyyy-MM-dd"/></td>
												<td>${rl.ename}</td>
												<td>${rl.state}</td>
											</tr>
										</c:forEach>
                                    </tbody>
                                </table>
								<div class="d-sm-flex justify-content-between">
									<div></div>
									<a id=regBtn href="#" class="btn btn-primary btn-icon-split">
										<span class="icon text-white-50"> <i
											class="fas fa-arrow-right"></i>
									</span> <span class="text">신규등록</span>
									</a>
								</div>
									<ul class="pagination justify-content-center">
										<li class="page-item">
											<a class="page-link"
												href="javascript:goPage(${sch.startBlock-1})">Previous</a></li>
										  <c:forEach var="pcnt" begin="${sch.startBlock}" 
										  						end="${sch.endBlock}">
										  <li class="page-item ${sch.curPage==pcnt?'active':''}">
										  	<a class="page-link" href="javascript:goPage(${pcnt})">${pcnt}</a></li>
										  </c:forEach>
									  <li class="page-item"><a class="page-link" 
									  	href="javascript:goPage(${sch.endBlock+1})">Next</a></li>
									</ul>
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
	<a class="scroll-to-top rounded" href="#page-top"> 
		<i class="fas fa-angle-up"></i>
	</a>
	<!-- Logout Modal-->
	<%@ include file="inc/logout_modal.jsp" %>
	
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

<!-- Page level custom scripts -->
<script src="${path}/a00_com/js/demo/chart-area-demo.js"></script>
<script src="${path}/a00_com/js/demo/chart-pie-demo.js"></script>	
</body>
</html>