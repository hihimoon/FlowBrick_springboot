<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style type="text/css">
        .custom-file-input {
            display: inline-block;
            cursor: pointer;
            font-size: 14px;
            line-height: 1.5;
            color: #495057;
            padding: .375rem .75rem;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
        }

        .custom-file-input:focus {
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 0 .2rem rgba(0,123,255,.25);
        }

        .custom-file-label {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        /* 숨겨진 기본 파일 업로드 버튼 */
        .custom-file-input[type=file] {
            visibility: hidden;
            width: 0;
        }

        /* 대체된 파일 업로드 버튼 스타일링 */
        .custom-file-label::after {
            content: '찾아보기';
        }

        .custom-file-input[type=file]:not(:disabled) ~ .custom-file-label::after {
            cursor: pointer;
        }

        /* 선택된 파일명 스타일링 */
        .custom-file-input[aria-describedby][multiple]:not(:last-child) ~ .custom-file-label::after {
            content: ', ';
        }

#chatArea {
	width: 98%;
	margin: auto;
	height: 400px;
	overflow-y: auto;
	text-align: left;
	border: 0.5px solid green;
	font-size: 20px;
}

.form_c{
    font-size: 20px;
    margin: auto;
    width: 98%;
}

</style>

<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
	<script type="text/javascript">
	var sessId = "${empResult.empno}"
		if (sessId == "") {
			alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
			location.href = "${path}/login.do"
		}
	$(document).ready(function() {
        const label_tmp = document.querySelector('.custom-file-label');
        
        var fnamesString = "${notice.fnames}";
        var fnamesList = fnamesString.split(',');
		
		$("#uptBtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				$("form").attr("action","${path}/updateNotice.do")
				$("form").submit()
			}  		 
		})
		
	});

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
				<form method="post" enctype="multipart/form-data">
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                        	<!--  
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                            -->
                            <h1 class="h4 mb-2 text-gray-800 font-weight-bold">제목</h1>
 								<input type="text" class="h3 mb-2 text-gray-800 form-control form_c bg-light"
									placeholder="제목 검색" aria-label="Search"
									aria-describedby="basic-addon2" name="title"
									value="${notice.title}">                           
                            <div class="d-sm-flex justify-content-between">
                           		<input type="hidden" name="no" class="form-control" value="${notice.no}" />
                           		<input type="hidden" name="writer" class="form-control" value="${notice.writer}" />
                           		<input type="hidden" name="readcnt" class="form-control" value="${notice.readcnt}" />
                            </div>
                        </div>
                        <div class="card-body bg-gray-200 contents">
                        	<div class="contents">
                        		<h4 class="h4 mb-2 text-gray-800 font-weight-bold">내용</h4>
                        		<textarea id="chatArea" name="content" class="form-control">${notice.content}</textarea>
                        	</div>
                        </div>
                    </div>
                    <!-- 첨부파일 -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="form_c m-0 font-weight-bold text-primary">첨부파일</h6>
						</div>
						<div class="card-body d-sm-flex">
								<div class="custom-file">
									<input type="file" name="reports" class="custom-file-input" id="customFile"
										multiple onchange="displayFileNames()"> 
									<label
										class="custom-file-label" for="customFile">
										<c:choose>
											<c:when test="${empty notice.fnames}">파일을 선택하세요</c:when>
											<c:otherwise>
												<c:forEach var="fname" items="${notice.fnames}">
													<span calss="font weight-bold" role="button">${fname} </span>
													<i role="button" class="fa fa-remove text-danger" onclick="removeFile('${fname}')"></i>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</label>
								</div>				
						</div>
						<script type="text/javascript">
						function displayFileNames() { // 업로드한 파일을 선택했을때 표시하는 함수
						    const input = document.getElementById('customFile');
						    const label = document.querySelector('.custom-file-label');
						    const files = input.files;

						    if (files.length > 0) {
						    	label.innerHTML += ", "
						        let fileDetails = ""; // 각 파일의 파일명과 크기를 저장할 문자열 변수

						        Array.from(files).forEach(file => {
						            const fileSize = formatFileSize(file.size); // 파일 크기를 사람이 읽기 쉬운 형식으로 변환
						            fileDetails += file.name + " [" + fileSize + "], "; // 파일명과 크기를 추가
						        });

						        // 마지막 쉼표 제거 후 레이블에 파일명과 크기 표시
						        label.innerHTML = "<span role='button'> " + fileDetails.slice(0, -2) + " </span>";
						    }
						}
						
						function formatFileSize(sizeInBytes) {
						    const kilobyte = 1024;
						    const megabyte = kilobyte * 1024;

						    if (sizeInBytes > megabyte) {
						        return (sizeInBytes / megabyte).toFixed(2) + ' MB';
						    } else if (sizeInBytes > kilobyte) {
						        return (sizeInBytes / kilobyte).toFixed(2) + ' KB';
						    } else {
						        return sizeInBytes + ' bytes';
						    }
						}
					    function removeFile(fname) {
					    	if(confirm(fname+"을 삭제하시겠습니까?")){
					    		location.href="${path}/deleteFile.do?fname="+fname+"&no="+${notice.no}
					    	}		   		
						}
					    </script>
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
													
							<a href="${path}/notice.do" class="btn btn-secondary btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
							</span> <span class="text">목록으로</span>
							</a>
						</div>

					</div>
				</form>
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

</body>
</html>