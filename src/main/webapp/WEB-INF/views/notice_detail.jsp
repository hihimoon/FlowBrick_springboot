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
<title>noticeList</title>

<!-- Custom fonts for this template-->
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">

<style type="text/css">
.input-group-text {
	width: 100%;
	font-weight: bolder;
}

.input-group-prepend {
	width: 10%;
}

.input-file-button {
	padding: 6px 25px;
	background-color: #FF6600;
	border-radius: 4px;
	color: white;
	cursor: pointer;
}
.fileform{
	display: none;
}

input[type=file]::file-selector-button {
  width: 100px;
  height: 30px;
  background: #fff;
  border: 1px solid rgb(77,77,77);
  border-radius: 10px;
  cursor: pointer;
  &:hover {
    background: rgb(77,77,77);
    color: #fff;
  }
}

#chatArea {
	width: 80%;
	height: 200px;
	overflow-y: auto;
	text-align: left;
	border: 0.5px solid green;
}

.contents{
	height : 500px;
}

.img_file{
	width: 20px;
}

.p1{
	  margin-left:5px;
	  display : flex;
	  justify-content : center;
	  align-items : center;
}

</style>

<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
	<script type="text/javascript">
	var sessId = "${empResult.empno}"
	var auth = "${empResult.auth}"
		if (sessId == "") {
			alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
			location.href = "${path}/login.do"
		}
	var proc="${proc}"
	var msg = "${msg}"
		if(proc!=""){
			if(proc=="upt"){
				if(confirm(msg+"\n메인화면으로 이동하시겠습니까?")){
					location.href="${path}/notice.do"
				}
			}
			if(proc=="del"){
				alert(msg+"\n메인화면으로 이동")
				location.href="${path}/notice.do"
			}
		}
	$(document).ready(function() {
		var no = "${notice.no}"	
		$("#uptBtn").click(function(){
			if(auth != "관리자"){
				alert("권한이 없습니다")
				return
			}
			location.href="${path}/updateNoticeFrm.do?no="+no
		})
		$("#delBtn").click(function(){ 
			if(auth != "관리자"){
				alert("권한이 없습니다")
				return
			}
			if(confirm("삭제하시겠습니까?")){
				location.href="${path}/deleteNotice.do?no="+no		
			}		
		})
	});
	function download(fname){
		if( confirm(fname+" 다운로드 하시겠습니까?")){
			location.href="${path}/download.do?fname="+fname
		}
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

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                        	<!--  
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                            -->
                            <h1 class="h3 mb-2 text-gray-800">${notice.title}</h1>
                            <div class="d-sm-flex justify-content-between">
                            	<p class="mb-4">${notice.writer}</p>
                            	<p class="mb-4">조회수 ${notice.readcnt}</p>
                            </div>
                        </div>
                        <div class="card-body bg-gray-200 contents">
                        	<div class="contents">
                        		<h4>${notice.content}</h4>
                        	</div>
                        </div>
                    </div>
                    <!-- 첨부파일 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">첨부파일</h6>
						</div>
						<div class="card-body">
							<img class="img_file" src="${path}/a00_com/img/file_icon.png">&nbsp&nbsp
							<c:forEach var="fname" items="${notice.fnames}">
								<span ondblclick="download('${fname}')" >${fname}</span>	
							</c:forEach>
						</div>
					</div>
					<!-- 버튼 div -->
					<div class="my-2"></div>
					<div class="d-sm-flex justify-content-between">
						<div></div>  
						
						<div>		
							<a id="uptBtn" class="btn btn-info btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
							</span> <span class="text">수정하기</span>
							</a>
							
							<a id="delBtn" class="btn btn-danger btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-trash"></i>
							</span> <span class="text">삭제하기</span>
							</a>
							
							<a href="${path}/notice.do" class="btn btn-secondary btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
							</span> <span class="text">목록으로</span>
							</a>
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