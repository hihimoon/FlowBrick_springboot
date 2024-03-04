<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<!-- Page level plugins -->
<script src="${path}/a00_com/vendor/chart.js/Chart.min.js"></script>
    <style>
          .scrollable-container {
	      	width: 100%;
	      	overflow: auto; /* 스크롤이 필요한 경우만 스크롤바를 표시 */
	      	padding: 10px;
	      	}
	      .no-warp{
	      	flex-wrap: nowrap;
	      	}
	      .scrollable-container::-webkit-scrollbar {
      		width: 8px;
    		}
		    .scrollable-container::-webkit-scrollbar-thumb {
		      background-color:  #4e73df; 
		      border-radius: 5px; 
		      transition: background-color 0.3s ease; /* 트랜지션 효과 추가 */
		    }

		    .scrollable-container::-webkit-scrollbar-track {
		      background-color: #ecf0f1; 
		      border-radius: 5px; 
		    }    
		    .scrollable-container::-webkit-scrollbar-thumb:active {
		      background-color: #4668c8; /* 클릭할 때 색상 변경 */
		    }  
</style>
<c:if test="${not empty prjList}">
<!-- 내 프로젝트 -->
<div class="col-xl-9 col-lg-7">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">프로젝트 목록</h6>
			<div class="dropdown no-arrow">
				<a class="dropdown-toggle" href="#" role="button"
					id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i
					class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
				</a>
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
					aria-labelledby="dropdownMenuLink">
					<div class="dropdown-header">Dropdown Header:</div>
					<a class="dropdown-item" href="#">Action</a> <a
						class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div>
			</div>
		</div>
		<!-- 프로젝트 카드 -->
		
			<div class="card-body scrollable-container">
			<div class="row no-warp">
				<c:forEach var="prj" items="${prjList}" varStatus="status">
				
				<div class="col-xl-4 col-md-6" onclick="location.href='${path}/getProjectBasic.do?prjNo=${prj.prjNo}'">
					<div class="card border-bottom-primary shadow h-100 py-2">
						<div class="card-body" role="button">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<i class="fas fa-calendar fa-2x text-gray-300"></i>
								</div>
								<div class="col-9">
									<div
										class="text-lg font-weight-bold text-primary text-uppercase mb-4">
										<c:choose>	
										<c:when test="${fn:length(prj.prjName) > 20}">
										    <c:set var="prjN" value="${fn:substring(prj.prjName, 0, 20 > fn:length(prj.prjName) ? fn:length(prj.prjName) : 20)}" />
										    ${prjN}..
										</c:when>
										<c:otherwise>
											${prj.prjName}
										</c:otherwise>
										</c:choose>	
										</div>
									<div class="progress progress mr-2 mb-4">
										<div class="progress-bar bg-info" role="progressbar"
											style="width: 50%" aria-valuenow="50" aria-valuemin="0"
											aria-valuemax="100"></div>
									</div>
									
									<div class="h6 mb-3 font-weight-bold text-gray-800">Team. ${prj.teamName}</div>
								</div>
	
							</div>
							<hr class="sidebar-divider">
							<div class="row no-gutters align-items-center mb-4 mt-4">
								<div class="col-2">
									<i class="far fa-calendar-check fa-2x text-gray-800"></i>
								</div>
								<div class="col-4">
									<div class="h6 mb-0 font-weight-bold text-gray-800">D${prj.diff}일 
									<fmt:formatDate value="${prj.prjEnd}" pattern="yy.MM.dd" var="endDay" /><br>[${endDay}]</div>		
								</div>
								<div class="col-2">
									<i class="fas fa-flag fa-2x text-gray-800"></i>
								</div>
								<div class="">
									<div class="h6 mb-0 font-weight-bold text-gray-800">목표 5개</div>
								</div>		
							</div>
							
							<div class="row no-gutters align-items-center">
								<div class="col-2">
									<i class="fas fa-bullseye fa-2x text-gray-800"></i>
								</div>
								<div class="col-4">
									<div class="h6 mb-0 font-weight-bold text-gray-800">우선순위 ${prj.prjPriority}</div>
								</div>
								<div class="col-2">
									<i class="fas fa-exclamation fa-2x text-gray-800"></i>
								</div>
								<div class="">
									<div class="h6 mb-0 font-weight-bold text-gray-800">리스크 ${prj.risk}건</div>
								</div>		
							</div>
						</div>
	
						
					</div>
				</div>
				</c:forEach>
			</div>
			</div>		
		

	</div>
</div>



<!-- Pie Chart -->
<div class="col-xl-3 col-lg-5">
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">프로젝트 진행도</h6>
			<div class="dropdown no-arrow">
				<a class="dropdown-toggle" href="#" role="button"
					id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i
					class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
				</a>
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
					aria-labelledby="dropdownMenuLink">
					<div class="dropdown-header">기간설정</div>
						<a class="dropdown-item" href="#">올해</a>
						<a class="dropdown-item" href="#">분기</a>
					<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Something else here</a>
				</div>
			</div>
		</div>
		<!-- Card Body -->
		<div class="card-body">
			<div class="chart-pie pt-4 pb-2">
				<canvas id="myPieChart"></canvas>
			</div>
			<div class="mt-4 text-center small">
				<span class=""> <i class="fas fa-circle text-success"></i>
					완료 [${prj_chart.complete}]
				</span> <span class=""> <i class="fas fa-circle text-primary"></i>
					개발 [${prj_chart.develop}]
				</span> <span class=""> <i class="fas fa-circle text-info"></i>
					테스트 [${prj_chart.test}]
				</span> <span class=""> <i class="fas fa-circle text-warning"></i>
					디버그 [${prj_chart.debug}]
				</span><span class=""> <i class="fas fa-circle text-danger"></i>
					설계 [${prj_chart.design}]
				</span>
			</div>
		</div>
	</div>
</div>

</c:if>

<!-- Area Chart 
<div class="col-xl-8 col-lg-7">
	<div class="card shadow mb-4">

		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">캘린더 or 스케쥴</h6>
			<div class="dropdown no-arrow">
				<a class="dropdown-toggle" href="#" role="button"
					id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i
					class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
				</a>
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
					aria-labelledby="dropdownMenuLink">
					<div class="dropdown-header">Dropdown Header:</div>
					<a class="dropdown-item" href="#">Action</a> <a
						class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div>
			</div>
		</div>
 
		<div class="card-body">
			<div class="chart-area">
				<canvas id="myAreaChart"></canvas>
			</div>
		</div>
	</div>
</div>
-->