<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<spring:url value="/js" var="js_url" />
<html>
<head>
<title>How to add calendar using jQuery and fullCalendar</title>
<link rel="stylesheet" rel="stylesheet" type="text/css"
	href="${js_url}/fullcalendardemo/fullcalendar.css">
<%-- <link rel="stylesheet" rel="stylesheet" type="text/css"
	href="${js_url}/fullcalendardemo/fullcalendar.min.css"> --%>
<link rel="stylesheet" rel="stylesheet" type="text/css" media='print'
	href="${js_url}/fullcalendardemo/fullcalendar.print.css">
<%-- <link rel="stylesheet" rel="stylesheet" type="text/css"
	href="${js_url}/fullcalendardemo/jquery-ui.min.css"> --%>
<script type='text/javascript'
	src="${js_url}/fullcalendardemo/moment.min.js"></script>
<script type='text/javascript'
	src="${js_url}/fullcalendardemo/fullcalendar.js"></script>
<script type='text/javascript'
	src="${js_url}/fullcalendardemo/fullcalendar.min.js"></script>
<link rel="stylesheet"
	href="${js_url}/fullcalendar/jquery-ui-1.10.4.custom.min.css">
<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-pen-2"></span>
		</div>
		<h1>
			Attendance <small>Attendance Register</small>
		</h1>
		<div class="buttons pull-right">
			<span> <span> <a
					onclick="history.back(); return false;" href="#"> <img
						alt="Back" src="${hr1 }/back.png">
				</a>
			</span>
			</span>
		</div>
	</div>
</div>
	<script>
		$(document).ready(function() {

			$('#calendar').fullCalendar({
				header : {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
				},
				defaultDate : new Date(),
				editable : true,
				eventLimit : true, // allow "more" link when too many events
				 events : [ {
					title : 'All Day Event',
					start : '2014-09-01'
				}, {
					title : 'Long Event',
					start : '2014-09-07',
					end : '2014-09-10'
				}, {
					id : 999,
					title : 'Repeating Event',
					start : '2014-09-09T16:00:00'
				}, {
					id : 999,
					title : 'Repeating Event',
					start : '2014-09-16T16:00:00'
				}, {
					title : 'Conference',
					start : '2014-09-11',
					end : '2014-09-13'
				}, {
					title : 'Meeting',
					start : '2014-09-12T10:30:00',
					end : '2014-09-12T12:30:00'
				}, {
					title : 'Lunch',
					start : '2014-09-12T12:00:00'
				}, {
					title : 'Meeting',
					start : '2014-09-12T14:30:00'
				}, {
					title : 'Happy Hour',
					start : '2014-09-12T17:30:00'
				}, {
					title : 'Dinner',
					start : '2014-09-12T20:00:00'
				}, {
					title : 'Birthday Party',
					start : '2014-09-13T07:00:00'
				}, {
					title : 'Click for Google',
					url : 'http://google.com/',
					start : '2014-09-28'
				} ] 
			});

		});
	</script>
<style>
body {
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 900px;
	margin: 0 auto;
}
</style>
</head>
<body>

	<div id='calendar' style="padding-top: 140px;"></div>

</body>
</html>