<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/" var="baseurl" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />    
    <!--[if gt IE 8]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />        
    <![endif]-->                
    <title>UI Elements - Aries Premium Admin Template</title>
    <link rel="icon" type="image/ico" href="favicon.ico"/>
    
    <link href="css/stylesheets.css" rel="stylesheet" type="text/css" />
    <!--[if lte IE 7]>
        <link href="css/ie.css" rel="stylesheet" type="text/css" />
        <script type='text/javascript' src='js/plugins/other/lte-ie7.js'></script>
    <![endif]-->      
    <script type='text/javascript' src='js/plugins/jquery/jquery-1.9.1.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery-ui-1.10.1.custom.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/jquery-migrate-1.1.1.min.js'></script>
    <script type='text/javascript' src='js/plugins/jquery/globalize.js'></script>
    <script type='text/javascript' src='js/plugins/other/excanvas.js'></script>
    
    <script type='text/javascript' src='js/plugins/other/jquery.mousewheel.min.js'></script>
        
    <script type='text/javascript' src='js/plugins/bootstrap/bootstrap.min.js'></script>            
    
    <script type='text/javascript' src='js/plugins/cookies/jquery.cookies.2.2.0.min.js'></script>    
        
    <script type='text/javascript' src='js/plugins/animatedprogressbar/animated_progressbar.js'></script>
    <script type='text/javascript' src="js/plugins/uniform/jquery.uniform.min.js"></script>
    
    <script type='text/javascript' src='js/plugins/shbrush/XRegExp.js'></script>
    <script type='text/javascript' src='js/plugins/shbrush/shCore.js'></script>
    <script type='text/javascript' src='js/plugins/shbrush/shBrushXml.js'></script>
    <script type='text/javascript' src='js/plugins/shbrush/shBrushJScript.js'></script>
    <script type='text/javascript' src='js/plugins/shbrush/shBrushCss.js'></script>    
    
    <script type='text/javascript' src='js/plugins.js'></script>
    <script type='text/javascript' src='js/charts.js'></script>
    <script type='text/javascript' src='js/actions.js'></script>


<div class="container">
	<div class="row">
		<div class="span12 relativeWrap">

			<button class="btn btn-navbar visible-phone" type="button">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<ul class="hidden-phone" id="menu">
			<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<li class="active"><a class="menuToggle" href="dashboard1">Dashboard</a>
				</sec:authorize>
				
				<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<li><a class="menuToggle" href="searchstudentpage">Student</a></li>
				</sec:authorize>
				
				<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<li><a class="menuToggle" href="attendancemenu">Attendance</a>
					<ul class="menu hide">
						<li class=""><a href="attendanceregister"><span>Attendance Register</span></a></li>
						<li class=""><a href="attendancereport"><span>Attendance Report</span></a></li>
					</ul></li>
					</sec:authorize>
					
					<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<li><a class="menuToggle" href="configuration">Settings</a>
					<ul class="menu hide">
						<li class=""><a href="managecourseandbatch"><span>Manage Course/Batch</span></a></li>
						<li class=""><a href="studentcategories"><span>Manage Student
									Category</span></a></li>
						<li class=""><a href="managesubject"><span>Manage Subject</span></a></li>
						<li class=""><a href="configurationupdate"><span>General Settings</span></a></li>
						<li class=""><a href="addadditionaldetails"><span>Add Admission
									Additional Detail</span></a></li>
						<li class=""><a href="sms"><span>SMS Module</span></a></li>
					</ul></li>
					</sec:authorize>
					<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<li><a class="menuToggle" href="timetable">Timetable</a>
					<ul class="menu hide">
						<li class=""><a href="newtimetable"><span>Create
									Timetable</span></a></li>
						<li class=""><a href="edittimetable"><span>Edit
									Timetable</span></a></li>
						<li class=""><a href="classtimings"><span>Set
									Class Timing</span></a></li>
						<li class=""><a href="weekday"><span>Create
									Weekdays</span></a></li>
						<li class=""><a href="viewtimetables"><span>View
									Timetables</span></a></li>
						<li class=""><a href="teacherstimetable"><span>Teachers
									Timetable</span></a></li>
						<li class=""><a href="institutionaltimetable"><span>Institutional
									Timetable</span></a></li>
						<li class=""><a href="subjectassign"><span>Work
									Allotment</span></a></li>
					</ul></li>
					</sec:authorize>
					
					<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<li><a class="menuToggle" href="#">More</a>
					<ul class="menu hide">
						<!-- <li class=""><a href="#"><span>Calendar</span></a></li> -->

						<li class="hasSubmenu"><a href="#menu_ecommerce"
							data-toggle="collapse" class="collapsed"><span>
									Examination<i class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_ecommerce" class="collapse" style="height: 0px;">
								<li class=""><a href="examsetting"><span>Setting</span></a></li>
								<li class=""><a href="createexam?schoolId=1"><span>Exam
											Management</span></a></li>
								<li class=""><a href="generatereports"><span>General
											Report</span></a></li>
								<li class=""><a href="examreportcenter"><span>Report
											Center</span></a></li>
							<!-- 	<li class=""><a href="#"><span>CCE Report</span></a></li> -->
								<li class=""><a href="combinedreport"><span>Exam
											Report</span></a></li>
							</ul></li>
						<li class=""><a href="managenews"><span>News</span></a></li>
					 	<li class=""><a href="eventscreation"><span>Event Creation</span></a></li>
						<li class="hasSubmenu"><a href="#menu_forms"
							data-toggle="collapse" class="collapsed"><span> Human Resource<i class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_forms" class="collapse" style="height: 0px;">
								<li class=""><a href="setting"><span>Setting</span></a></li>
								<li class=""><a href="employeemanagement"><span>Employee
											Management</span></a></li>
								<li class=""><a href="employee_attendance"><span>Employee Leave
											Management</span></a></li>
								<li class=""><a href="payslip"><span>Create Payslip</span></a></li>
								<li class=""><a href="search"><span>Employee Search</span></a></li>
								<li class=""><a href="employeemonthlypayslips"><span>Employee Payslip</span></a></li>
							</ul></li>
						<li class="hasSubmenu"><a href="#menu_for"
							data-toggle="collapse" class="collapsed"><span>
									Finance<i class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_for" class="collapse" style="height: 0px;">
								<li class=""><a href="feesindex"><span>Fees</span></a></li>
								<li class=""><a href="categories"><span>Category</span></a></li>
								<li class=""><a href="transactions"><span>Transaction</span></a></li>
								<li class=""><a href="donation"><span>Donations</span></a></li>
								<li class=""><a href="automatictransactions"><span>Automatic
											Transaction</span></a></li>
								<li class=""><a href="payslipindex"><span>Payslip</span></a></li>
								<li class=""><a href="assetliability"><span>Assets
											Liability Management</span></a></li>
								<li class=""><a href="tallyexportsindex"><span>Tally
											Export</span></a></li>
							</ul></li>
						<li class=""><a href="searchuser"><span>User</span></a></li>
					<!-- 	<li class=""><a href="#"><span>Applicant Register</span></a></li> 
						<li class=""><a href="#"><span>Collaborate</span></a></li> -->
						<li class=""><a href="#"><span>Blog</span></a></li>
			<!-- 			<li class=""><a href="#"><span>Custom Import</span></a></li>
						<li class=""><a href="#"><span>Custom Report</span></a></li>
						<li class=""><a href="#"><span>Data Imports</span></a></li> 
						<li class=""><a href="#"><span>Data Management</span></a></li>
						<li class=""><a href="#"><span>Discussion</span></a></li>
						<li class=""><a href="#"><span>Gallery</span></a></li>-->
						<li class="hasSubmenu"><a href="#menu_hostal"
							data-toggle="collapse" class="collapsed"><span> Hostel<i
									class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_hostal" class="collapse" style="height: 0px;">
								<li class=""><a href="hostelDetail"><span>Hostel</span></a></li>
								<li class=""><a href="room_details"><span>Rooms</span></a></li>
							<!-- 	<li class=""><a href="#"><span>Room Allocation</span></a></li> -->
								<li class=""><a href="feecollectiondashbord"><span>Fee
											Collection</span></a></li>
								<li class=""><a href="hostel_fee_pay"><span>Hostel Fee Pay</span></a></li>
							<!-- 	<li class=""><a href="#"><span>Hostel Fee
											Defaulters</span></a></li>
								<li class=""><a href="#"><span>Pay Student
											Hostel fee</span></a></li> -->

							</ul></li>
						<li class="hasSubmenu"><a href="#menu_inven"
							data-toggle="collapse" class="collapsed"><span>
									Inventory<i class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_inven" class="collapse" style="height: 0px;">
								<li class=""><a href="#"><span>Store Category</span></a></li>
								<li class=""><a href="#"><span>Store Type</span></a></li>
								<li class=""><a href="#"><span>Store</span></a></li>
								<li class=""><a href="#"><span>Store Iteams</span></a></li>
								<li class=""><a href="#"><span>Supplier Type</span></a></li>
								<li class=""><a href="#"><span>Supplier</span></a></li>
								<li class=""><a href="#"><span>Indents</span></a></li>
								<li class=""><a href="#"><span>Purchase Order</span></a></li>
								<li class=""><a href="product_edit.html"><span>GRN</span></a></li>

							</ul></li>
						<li class="hasSubmenu"><a href="#menu_lib"
							data-toggle="collapse" class="collapsed"><span>
									Library<i class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_lib" class="collapse" style="height: 0px;">
								<li class=""><a href="managebooks"><span>Manage Book</span></a></li>
								<li class=""><a href="searchbook"><span>Search Book</span></a></li>
								<li class=""><a href="returnbook"><span>Return book</span></a></li>
								<li class=""><a href="issuebooks"><span>issue book</span></a></li>
								<li class=""><a href="librarycardsetting"><span>Library Setting</span></a></li>
								<li class=""><a href="movementlog"><span>Movement Log</span></a></li>
								<li class=""><a href="bookrenewal"><span>Book Renewal</span></a></li>

							</ul></li>
					<!-- 	<li class=""><a href="#"><span>Inventory</span></a></li> 
						<li class=""><a href="#"><span>Placement</span></a></li>
						<li class=""><a href="#"><span>Poll</span></a></li>
						<li class=""><a href="#"><span>Tasks</span></a></li> -->
						<li class="hasSubmenu"><a href="#menu_trans"
							data-toggle="collapse" class="collapsed"><span>
									Transport<i class="icon-chevron-right icon-white"></i>
							</span></a>
							<ul id="menu_trans" class="collapse" style="height: 0px;">
								<li class=""><a href="routedetails"><span>Set roots</span></a></li>
								<li class=""><a href="vehicledetails"><span>Vehicle</span></a></li>
								<li class=""><a href="transportdetails"><span>transport</span></a></li>
								<li class=""><a href="transportfee"><span>transport fee</span></a></li>

							</ul></li>
							
					</ul></li>
					</sec:authorize>
				<li class="hidden-phone">
					<div class="collapse" id="themer">
						<div class="wrapper">
							<span class="close2">× close</span>
							<h4>
								Themer <span>color</span>
							</h4>
							<ul>
								<li>Theme: <select class="pull-right" id="themer-theme"><option
											value="0">Default</option>
										<option value="1">Brown</option>
										<option value="2">Purple-Gray</option>
										<option value="3">Purple-Wine</option>
										<option value="4">Blue-Gray</option>
										<option value="5">Green Army</option>
										<option value="6">Black &amp; White</option></select>
									<div class="clearfix"></div></li>
								<li>Primary Color: <span
									class="minicolors minicolors-position-left"><input
										type="text" id="themer-primary-cp" data-position="left"
										data-textfield="false" data-slider="hue"
										data-default="#71c39a" data-type="minicolors" size="7"
										maxlength="7" class="minicolors-hidden"><span
										class="minicolors-swatch"><span
											style="background-color: rgb(113, 195, 154);"></span></span><span
										class="minicolors-panel minicolors-slider-hue"><span
											class="minicolors-slider"><span
												class="minicolors-picker" style="top: 87.5px;"></span></span><span
											class="minicolors-opacity-slider"><span
												class="minicolors-picker"></span></span><span
											class="minicolors-grid"
											style="background-color: rgb(0, 255, 128);"><span
												class="minicolors-grid-inner"></span><span
												class="minicolors-picker" style="top: 35px; left: 64px;"><span></span></span></span></span></span>
									<div class="clearfix"></div></li>
								<li><span id="themer-custom-reset" class="link">reset
										theme</span> <span class="pull-right"><label>advanced
											<input type="checkbox" id="themer-advanced-toggle" value="1">
									</label></span></li>
							</ul>
							<div class="hide" id="themer-getcode">
								<div class="separator"></div>
								<button id="themer-getcode-less"
									class="btn btn-primary btn-small pull-right btn-icon glyphicons download">
									<i></i>Get LESS
								</button>
								<button id="themer-getcode-css"
									class="btn btn-inverse btn-small pull-right btn-icon glyphicons download">
									<i></i>Get CSS
								</button>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</li>

			</ul>
			<sec:authorize access="isAuthenticated()">
				<span class="profile"> <span> <strong><a
							href="#"><sec:authentication property="principal.username" /></a></strong><a
						id="logout" href="${baseurl}logout">LOGOUT</a>
				</span> <a href="form_demo.html" class="img"><img alt="Mr. Awesome"
						src="http://www.placehold.it/74x74/232323&amp;text=photo"></a>
				</span>
			</sec:authorize>
		</div>
	</div>
</div>










