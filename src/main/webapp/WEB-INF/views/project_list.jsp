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
<title>Project List</title>




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
<style type="text/css">
#input-group-prepend {
	width: 20%;
}
#input-group-text {
	width: 100%;
}

</style>
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
		searchProject()
		
		$("#schBtn").click(function(){
			searchProject()
		})
		
		$("#schPrj").keyup(function(){
			searchProject()
		})
		
		$("#frm01").on("keypress", function(e){
			if(e.keyCode==13){
				e.preventDefault()
				searchProject()
			}
		})
		
		$("[name=pageSize]").change(function(){
			$("[name=curPage]").val(1)
			$("#schBtn").click()
		})
		
		$("#regBtn").click(function(){
			if($("#prjName").val() == ""){
				alert("프로젝트명을 입력하세요.")
				return
			}
			if($("#prjPriority").val()==""){
				alert("프로젝트 중요도를 입력하세요.")
				return
			}
			if($("#prjAcceptDateStr").val()==""){
				alert("프로젝트 수주일을 입력하세요.")
				return
			}
			if($("#beginDateStr").val()==""){
				alert("프로젝트 시작일 입력하세요.")
				return
			}
			if($("#endDateStr").val()==""){
				alert("프로젝트 마감일을 입력하세요.")
				return
			}
			if($("#teamName").val()==""){
				alert("팀명을 입력하세요.")
				return
			}

			if(confirm("등록하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"${path}/insertProject",
					data:$("#frm02").serialize(),
					dataType:"json",
					success:function(data){
						alert(data.msg)
						searchProject()
						$("#clsBtn").click()
						$("#md01").click()
						$("#frm02")[0].reset()
						$("#teamMateList").html('')
					},
					error:function(err){
						console.log(err)
					}
				})
			}
		})
		
		$("#tmBtn").click(function(){
			transferData()
			$("#clsBtn2").click()
			$("#md02").click()
		})
		
	});
	
	function goDetail(prjNo){
		location.href="${path}/getProjectBasic.do?prjNo="+prjNo
	}	
	
	function searchProject(){
		$.ajax({
			url : "${path}/projectListJson",
			data : $("#frm01").serialize(),
			type : "post",
			dataType : "json",
			success : function(project){
				var sch = project.sch
				console.log(sch)
				$("#totCnt").text("총 " + sch.count + "건")
				$("[name=curPage]").val(sch.curPage)
				pageFunc(sch.startBlock, sch.endBlock)
				var html = ""
				$(project.pblist).each(function(idx, proj){
					html += "<tr ondblclick='goDetail("+proj.prjNo+")'>"
					html += "<td>"+proj.cnt+"</td>"
					html += "<td>"+proj.prjName+"</td>"
					html += "<td>"+formatDate(proj.prjBegin)+"</td>"
					html += "<td>"+formatDate(proj.prjEnd)+"</td>"
					html += "<td>"+proj.prjPriority+"</td>"
					html += "<td>"+proj.prjStep+"</td>"
					html += "</tr>"
				})		
				$("tbody").html(html)
			},
			error : function(err){
				console.log(err)
			}
		})
	}
	
	function pageFunc(stBlk, enBlk ){
		var curPg = $("[name=curPage]").val()
		var pageHTML = '<li class="page-item"><a class="page-link" href="javascript:goPage('+(stBlk-1)+')">Previous</a></li>'
		for(var pNo = stBlk;pNo<=enBlk;pNo++){
			pageHTML += '<li class="page-item '+(pNo==curPg?'active':'')+'">'
			pageHTML += '<a class="page-link" href="javascript:goPage('+pNo+')">'+pNo+'</a>'
			pageHTML += '</li>'
		}
		pageHTML += '<li class="page-item"><a class="page-link" href="javascript:goPage('+(enBlk+1)+')">Next</a></li>'
	    $(".pagination").html(pageHTML)
	}
    
    
	function goPage(no){
		//alert(no)
		$("[name=curPage]").val(no)
		$("#schBtn").click()
	}
	
    // 데이터 전송 함수
    var empNoList = [];
    function transferData() {
        var empno = parseInt($("select[name='empno']").val());
		
        // 데이터 전송
        empNoList.push(empno);
        console.log(empno);
        console.log(empNoList);
        $("#teamMateList").append(
        	"<div class='input-group-prepend' id='input-group-prepend'><span class='input-group-text  justify-content-center' id='input-group-text'>팀원</span></div>"
        	+ "<input type='hidden' name='empno' id='empno' class='form-control' value='"+empNoList+"' placeholder='팀원 선택'/>"
			+ "<span class='form-control'>"+empno+"</span>");
        // 모달 닫기
        $("#insertTeamMateModal").modal("hide");
    }
	
	
	// Function to format date
	function formatDate(dateString) {
	    var date = new Date(dateString);
	    var formattedDate = date.getFullYear() 
	    					+ "-" + padZero(date.getMonth() + 1) 
	    					+ "-" + padZero(date.getDate());
	    return formattedDate;
	}

	// Function to pad zero for single-digit month or date
	function padZero(value) {
	    return value < 10 ? "0" + value : value;
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
				<%@ include file="inc/topBar.jsp"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

                     <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Project List</h1>

<p>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Project Tables</h6>
							<!-- Topbar Search -->
							<form id="frm01" method="post"
								class="d-none d-sm-inline-block form-inline mr-ml-md-3 my-2 my-md-0 w-100 navbar-search">
								<div class="input-group mt-3 mb-0">
									<input type="hidden" name="curPage" value="1"/>
									<input name="prjName" id="schPrj" type="text" class="form-control border-0 small w-70"
										value="${sch.prjName}" placeholder="Project Name" aria-label="Search"
										aria-describedby="basic-addon2">
									<div class="input-group mr-3">
										<button id="schBtn" class="btn btn-primary" type="button">
											<i class="fas fa-search fa-sm"></i>
										</button>
									</div>
									<div class="input-group ml-auto">
									    <span class="input-group-text" id="totCnt"></span>
									    <span class="input-group-text">리스트 수</span>
									    <select name="pageSize" class="form-control" aria-label="Page size">
									        <option>3</option>
									        <option>5</option>
									        <option selected>10</option>
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
                                            <th>시작일</th>                                            
                                            <th>종료일</th>                                            
                                            <th>중요도</th>
                                            <th>진행단계</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
								<div class="d-sm-flex justify-content-between">
									<div></div>
									<a id="insertModal" href="#" class="btn btn-primary btn-icon-split"
									   data-toggle="modal" data-target="#insertProjectModal">
										<span class="icon text-white-50"> <i
											class="fas fa-arrow-right"></i>
									</span> <span class="text">신규등록</span>
									</a>
								</div>
									<ul class="pagination justify-content-center">
									</ul>
                            </div>
                        </div>
                    </div>
  

				</div>
				<!-- /.container-fluid -->
				
			</div>
			<!-- End of Main Content -->

			<!-- Insert Project -->
			<div class="modal fade" id="insertProjectModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalCenterTitle"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
						<!-- Project Basic -->
							<div class="modal-header">
								<h5 class="modal-title" id="prjTitle">프로젝트 등록</h5>
								<button type="button" class="close" id="md01" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<form id="frm02" class="form" method="post">
							<div class="modal-body">
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												프로젝트명</span>
										</div>
										<input type="text" name="prjName" id="prjName" class="form-control" value="" placeholder=""/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												중요도</span>
										</div>
										<select name="prjPriority" id="prjPriority" class="form-control">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>								
										</select> 
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												수주일</span>
										</div>
										<input type="date" name="prjAcceptDateStr" id="prjAcceptDateStr" class="form-control" />
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												시작일</span>
										</div>
										<input type="date" name="beginDateStr" id="beginDateStr" class="form-control"/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												종료일</span>
										</div>
										<input type="date" name="endDateStr" id="endDateStr" class="form-control"/>
									</div>
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												진행단계</span>
										</div>
										<select name="prjStep" id="prjStep" class="form-control">
											<option value="Designing">설계</option>
											<option value="Developing">개발</option>
											<option value="Testing">테스트</option>
											<option value="Debugging">디버깅</option>
										</select>
									</div>
							</div>
							<!-- End of Project Basic -->
							
							<!-- Project Team -->
							<div class="modal-header">
								<h5 class="modal-title" id="prjTitle">팀 등록</h5>
							</div>
							<div class="modal-body">
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												팀명</span>
										</div>
										<input type="text" name="teamName" id="teamName" class="form-control" value="" placeholder="팀명 입력">
											<a id="insertModal" href="#" class="btn btn-primary btn-icon-split"
											   data-toggle="modal" data-target="#insertTeamMateModal">
												<span class="icon text-white-50"> <i class="fas fa-arrow-right"></i></span>
											</a>
										</input>
									</div>
									<div class="input-group mb-3" id="teamMateList">										
									</div>
							</div>
							</form>
							<!-- End of Project Team -->
							<div class="modal-footer">
								<a id="regBtn" href="#" class="btn btn-primary btn-icon-split">
									<span class="icon text-white-50"> <i
										class="fas fa-arrow-right"></i>
								</span> <span class="text">프로젝트 등록</span>
								</a>
								<button type="button" id="clsBtn" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			<!-- End of Insert Project -->
			
			<!-- Insert TeamMate -->
			<div class="modal fade" id="insertTeamMateModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalCenterTitle"
					aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="teamMateTitle">팀원 등록</h5>
								<button type="button" class="close" id="md02" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form id="frm04" class="form" method="post">
									<div class="input-group mb-3">
										<div class="input-group-prepend " id="input-group-prepend">
											<span class="input-group-text  justify-content-center" id="input-group-text">
												팀원</span>
										</div>
										<select name="empno"  class="form-control" >
											<option value="">팀원 선택</option>
											<c:forEach var="emp" items="${empList}">
												<option value="${emp.empno}">${emp.ename}[${emp.dname}|${emp.job}]</option>
											</c:forEach>
										</select>	
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<a id="tmBtn" href="#" class="btn btn-primary btn-icon-split">
									<span class="icon text-white-50"> <i
										class="fas fa-arrow-right"></i>
								</span> <span class="text">팀원 등록</span>
								</a>
								<button type="button" id="clsBtn2" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
							<script type="text/javascript">
								
							</script>
						</div>
					</div>
				</div>
			<!-- End of Insert TeamMate -->


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