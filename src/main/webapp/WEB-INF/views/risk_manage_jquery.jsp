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
<title>Risk 승인대기</title>
<style>
td {
  text-align: center; /* td 안의 요소를 가운데 정렬합니다. */
}

.checkbox-container {
  display: flex; /* 체크박스와 스팬을 수평으로 배치하기 위해 flex를 사용합니다. */
  align-items: center; /* 수직 가운데 정렬을 위해 align-items 속성을 사용합니다. */
  justify-content: center; 
  cursor: pointer;
  font-size: 18px;
}

.checkbox-container input {
  display: none; /* 체크박스를 화면에서 숨깁니다. */
}

.checkmark {
  position: relative; /* 체크박스 위치를 설정하기 위해 상대 위치로 설정합니다. */
  display: inline-block; /* 인라인 요소로 설정하여 다른 요소들과 같은 라인에 표시합니다. */
  width: 25px;
  height: 25px;
  border: 1px solid #ccc; /* 체크박스 외곽선을 설정합니다. */
  border-radius: 3px; /* 체크박스의 모서리를 둥글게 만듭니다. */
}

.checkbox-container input:checked + .checkmark::after {
  content: "\2714"; /* 체크 표시를 유니코드로 설정합니다. */
  position: absolute; /* 절대 위치로 설정하여 체크 표시를 체크박스 내부에 배치합니다. */
  top: 50%; /* 체크 표시를 체크박스의 중앙에 배치하기 위해 상단 여백을 50%로 설정합니다. */
  left: 50%; /* 체크 표시를 체크박스의 중앙에 배치하기 위해 왼쪽 여백을 50%로 설정합니다. */
  transform: translate(-50%, -50%); /* 체크 표시를 수평 및 수직으로 중앙에 정렬합니다. */
  font-size: 18px; /* 체크 표시의 크기를 설정합니다. */
  color: #2196F3; /* 체크 표시의 색상을 설정합니다. */
}

</style>  

     <!-- Custom fonts for this template-->
    <link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">

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
                    <h1 class="h3 mb-2 text-gray-800">Risk 승인대기</h1>

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
                                        <tr class="text-center">                                        	
                                            <th>번호</th>
                                            <th>프로젝트명</th>
                                            <th>리스크명</th>                                            
                                            <th>위험도</th>                                            
                                            <th>등록일자</th>
                                            <th>완료일자</th>
                                            <th>등록자</th>
                                            <th>check</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<c:forEach var="rl" items="${riskList}">
											<tr class="text-center" data-riskNo="${rl.riskNo}" ondblclick="goDetail(${rl.riskNo})">
												<td class="text-center">${rl.cnt}</td>
												<td class="text-left">${rl.prjName}</td>
												<td class="text-left">${rl.riskName}</td>
												<td>${rl.dangerStep}</td>
												<td><fmt:formatDate value="${rl.uploadDate}" pattern="YYYY-MM-DD"/></td>
												<td><fmt:formatDate value="${rl.completeDate}" pattern="YYYY-MM-DD"/></td>
												<td>${rl.ename}</td>
												<td>
													<label class="checkbox-container">
														<input type="checkbox">
														<span class="checkmark"></span>
													</label>
												</td>
											</tr>
										</c:forEach>
                                    </tbody>
                                </table>
								<div class="d-sm-flex justify-content-between">
									<div></div>
										<div>
											<a onclick="getCheckedRows('allow')" class="btn btn-success btn-icon-split"> <span
												class="icon text-white-50"> <i class="fas fa-check"></i>
											</span> <span class="text">일괄승인</span>
											</a>		
											
											<a onclick="getCheckedRows('deny')" class="btn btn-danger btn-icon-split"> <span
												class="icon text-white-50"> <i class="fas fa-undo"></i>
											</span> <span class="text">반려</span>
											</a>								
										</div>
								</div>
								<script>
									function getCheckedRows(riskStatus) {
									    var table = document.getElementById("dataTable");
									    var checkBoxes = table.querySelectorAll('input[type="checkbox"]');
									    var checkedRows = [];
									
									    checkBoxes.forEach(function(checkbox) {
									        if (checkbox.checked) {
									        	
									            var row = checkbox.closest('tr'); // 가장 가까운 tr 요소를 찾음
									            var riskNo = row.getAttribute('data-riskNo');
									            checkedRows.push(riskNo);
									            
									        }
									    });
									
									    if (checkedRows.length > 0) {
									        //alert("Checked rows: " + checkedRows.join(", "));
									        if(riskStatus == "allow"){
									        	 if(confirm(checkedRows.length+"건을 승인하시겠습니까?")){
									        		var url = "${path}/allowRisk?"
										        	for (var i = 0; i < checkedRows.length; i++) {
										        	    url += "riskNo=" + checkedRows[i]
										        	    if (i<checkedRows.length-1){
										        	    	url += "&"
										        	    }
										        	}
									        		location.href = url;
									        	}
									        }
									        				        
									        else if(riskStatus == "deny"){
									        	 if(confirm(checkedRows.length+"건을 반려하시겠습니까?")){
										        	var url = "${path}/denyRisk?"
												    for (var i = 0; i < checkedRows.length; i++) {
												        url += "riskNo=" + checkedRows[i]
												        if (i<checkedRows.length-1){
												        	url += "&"
												        }
												    }
											        location.href = url;
									        	}
									        }					        
									    } else {
									        alert("체크된 리스크가 없습니다.");
									    }
									}
								</script>

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

</body>
</html>