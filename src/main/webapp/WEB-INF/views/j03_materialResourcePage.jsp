<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
 %>
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

	$(document).ready(function(){
		
		//var loginSession="${empResult.auth}" // 세션처리
		//alert("loginSession : "+loginSession) // 세션처리
		
		// submit 엔터 방지
		$("form").on("keypress",function(e){
			if(e.keyCode==13){ 
				e.preventDefault() 
			}
		})
		
		
		
		//Search버튼 클릭 기능
		$("#schBtn").click(function(){
			$("#frm01").attr("action","${path}/MRList.do")
			$("#frm01").submit()
		})
		
		
		//물적자원 등록 버튼을 클릭하면 열리는 모달창
		$("#regFrmBtn").click(function(){
			$("#MateraiResourceTitle").text("물적자원 등록")
			$("#frm02")[0].reset();
			$("#regBtn").show()
			$("#uptBtn").hide()
			$("#delBtn").hide()
			$("#toRepositoryBtn").hide()
			$("[name=prjNo]").val(${mrsch.prjNo})
			$("[name=prjname]").val("${mrsch.prjname}")
		})

		$("#regBtn").click(function(){
			if(!($("#frm02 [name=productcnt]").val()>0)){
				alert("갯수는 양수여야 합니다.")
			}else{
				$.ajax({
					url:"${path}/insertMR.do",
					data:$("#frm02").serialize(),
					type:"post",
					success:function(data){
						
						alert("입력 성공.")
						location.href="${path}/MRList.do?prjNo="+$("[name=prjNo]").val()+"&prjname="+"${param.prjname}"//$("[name=prjname]").val()
					},
					error:function(err){
						alert(err)
					}
				})
			}
		})
		
		//삭제버튼 클릭
		$("#delBtn").click(function(){
			if(confirm("삭제 하시겠습니까?")){
				$.ajax({
					url:"${path}/delMaterialResource.do",
					data:"materialresourceno="+$("#frm02 [name=materialresourceno]").val(),
					type:"post",
					dataType:"json",
					success:function(data){
						alert(data.msg)
						location.href="${path}/MRList.do?prjNo="+$("[name=prjNo]").val()+"&prjname="+$("[name=prjname]").val()
					},
					error:function(err){
						console.log(err)
					}
				})
			}
		})
		
		
		
		
		
		
		
		//수정버튼 클릭
		$("#uptBtn").click(function(){
			$.ajax({
				url:"${path}/uptMaterialResource.do",
				type:"post",
				dataType:"json",
				data:$("#frm02").serialize(),
				success:function(data){
					alert(data.msg)
					location.href="${path}/MRList.do?prjNo="+$("#frm02 [name=prjNo]").val()+"&prjname="+"${param.prjname}"//$("[name=prjname]").val()
				},
				error:function(err){
					console.log(err)
				}
			})
		})

		
		//비품창고 버튼 클릭
		$("#toRepositoryBtn").click(function(){
			location.href="${path}/repositoryList.do?prjNo="+$("#frm02 [name=prjNo]").val()+"&prjname="+$("[name=prjname]").val()
		})
	})
	
			
	function goDetail(materialresourceno){
		$.ajax({
			url:"${path}/getDetailMR.do",
			data:"materialresourceno="+materialresourceno,
			dataType:"json",
			success:function(data){
				$("#MateraiResourceTitle").text("물적자원 상세")
				$("#regBtn").hide()
				$("#uptBtn").show()
				$("#delBtn").show()
				$("#toRepositoryBtn").show()
				$("#frm02")[0].reset();
				$("#frm02 [name=materialresourceno]").val(data.detailedMR.materialresourceno)
				$("#frm02 [name=prjNo]").val(data.detailedMR.prjNo)
				$("#frm02 [name=prjname]").val(data.detailedMR.prjname)
				$("#frm02 [name=rentorbuy]").val(data.detailedMR.rentorbuy)
				$("#frm02 [name=price]").val(data.detailedMR.price)
				$("#frm02 [name=materialresourcename]").val(data.detailedMR.materialresourcename)
				$("#frm02 [name=productcnt]").val(data.detailedMR.productcnt)
				$("#frm02 [name=facilityloc]").val(data.detailedMR.facilityloc)
				$("#frm02 [name=division]").val(data.detailedMR.division)
			},
			error:function(err){
				console.log(err)
			}
		})

		$("#regFrmBtn").click();
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


<div class="jumbotron text-center">
  <h2>물적 자원 리스트</h2>
</div>

<div class="container">

	<form id="frm01" class="form"  method="post">
	  	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	  	
	  		<input type="hidden" name="curPage" value="${mrsch.curPage}"/>
	  	
		    <input type="hidden" placeholder="프로젝트이름" name="prjname"  value="${mrsch.prjname}" class="form-control mr-sm-2" /> 
		    <input placeholder="물적자원이름" name="materialresourcename"  value="${mrsch.materialresourcename}"  class="form-control mr-sm-2"/>
		    <input type="hidden" name="prjNo"  value="${mrsch.prjNo}"  class="form-control mr-sm-2"/>
		    
		    
		    <button class="btn btn-info" type="button" id="schBtn">Search</button>
		    <button id="regFrmBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" type="button">물적자원 등록</button>
	 	</nav>
	 	
	 	
	 	
	 	<div class="input-group mt-3 mb-0">
		    <span class="input-group-text">총:${mrsch.count}건</span>
		    <input type="text" class="form-control" aria-label="Total count" style="width:70%;">
		    <span class="input-group-text">페이지수</span>
		    <select name="pageSize" class="form-control" aria-label="Page size">
		        <option>3</option>
		        <option>5</option>
		        <option>10</option>
		        <option>20</option>
		        <option>50</option>
		    </select>
		</div>
		
		
		
		<script type="text/javascript">
			// 선택된 페이지 사이즈를 다음 호출된 페이지에서 출력
			$("[name=pageSize]").val("${mrsch.pageSize}")
			// 페이지크기를 변경했을 때, 선택된 페이지를 초기페이지로 설정..
			$("[name=pageSize]").change(function(){
				$("[name=curPage]").val(1)
				$("#frm01").attr("action","${path}/MRList.do")
				$("#frm01").submit()
			})
		</script> 
	
	
	
	</form>
	
   <table class="table table-hover table-bordered" width="100%" cellspacing="0">
   	<col width="20%">
   	<col width="20%">
   	<col width="20%">
   	<col width="20%">
   	<col width="20%">


    <thead>
    
      <tr class="text-center">
        <th>물적자원번호</th>
		<th>프로젝트이름</th>
		<th>개당비용</th>
		<th>자원이름</th>
		<th>물건갯수</th>

      </tr>
    </thead>	
    <tbody>
    

    
    	<c:forEach var="mr" items="${mrList}">
    		<tr ondblclick="goDetail(${mr.materialresourceno})">
    		<td style="text-align:right">${mr.materialresourceno}</td>
    		<td>${mr.prjname}</td>
    		<td style="text-align:right">${mr.price}</td>
    		<td>${mr.materialresourcename}</td>
    		<td style="text-align:right">${mr.productcnt}</td>
    		</tr>
    	</c:forEach>
    	
    	<tr>
    	<td colspan="4" style="text-align:center;">총액</td><td style="text-align:right"><fmt:formatNumber value="${totalPriceMr}"/></td>
    	</tr>

    </tbody>

	</table>  
	 
	 
	 
	 
	 

	<ul class="pagination  justify-content-end">
	  <li class="page-item">
	  	<a class="page-link" href="javascript:goPage(${mrsch.startBlock-1})">Previous</a></li>
	  <c:forEach var="pcnt" begin="${mrsch.startBlock}" end="${mrsch.endBlock}">
	  <li class="page-item ${mrsch.curPage==pcnt?'active':''}">
	  	<a class="page-link" href="javascript:goPage(${pcnt})">${pcnt}</a></li>
	  </c:forEach>
	  <li class="page-item"><a class="page-link" href="javascript:goPage(${mrsch.endBlock+1})">Next</a></li>
	</ul>
	
	
	
	<script type="text/javascript">
		function goPage(pcnt){
			$("[name=curPage]").val(pcnt)
			$("#frm01").attr("action","${path}/MRList.do")
			$("#frm01").submit()
		}
	</script>	
	
	
</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->
			
			
			
			<!-- Insert Project -->
			<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="MateraiResourceTitle">물적자원 등록</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
							
							
							
								<form id="frm02" class="form" method="post">
								
	
									
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												물적자원번호</span>
										</div>
										<input type="number" name="materialresourceno" readonly class="form-control" value="-1"/>
									</div>
							
								
									
									
									
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												프로젝트번호</span>
										</div>
										<input type="number" name="prjNo" class="form-control" readonly value=""/>
									</div>
									
									
									
									
									
									
									
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												프로젝트이름</span>
										</div>
										<input type="text" name="prjname" class="form-control" readonly value=""/>
									</div>
									
									
									
									
									
									
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												임대or구매</span>
										</div>
										<select name="rentorbuy" class="form-control">
											<option value="0">임대 or 구매 선택하세요</option>
											<option value="1">임대</option>
											<option value="2">구매</option>
										</select> 
									</div>
									
									
									
									
									
									
									
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												개당비용</span>
										</div>
										<input type="number" name="price" class="form-control"/>
									</div>
									
									
									
													
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												자원이름</span>
										</div>
										<input type="text" name="materialresourcename" class="form-control"/>
									</div>
									
									
									
									
									
																		
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												물건갯수</span>
										</div>
										<input type="number" name="productcnt" class="form-control"/>
									</div>
									

									
																		
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												시설위치</span>
										</div>
										<input type="text" name="facilityloc" class="form-control"/>
									</div>
									
									
									
									
									
									
									
									<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												시설or물건</span>
										</div>
										<select name="division" class="form-control">
											<option value="0">시설 or 물건 선택하세요</option>
											<option value="1">시설</option>
											<option value="2">물건</option>
	
										</select>
									</div>
									
									
									
									
									
								</form>
							</div>
							
							
							
							
							
							
							
							
							
							<div class="modal-footer">
								<button type="button" id="regBtn" class="btn btn-primary">물적자원 등록</button>
								<button type="button" id="uptBtn" class="btn btn-info">물적자원 수정</button>
								<button type="button" id="delBtn" class="btn btn-warning">물적자원 삭제</button>
								<button type="button" id="toRepositoryBtn" class="btn btn-danger">비품창고 이전</button>
								<button type="button" id="clsBtn" class="btn btn-secondary" data-dismiss="modal">Close</button>
							</div>




						</div>
					</div>
				</div>
			<!-- End of Insert Project -->
			
			
			
			
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
