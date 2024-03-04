<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />

<!-- Content Column -->
<div class="col-lg-6 mb-4">
	<!-- Project Card Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">일정</h6>
		</div>
		<div class="card-body">
			<h4 class="small font-weight-bold">
				Server Migration <span class="float-right">20%</span>
			</h4>
			<div class="progress mb-4">
				<div class="progress-bar bg-danger" role="progressbar"
					style="width: 20%" aria-valuenow="20" aria-valuemin="0"
					aria-valuemax="100"></div>
			</div>
			<h4 class="small font-weight-bold">
				Sales Tracking <span class="float-right">40%</span>
			</h4>
			<div class="progress mb-4">
				<div class="progress-bar bg-warning" role="progressbar"
					style="width: 40%" aria-valuenow="40" aria-valuemin="0"
					aria-valuemax="100"></div>
			</div>
			<h4 class="small font-weight-bold">
				Customer Database <span class="float-right">60%</span>
			</h4>
			<div class="progress mb-4">
				<div class="progress-bar" role="progressbar" style="width: 60%"
					aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
			</div>
			<h4 class="small font-weight-bold">
				Payout Details <span class="float-right">80%</span>
			</h4>
			<div class="progress mb-4">
				<div class="progress-bar bg-info" role="progressbar"
					style="width: 80%" aria-valuenow="80" aria-valuemin="0"
					aria-valuemax="100"></div>
			</div>
			<h4 class="small font-weight-bold">
				Account Setup <span class="float-right">Complete!</span>
			</h4>
			<div class="progress">
				<div class="progress-bar bg-success" role="progressbar"
					style="width: 100%" aria-valuenow="100" aria-valuemin="0"
					aria-valuemax="100"></div>
			</div>
		</div>
	</div>
</div>

<div class="col-lg-6 mb-4">

	<!-- Illustrations -->
	<div class="cursor card shadow mb-4" >
		<div class="card-header py-3" role="button" id="notice">
			<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
		</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-hover table-bordered" id="dataTable"
									width="100%" cellspacing="0">
									<col width="40%">
									<col width="10%">
									<col width="10%">
									<thead>
										<tr class="text-center">
											<th>제목</th>
											<th>작성자</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody role="button">
										<c:forEach var="nl" items="${noticeList}">
											<tr onclick="goDetail(${nl.no})">
												<td>${nl.title} 
													<fmt:formatDate value="${nl.regdte}" pattern="yyyyMMdd" var="notday" />
													<c:if test="${nl.diff <= 1}">
														<i class="fas fa-exclamation-circle"></i>	
													</c:if>
												</td>
												<td class="text-center">${nl.writer}</td>
												<td class="text-center"><fmt:formatDate
														value="${nl.regdte}" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
						<script type="text/javascript">
								function goDetail(no) {
									location.href = "${path}/detailNotice.do?no="+no
								}							
						</script>
				</div>
				</div>
		</div>
	</div>

	<!-- Approach 
	<div id="notice" class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
		</div>
		<div class="card-body">
			<p>공지사항 목록으로 이동</p>
		</div>
	</div>
-->
</div>