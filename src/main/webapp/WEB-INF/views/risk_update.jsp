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
<title>insertRisk</title>

     <!-- Custom fonts for this template-->
    <link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
    
<style type="text/css">
.fileform{
	display: none;
}
#fileList{
	padding-bottom: 10px;
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
	width: 98%;
	margin: auto;
	height: 400px;
	overflow-y: auto;
	text-align: left;
}

.input-group-prepend {
	width: 10%;
}
.input-group-text {
	width: 100%;
}
</style>

<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var msg = "${msg}" 
			if(msg!=""){
				if(!confirm(msg+"\n계속 수정하시겠습니까?")){
					location.href="${path}/riskList"
				}
				//$("form")[0].reset() // 초기화처리(모델데이터 입력된 내용)
			}	
		$("#uptBtn").click(function() {
			if($("[name=riskName]").val() == ""){
				alert("리스크명을 입력하세요.")
				return
			}
			if($("[name=riskContent]").val()==""){
				alert("리스크 정보를 입력하세요.")
				return
			}
			if(confirm("수정하시겠습니까?")){				
				$("form").submit()
			}
		})
	});
	
    function displayFileNames() {
        var fileListContainer = document.getElementById('customFile');
        var files = fileListContainer.files;
        var fileListDiv = document.getElementById('fileList');
        fileListDiv.innerHTML = ''; // Clear previous list
        
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            var fileSize = getFileSize(file.size);
            
            var listItem = document.createElement('div');
            listItem.className = 'file-item';
            
            var fileNameNode = document.createTextNode(file.name + ' (' + fileSize + ')');
            listItem.appendChild(fileNameNode);
            
            fileListDiv.appendChild(listItem);
        }
    }

    function getFileSize(size) {
        if (size === 0) return '0 Bytes';
        var k = 1024;
        var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
        var i = Math.floor(Math.log(size) / Math.log(k));
        return parseFloat((size / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
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
                        	<h6 class="m-0 font-weight-bold text-primary">리스크 수정</h6>
                        </div>
                        <div class="card-body">
							<form method="post" enctype="multipart/form-data" action="${path}/updateRisk">
								<div class="input-group mb-3">	
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											프로젝트명*</span>
									</div>
									<c:forEach var="proj" items="${projectByPrjNo2}">
										<span class="form-control">${proj.prjName}</span>
									</c:forEach>
								</div>	
								
								<div class="input-group mb-3">	
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											작성자(*)</span>
									</div>		
									<c:forEach var="emp" items="${empByEmpNo}">
										<span class="form-control">${emp.ename}</span>
									</c:forEach>		
									<!-- 
									session값에 있는 id로 작성자를 자동등록하게 처리.
									==> 수정삭제시에 현재 로그인한 session의 id와 작성자의 id가 
									동일할 때만 수정/삭제처리 가능하게 한다.
									-->	
								</div>	
								<input type="hidden" name="riskNo" class="form-control" value="${riskDetail.riskNo}"/>
								<div class="input-group mb-3">	
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											리스크명*</span>
									</div>	
									<input name="riskName" class="form-control" value="${riskDetail.riskName}"/>	
								</div>	
								
								<div class="input-group mb-3">	
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											첨부파일</span>
									</div>
										<c:choose>
											<c:when test="${empty riskDetail.fnames}"><input type="file" name="reports" multiple="multiple" class="form-control" id="customFile" multiple onchange="displayFileNames()"/></c:when>
											<c:otherwise>
												<c:forEach var="fname" items="${riskDetail.fnames}">
													<input type="file" name="reports" multiple="multiple" class="form-control" id="customFile"
														   multiple onchange="displayFileNames()" value="${fname}"/>
													<i role="button" class="fa fa-remove text-danger" onclick="removeFile('${fname}')"></i>
												</c:forEach>
											</c:otherwise>
										</c:choose>
								</div>	
								<div id="fileList"></div>
									
								<div class="input-group mb-3">	
									<div class="input-group-prepend ">
										<span class="input-group-text  justify-content-center">
											리스크 내용</span>
									</div>
									<textarea id="chatArea" name="riskContent" class="form-control">${riskDetail.riskContent}</textarea>	
								</div>
							</form>
							<!-- 버튼 div -->
							<div class="my-2"></div>
							<div class="d-sm-flex justify-content-between">
								<div></div>
	
								<div>
									<a id="uptBtn" class="btn btn-info btn-icon-split"> <span
										class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
									</span> <span class="text">수정하기</span>
									</a>
									
									<a href="${path}/riskList"
										class="btn btn-secondary btn-icon-split"> <span
										class="icon text-white-50"> <i
											class="fas fa-arrow-right"></i>
									</span> <span class="text">목록으로</span>
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

</body>
</html>