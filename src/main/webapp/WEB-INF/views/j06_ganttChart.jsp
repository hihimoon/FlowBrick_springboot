<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>


<!DOCTYPE html>
<html style="height: 100%;
			padding: 0px;
			margin: 0px;
			overflow: hidden;">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<title>Basic initialization</title>


<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<link href="${path}/a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/a00_com/css/sb-admin-2.min.css" rel="stylesheet">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>


	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script src="${path}/a00_com/gantt/codebase/dhtmlxgantt.js"></script>
	<link href="${path}/a00_com/gantt/codebase/dhtmlxgantt.css" rel="stylesheet">
	<style>
		html, body {
			height: 100%;
			padding: 0px;
			margin: 0px;
			overflow: hidden;
		}

		
	</style>
</head>


<body id="page-top" style="height: 100%;
			padding: 0px;
			margin: 0px;
			overflow: hidden;">





	<!-- Page Wrapper -->
	<div id="wrapper" style="height: 100%;
			padding: 0px;
			margin: 0px;
			overflow: hidden;">

		<!-- Sidebar -->
		<%@ include file="inc/sliderBar.jsp" %>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column" >

			<!-- Main Content -->
			<div id="content" style="height: 100%;
			padding: 0px;
			margin: 0px;
			overflow: hidden;">

				<!-- Topbar -->
				<%@ include file="inc/topBar.jsp" %>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid" style='width:100%; height:90%;
						padding: 0px;
						margin: 0px;
						overflow: hidden;'>
	
	
					
					<div id="gantt_here" style='width:100%; height:100%;
						padding: 0px;
						margin: 0px;
						overflow: hidden;'>
					</div>
					
					
	<script>
	gantt.config.date_format = "%Y-%m-%d";
	gantt.init("gantt_here");
	gantt.load("${path}/getGanttChart.do", "json")

		gantt.plugins({
		    fullscreen: true
		});
		
		gantt.config.lightbox.sections=[
		    {name:"description", height:70, map_to:"text", type:"textarea", focus:true},
		    {name:"time",        height:200, map_to:"auto", type:"time"},
			{name:"priority" , map_to:"priority", type:"radio", options: [ 
		    	{key: 1, label: "&nbsp1&nbsp"},
			    {key: 2, label: "&nbsp2&nbsp"},
			    {key: 3, label: "&nbsp3&nbsp"},                                      
			    {key: 4, label: "&nbsp4&nbsp"},                                      
			    {key: 5, label: "&nbsp5&nbsp"}]},
			{name:"step" , map_to:"step", type:"radio", options: [ 
			    {key: "Designing", label: "&nbspDesigning&nbsp"},
				{key: "Developing", label: "&nbspDeveloping&nbsp"},
				{key: "Testing", label: "&nbspTesting&nbsp"},    
				{key: "Debugging", label: "&nbspDebugging&nbsp"}]}
			];
		
		gantt.locale.labels.section_description = "ProjectName";
		gantt.locale.labels.section_time = "Start - End";
		gantt.locale.labels.section_priority = "Priority";
		gantt.locale.labels.section_step = "Step";

		



		gantt.attachEvent("onAfterTaskDelete", function(id,task){
			gantt.ajax.get({
				url: "${path}/deleteGanttData.do",
			    callback: function() {
			    	$.ajax({
			    		url:"${path}/deleteGanttData.do",
			    		data: task
			    	})
			    }
			});
			return true;
		});
		
		
		
		gantt.attachEvent("onBeforeTaskUpdate", function(id,task){
			if((task.text).length<=0){
				alert("ProjectName can't be blank.")
				gantt.clearAll(); 
				gantt.load("${path}/getGanttChart.do", "json")
				return false;
			}
			else if(task.priority<1 || task.priority>5){
				alert("Priority must be one of [1/2/3/4/5]")
				gantt.clearAll(); 
				gantt.load("${path}/getGanttChart.do", "json")
				return false;
			}
			else if(task.step!="Designing" && task.step!="Developing" && task.step!="Testing" && task.step!="Debugging" ){
				alert("Step must be one of [Designing/Developing/Testing/Debugging]")
				gantt.clearAll(); 
				gantt.load("${path}/getGanttChart.do", "json")
				return false;
			}
			else{
				gantt.ajax.get({
				    url: "${path}/updateGanttData.do",
				    callback: function() {
				    	$.ajax({
				    		url:"${path}/updateGanttData.do",
				    		data: task
				    	})
				    }
				});
				return true;
			}
		});
		
		
		
		
		
		
		gantt.attachEvent("onAfterTaskAdd", function(id,task){
			if((task.text).length<=0){
				alert("ProjectName can't be blank.")
				gantt.clearAll(); 
				gantt.load("${path}/getGanttChart.do", "json")
				return false;
			}
			else if(task.priority<1 || task.priority>5){
				alert("Priority must be one of [1/2/3/4/5]")
				gantt.clearAll(); 
				gantt.load("${path}/getGanttChart.do", "json")
				return false;
			}
			else if(task.step!="Designing" && task.step!="Developing" && task.step!="Testing" && task.step!="Debugging" ){
				alert("Step must be one of [Designing/Developing/Testing/Debugging]")
				gantt.clearAll(); 
				gantt.load("${path}/getGanttChart.do", "json")
				return false;
			}
			else{
				gantt.ajax.get({
				    url: "${path}/insertGanttData.do",
				    callback: function() {
				    	$.ajax({
				    		url:"${path}/insertGanttData.do",
				    		data: task
				    	})
				    }
				});			
				return true;
			}
		});

		
		
		
		
		
	
		
		gantt.attachEvent("onAfterLinkDelete", function(id,link){ 
			gantt.ajax.get({
				url: "${path}/deleteGanttLink.do",
			    callback: function() {
			    	$.ajax({
			    		url:"${path}/deleteGanttLink.do",
			    		data: link
			    	})
			    }
			});
			return true;
		});

		
		
		
		
		gantt.attachEvent("onAfterLinkAdd", function(id,link){ 
			gantt.ajax.get({
				url: "${path}/insertGanttLink.do",
			    callback: function() {
			    	$.ajax({
			    		url:"${path}/insertGanttLink.do",
			    		data: link
			    	})
			    }
			});
			return true;
		});
		
		

		gantt.config.columns=[
			{name:"wbs", label:"WBS", width:40, template:gantt.getWBSCode }, 
		    {name:"text",       label:"Task name",  width:'*', tree:true },
		    {name:"start_date", label:"Start time",align: "center" , width:'*'},
		    {name:"end_date", label:"End time",align: "center" , width:'*'},
		    {name:"duration",   label:"Duration",  align: "center" , width:'*'},
		    {name:"add",        label:"" }
		];
		
	</script>

				</div>
				<!-- /.container-fluid -->
								
			</div>
			<!-- End of Main Content -->


			<!-- Footer -->
			<footer class="sticky-footer bg-white" >
				<div class="container my-auto" >
					<div class="copyright text-center my-auto" >
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
