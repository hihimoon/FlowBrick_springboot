<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
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


	var proc="${proc}"
	var msg = "${msg}"
	
	if(proc!=""){
		if(proc=="upt"){
			if(confirm(msg+"\n메인화면으로 이동하시겠습니까?")){
				location.href="${path}/projectList"
			}
		}
		if(proc=="del"){
			alert(msg+"\n메인화면으로 이동")
			location.href="${path}/projectList"
		}
	}
	
	
	
	$(document).ready(function(){

		
		//수정기능
		$("#uptBtn").click(function(){
			if(confirm("수정하시겠습니까?")){
			$("form").attr("action","${path}/uptPrjBasic.do")
			$("form").submit()
			}
		})
		
		
		
		
		
		
		
		//프로젝트리스트 이동기능
		$("#mainBtn").click(function(){
			location.href="${path}/projectList"
		})
		
		
		//삭제
		$("#delBtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href="${path}/delPrjBasic.do?prjNo="+$("[name=prjNo]").val()		
			}
		})
		
		
		//자원 이동기능
		$("#resourceBtn").click(function(){
			location.href="${path}/resource.do?prjNo="+$("[name=prjNo]").val()
		})
		
		
	})
	
	



	
	
	
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









<div class="jumbotron text-center">
  <h2>프로젝트 상세 항목</h2>
</div>
<div class="container">
	<form method="post">
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트  번호</span>
		</div>
		<input type="text" name="prjNo" class="form-control" readonly value="${project.prjNo}" />	
	</div>
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트  이름</span>
		</div>
		<input type="text" name="prjName" class="form-control"  value="${project.prjName}" />	
	</div>
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트중요도</span>
		</div>
		<input name="prjPriority" class="form-control"  value="${project.prjPriority}" />	
	</div>
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트수주일</span>
		</div>
		<input type="date" class="form-control" 
		readonly value="<fmt:formatDate value="${project.prjAcceptDate}" pattern="yyyy-MM-dd"/>" />
	</div>
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트시작일</span>
		</div>
		<input type="date" name="beginDateStr" class="form-control"  
		value="<fmt:formatDate value="${project.prjBegin}" pattern="yyyy-MM-dd"/>" />	
	</div>
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트종료일</span>
		</div>
		<input type="date" name="endDateStr" class="form-control"  
		value="<fmt:formatDate value="${project.prjEnd}" pattern="yyyy-MM-dd"/>" />	
	</div>
	<div class="input-group mb-0">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트 단계</span>
		</div>
		<input type="text" name="prjStep" class="form-control"  value="${project.prjStep}" />	
	</div>
	<div style="text-align:right;">
		<input type="button" class="btn btn-light" value="자원현황" id="resourceBtn"/>
		<input type="button" class="btn btn-warning" value="수정" id="uptBtn"/>
		<input type="button" class="btn btn-danger" value="삭제" id="delBtn"/>
		<input type="button" class="btn btn-success" value="조회리스트" id="mainBtn"/>
	</div>	
	</form>		
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
