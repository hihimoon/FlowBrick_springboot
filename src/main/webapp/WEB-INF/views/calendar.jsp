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
<title>Calendar</title>




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

<style>
#chatArea {
	width: 80%;
	height: 100px;
	overflow-y: auto;
	text-align: left;
	border: 1px solid green;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}
.input-group-prepend {
	width: 20%;
}
.input-group-text {
	width: 100%;
}
</style>

<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src='${path}/a00_com/dist/index.global.js'></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var sessId = "${empResult.empno}"
			if (sessId == "") {
				alert("로그인을 하여야 현재화면을 볼 수 있습니다\n로그인 페이지 이동")
				location.href = "${path}/login.do"
			}
		var calendarEl = document.getElementById('calendar');
		var today = new Date(); // 날짜형 js 객체
		console.log(today)
		console.log(today.toLocaleString())
		// GMT기준으로 시간별 경도의 날짜/시간표시
		console.log(today.toISOString())
		// 전세계 표준시간(GMT)
		console.log(today.toISOString().split("T"))
		// 시간과 날짜를 배열로 구분해서 출력..
		var todayTitle = today.toISOString().split("T")[0]
		// 날짜만 표현..(기준시간을 지정)
		console.log(todayTitle)
		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
			},
			locale: 'ko',
			initialDate : todayTitle,
			navLinks : true, // can click day/week names to navigate views
			selectable : true,
			selectMirror : true,
			select : function(arg) {
				// 등록시 처리되는 이벤트 핸들러(날짜 클릭, 시간을 스크롤 하면 처리)
				console.log("# 날짜를 등록시 선택했을 때 #")
				console.log("시작일(문자날짜ISO):" + arg.startStr)
				console.log("시작일(Date):" + arg.start)
				console.log("종료일(문자날짜ISO):" + arg.endStr)
				console.log("종료일(Date):" + arg.end)
				console.log("종일여부:" + arg.allDay)
				// 초기화..
				// 등록하기 위해서 모달창을 로딩/모달창에 form name값에
				// 해당 기본데이터를 설정..
				$("#frm01")[0].reset() 
				//상세화면 로딩 후, 클릭시에는 상세화면내용을 가지고 있거나
				// 이전 입력 form내용을 가지고 있기에 초기화 처리
				$("#calTitle").text("일정등록")
				// 모달창을 상세화면과 같이 쓰기에 타이틀 변경
				$("#start").val(arg.start.toLocaleString())
				$("[name=start]").val(arg.startStr)
				$("#end").val(arg.end.toLocaleString())
				$("[name=end]").val(arg.endStr)
				// api에서는 boolean값을 가지고 있지만, 
				// 등록할 때는 vo로 1/0으로 처리하여 boolean으로
				// 할당하여야 되기에 처리.. 
				// js(boolean이 java boolean) 처리가 바로 되지 않는다.
				$("[name=allDay]").val(arg.allDay ? 1 : 0)
				// 등록/수정/삭제 버튼이 등록시와 상세화면에서
				// 출력하는 것이 다르기에 SHOW/HIDE로 설정..
				$("#regBtn").show()
				$("#uptBtn").hide()
				$("#delBtn").hide() 
				// 강제 클릭..모당창 로딩을 위한 이벤트..
				$("#calModal").click()				
				
				
				/*
				var title = prompt('Event Title:');
				if (title) {
					calendar.addEvent({
						title : title,
						start : arg.start,
						end : arg.end,
						allDay : arg.allDay
					})
				}
				
				 */
				calendar.unselect()
			},
			eventClick : function(arg) {
				$("#frm01")[0].reset()
				console.log("#일정 클릭시#")
				console.log(arg.event)
				addForm(arg.event)
				
				
				
				$("#calTitle").text("일정상세")
				$("#regBtn").hide()
				$("#uptBtn").show()
				$("#delBtn").show() 
				$("#calModal").click()					
			},
			eventDrop:function(arg){
				addForm(arg.event)
				ajaxFunc("updateCalendar", "post")
			},
			eventResize:function(arg){
				addForm(arg.event)
				ajaxFunc("updateCalendar", "post")
			},
			editable : true,
			dayMaxEvents : true, // allow "more" link when too many events
	        datesSet: function(dateInfo) {
	        	calendar.removeAllEvents();
	            // 여기서 dateInfo.start와 dateInfo.end를 사용하여
	            // 새로운 월의 시작과 끝 날짜를 얻을 수 있습니다.
	            console.log("# 시작일과 종료일 #");
	            console.log(dateInfo.start, dateInfo.end);

	            // 필요한 경우 새로운 월에 대한 이벤트를 로드하는 로직을 추가합니다.
	            loadEventsForMonth(start, end, calendar);			          
	        },
			events : function(info, successCallback, failureCallBack) {
				$.ajax({
					url : "${path}/calendarJson",
					dataType : "json",
					success : function(data) {
						console.log(data)
						// 서버단에서 받은 json데이터를 calendar api에 할당 처리
						successCallback(data)
					},
					error : function(err) {
						console.log(err)
						failureCallBack(err)
					}
				})

			}
		});

		calendar.render();

		$("#regBtn").click(function() {
			ajaxFunc("insertCalendar", "post")
		})
		$("#uptBtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				ajaxFunc("updateCalendar", "post")
			}
		})
		$("#delBtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				ajaxFunc("deleteCalendar", "post")
			}
		})		
		// 링크된 페이지로 창을 로딩하여 이동하게 처리..
		$("[name=urlLink]").dblclick(function(){
			if(confirm("해당페이지로 이동하시겠습니까?")){
				window.open($(this).val(),"","")
			}
		})
		$("#clsBtn2").hide()
		function ajaxFunc(url, type){
			$.ajax({
				type : type,
				url : "${path}/"+url,
				data : $("#frm01").serialize(),
				
				// 데이터를 입력하고 요청데이터 서버에 전송
				dataType : "json",
				
				success : function(data) {								
					console.log(data.msg)
					alert(data.msg) // 등록성공/등록실패
					$("#clsBtn").click() // 등록 모달창 닫기
					$("#md01").click() // 등록 모달창 닫기
					// 기존일정 삭제(full api에 등록된 데이터 삭제 js) 
					calendar.removeAllEvents();
					calendar.render();
					
					console.log(data.calList)
					// 새로운 일정 추가(서버에서 controller로 넘겨온 데이터)
					// 다시 추가 처리
					calendar.addEventSource(data.calList)
				},
				error : function(err) {
					console.log(err)
				}
			})			
			
		}
		function loadEventsForMonth(start, end, calendar1) {
		    $.ajax({
		        url: "${path}/calendarJson", // 이벤트를 로드할 서버의 URL
		        type: 'GET',
		        dataType: 'json',
		        /*
		        data: {
		            start: start,
		            end: end
		        },
		        */
		        success: function(events) {
		            // 기존 이벤트를 제거합니다.
		            calendar.removeAllEvents();
		            // 새로 로드된 이벤트를 캘린더에 추가합니다.
		            events.forEach(function(event) {
		                calendar.addEvent(event);
		            });
		        },
		        error: function() {
		            console.error('이벤트 로드 실패');
		        }
		    });
		}		
		
		function addForm(evt){
			// evt.속성 : 기본적으로 fullcalendar에서 사용하는 속성 
			// evt.extendedProps.속성 : 기본속성이 아닌 추가적으로 
			//		상세화면에 출력시 사용되는 속성
			var calId = parseInt(evt.extendedProps.calId)
			var prjNo = parseInt(evt.extendedProps.prjNo)
			var empNo = parseInt(evt.extendedProps.empNo)
			$("[name=calId]").val(calId)
			$("[name=prjNo]").val(prjNo)
			$("[name=prjName]").val(prjNo)
			$("[name=empNo]").val(empNo)
			$("[name=title]").val(evt.title)
			$("[name=writer]").val(evt.extendedProps.writer)
			$("#start").val(evt.start.toLocaleString())
			$("[name=start]").val(evt.startStr)
			$("#end").val(evt.end.toLocaleString())
			$("[name=end]").val(evt.endStr)
			
			$("[name=backgroundColor]").val(evt.backgroundColor)
			$("[name=textColor]").val(evt.textColor)
			$("[name=content]").val(evt.extendedProps.content)
			$("[name=urlLink]").val(evt.extendedProps.urlLink)
			$("[name=allDay]").val(evt.allDay?1:0)
		}

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

                     <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Calendar</h1>

<p>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">${empResult.ename}님의 일정</h6>
                        </div>
                        <div class="card-body">
                            <div id='calendar'></div>
                        </div>
						<button id="calModal" class="btn btn-success d-none"
							data-toggle="modal" data-target="#exampleModalCenter" type="button">등록</button>
					
						<div class="modal fade" id="exampleModalCenter" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalCenterTitle"
							aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header"><!-- 
					
									
									 -->
										<h5 class="modal-title" id="calTitle">일정등록</h5>
										<button type="button" id="md01" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<form id="frm01" class="form" method="post">
											<input type="hidden" name="calId" value="0"/>	
											<div class="input-group mb-3">	
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														프로젝트명*</span>
												</div>
												<select name="prjNo" class="form-control">
													<option value="">프로젝트 선택</option>
													<c:forEach var="proj" items="${projectByEmp}">
														<option value="${proj.prjNo}">${proj.prjName}</option>
													</c:forEach>
												</select>
											</div>
											<input type="hidden" name="empNo" value="${empResult.empno}">
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														제목*</span>
												</div>
												<input type="text" name="title" class="form-control" value="" />
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														시작일</span>
												</div>
												<input type="text" id="start" readonly class="form-control" /> <input
													type="hidden" name="start" />
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														종료일</span>
												</div>
												<input type="text" id="end" readonly class="form-control" /> <input
													type="hidden" name="end" />
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														작성자</span>
												</div>
												<span class="form-control">${empResult.ename}</span>
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														내용*</span>
												</div>
												<textarea name="content" id="chatArea" class="form-control"></textarea>
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														배경색상</span>
												</div>
												<input type="color" name="backgroundColor" class="form-control"
													value="#FFFFFF" />
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														글자색상</span>
												</div>
												<input type="color" name="textColor" class="form-control"
													value="#000000" />
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														종일여부</span>
												</div>
					
												<select name="allDay" class="form-control">
													<option value="1">종일</option>
													<option value="0">시간</option>
												</select>
											</div>
											<div class="input-group mb-3">
												<div class="input-group-prepend ">
													<span class="input-group-text  justify-content-center">
														참고 link</span>
												</div>
												<input type="text" name="urlLink" class="form-control" value="" />
											</div>
										</form>
									</div>
									<div class="modal-footer"><!-- -->
										<button type="button" id="regBtn" class="btn btn-primary">일정등록</button>
										<button type="button" id="uptBtn" class="btn btn-info">일정수정</button>
										<button type="button" id="delBtn" class="btn btn-warning">일정삭제</button>
										<button type="button" id="clsBtn" class="btn btn-secondary"
											data-dismiss="modal">Close</button>
									</div>
									<script type="text/javascript">
										
									</script>
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
	
</body>
</html>