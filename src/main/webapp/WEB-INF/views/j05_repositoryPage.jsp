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
		
		
		
		
		
		// submit 엔터 방지
		$("form").on("keypress",function(e){
			if(e.keyCode==13){ 
				e.preventDefault() 
			}
		})
		
		
		
		
		
		
		$("#cntRegBtn").click(function(){ //이동갯수를 입력하고 최종확인 버튼 누른경우
			
			if($("[name=cntInput]").val()<0){
				alert("갯수는 0 이상이어야 합니다.")
				return false;
			}
			
			
			
			if($("#index").val()=="MRTOREP"){
				$.ajax({
					url:"${path}/transferToRepository.do",
					data:"cntInput="+$("[name=cntInput]").val()
					+"&materialresourceno="
					+$("#materialresourcenoRepository").val(),
					dataType:"json",
					success:function(data){
						alert(data.msg)
						$("#clsBtn").click();	
						$("#clsBtn2").click();
						location.href="${path}/repositoryList.do?prjNo="+$("#frm01 [name=prjNo]").val()+"&prjname="+$("#frm01 [name=prjname]").val()
					},
					error:function(err){
						console.log(err)
					}
				})
			}

			if($("#index").val()=="REPTOMR"){
				$.ajax({
					url:"${path}/transferToMaterialResource.do",
					data:"cntInputRepToMr="+$("[name=cntInput]").val()+"&repno="+$("#repno").val()+"&prjNo="+$("#prjNoPermanent").val()+"&prjname="+$("#frm01 [name=prjname]").val(),
					dataType:"json",
					success:function(data){
						alert(data.msg)
						$("#clsBtn").click();	
						$("#clsBtn2").click();
						location.href="${path}/repositoryList.do?prjNo="+$("#frm01 [name=prjNo]").val()+"&prjname="+$("#frm01 [name=prjname]").val()
					},
					error:function(err){
						console.log(err)
					}
				})
			}			
		})

	})
	
	function goToRepository(materialresourceno){//물적자원리스트 더블클릭해서 비품창고로 이동
		
		$.ajax({
				url:"${path}/repositoryList2.do",
				data:"prjNo="+$("#frm01 [name=prjNo]").val()+"&prjname="+$("#frm01 [name=prjname]").val()+"&materialresourceno="+materialresourceno+"&index=MRTOREP",
				dataType:"json",
				success:function(data){
					$("#index").val("MRTOREP");
					//alert("index 인풋태그의 값 : "+$("#index").val())
					//alert("물적자원의 갯수 : "+data.mrCnt);//type은 number이다. typeof(data.mrCnt)로 확인 완료
					$("#maxCnt").val(data.mrCnt);
					//alert("#maxCnt에 "+data.mrCnt+"할당한다.")
					$("#materialresourcenoRepository").val(data.materialresourceno)
					
					$("#clsBtn2").hide();
					$("#transferBtn").click();
				},
				error:function(err){
					console.log(err)
				}
		})
	}
	
	
	
	
	function goToMaterialResource(repno){//비품창고리스트 더블클릭해서 물적자원으로 이동
				$.ajax({
				url:"${path}/repositoryList2.do",
				data:"prjNo="+$("#prjNoPermanent").val()
				+"&prjname="+$("#frm01 [name=prjname]").val()
				+"&repno="+repno+"&index=REPTOMR",
				dataType:"json",
				success:function(data){
					$("#repno").val(repno);
					$("#index").val("REPTOMR");
					$("#maxCntRepository").val(data.repositoryCnt);
					alert("#maxCntRepository에 "+data.repositoryCnt+"할당한다.")
					$("#materialresourcenoRepository").val($("#prjNoPermanent").val())
					$("#clsBtn2").hide();
					$("#transferBtn").click();
				},
				error:function(err){
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
  <h2>비품창고 리스트</h2>
</div>

<div class="container">


		<form id="frm01" class="form"  method="post">
	  	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		
			<!--
			밑에 id="schBtn"과 함꼐 나중에 비품이름 검색 처리 하자.
		    <input placeholder="비품창고 비품이름검색" name="materialresourcename"  value="${repositorySch.materialresourcename}"  class="form-control mr-sm-2"/>
		    -->
		    <input type="hidden" name="curPage" value="${mrsch.curPage}"/>
			<input type="hidden" name="prjNo" value="${mrsch.prjNo}"/>
			<input type="hidden" name="prjname" value="${mrsch.prjname}"/>
			
			<input type="hidden" id="maxCnt" value=""/>
			<input type="hidden" id="maxCntRepository" value=""/>
			<input type="hidden" id="materialresourcenoRepository" value=""/>
			<input type="hidden" id="repno" value=""/>
			
			
			<input type="hidden" id="index" value=""/>
			
			<input type="number" id="prjNoPermanent" value="${prjNoPermanent}"/>
			
			<!--
			위에 비품창고 비품이름검색과 함꼐 나중에 비품이름 검색 처리 하자.
		    <button class="btn btn-info" type="button" id="schBtn">Search</button>
		    -->
		    <button id="transferBtn" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" type="button">물적자원 이동</button>
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
				$("#frm01").attr("action","${path}/repositoryList.do")
				$("#frm01").submit()
			})
		</script> 
	</form>
	
	
	
	
	
	
	
	
	
	
	<!-- 물적자원 테이블 -->
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
    		<tr ondblclick="goToRepository(${mr.materialresourceno})">
    		<td style="text-align:right">${mr.materialresourceno}</td>
    		<td>${mr.prjname}</td>
    		<td style="text-align:right">${mr.price}</td>
    		<td style="text-align:right">${mr.materialresourcename}</td>
    		<td style="text-align:right">${mr.productcnt}</td>
    		</tr>
    	</c:forEach>
    	
    	<tr>
    	<td colspan="4" style="text-align:center;">총액 </td><td style="text-align:right"><fmt:formatNumber value="${totalPriceMr}"/></td>
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
			$("#frm01").attr("action","${path}/repositoryList.do")
			$("#frm01").submit()
		}
	</script>	
	
	
	
	
	
	
	
	
	
	
	<!-- 비품창고 테이블 -->
   <table class="table table-hover table-bordered">
   	<col width="16%">
   	<col width="16%">
   	<col width="16%">
   	<col width="16%">
   	<col width="16%">
   	<col width="16%">
    <thead>
      <tr class="text-center">
        <th>저장번호</th>
		<th>시설or물건구분</th>
		<th>자원이름</th>
		<th>비품갯수</th>
		<th>임대or구매여부</th>
		<th>시설위치</th>
      </tr>
    </thead>	
    <tbody>
    	<c:forEach var="repository" items="${repositoryList}">
    		<tr ondblclick="goToMaterialResource(${repository.repno})"> 
    		<td style="text-align:right">${repository.repno}</td>
    		<td style="text-align:right">${repository.division}</td>
    		<td>${repository.materialresourcename}</td>
    		<td style="text-align:right">${repository.repcnt}</td>
    		<td style="text-align:right">${repository.rentorbuy}</td>
    		<td>${repository.facilityloc}</td>
    		</tr>
    	</c:forEach>
    	
    </tbody>
	</table>  
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
								<h5 class="modal-title" id="MateraiResourceTitle">이전시킬 갯수 입력</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form id="frm02" class="form" method="post">
								
																	<div class="input-group mb-3">
										<div class="input-group-prepend ">
											<span class="input-group-text  justify-content-center">
												이전시킬 갯수</span>
										</div>
										<input type="number" name="cntInput" class="form-control" value="" />
									</div>

								</form>
							</div>
							
							<div class="modal-footer">
								<button type="button" id="cntRegBtn" class="btn btn-primary">갯수 입력</button>
								<button type="button" id="clsBtn" class="btn btn-secondary" data-dismiss="modal">Close</button>
							</div>

						</div>
						<button type="button" id="clsBtn2" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
