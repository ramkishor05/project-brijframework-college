<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:url value="/" var="base_url"></c:url>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl" />

<div class="sidebar">

	<div class="top" style="margin-left: 20px;">
		<font size="5" color="sky blue"><b>School Management</b></font>

	</div>

	<div class="nContainer">
		<ul class="navigation bordered">
			<sec:authorize ifAnyGranted="ROLE_ADMIN">
				<c:if test="${sessionScope.active== 'home'}">

					<li class="active"><a class="blpurple" href="home"><font
							size="5"><b>Dashboard</b></font></a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
										<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
								<li><a href="salary-menu"><span>Employee Salary</span></a></li>

						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date </span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>
						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>

					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>

					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'book'}">

					<li class="active"><a class="blpurple" href="home"><font
							size="5"><b>Dashboard</b></font></a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date </span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>
						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>

					<li class="active"><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>

					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'students'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li class="active"><a class="blgreen" href="students-manage"><font
							size="5"><b>Students</b></font> </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1" href="create-edit-view-fee-category"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee </span></a></li>



						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date</span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>

						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="search-by-admission.html"><span>Search
										by Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
						<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'fee'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li class="active"><a class="blyellow" href="manage-fee"><font
							size="5"><b>Fees</b></font></a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span><font
										color="lightgreen" size="3">Create Edit View Fee
											Category</font></span></a></li>
							<li><a href="allot-fees-menu"><span><font
										color="aqua" size="3">Fee Allotment To Student</font></span></a></li>
							<li><a href="fee-payment-tally.html"><span><font
										color="red" size="3">Fee Payment</font></span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span><font
										color="yellow" size="3">Check Fee Payment Status </font></span></a></li>

							<li><a href="fee-submission-details"><span><font
										color="blue" size="3">Fee Submission Records </font></span></a></li>
							<li><a href="fee-defaulter-menu"><span><font
										color="violet" size="3">Fee Dues </font></span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date </span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>

						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="search-by-admission.html"><span>Search
										by Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'collection'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
	<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>
						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="view-alloted-fee.html"><span>Collect
										Fee</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date</span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>
						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="search-by-admission.html"><span>Search
										by Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li class="active"><a class="blred"
						href="add-collections.html"><font size="5"><b>Collections</b></font>
					</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span><font
										color="lightgreen" size="3">Show All Collections </font></span></a></li>
							<li><a href="all-expense-menu"><span><font
										color="aqua" size="3">Show All Expenses</font></span></a></li>
							<li><a href="available-collections-menu"><span><font
										color="red" size="3">Check available Collections</font></span></a></li>
							<li><a href="add-expense"><span><font
										color="yellow" size="3">Add Expenses</font></span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'settings'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>
						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>
							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>


						</ul></li>
					<li class="active"><a class="blblue" href="settings"><font
							size="5"><b>Settings</b></font></a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span>Manage
										Due Date</span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>
						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="search-by-admission.html"><span>Search
										by Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
						<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'feeslip'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span>Manage
										Due Date</span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>

						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li class="active"><a class="bldblue" href="settings"><font
							size="5"><b>Search</b></font></a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span><font
										color="lightgreen" size="3">Search by Slip No. </font></span></a></li>
							<li><a href="search-by-student-name.html"><span><font
										color="aqua" size="3">Search by Student Name </font></span></a></li>
							<li><a href="search-by-date.html"><span><font
										color="red" size="3">Search by Date </font></span></a></li>
							<li><a href="search-by-admission.html"><span><font
										color="blue" size="3">Search by Admission No.</font></span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'dress'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
	<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>
						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date </span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>

						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li class="active"><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'staff'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					<li class="active"><a class="blred" href="employee">Staff
					</a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date </span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>

						</ul></li>
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'notice'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
	<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>
						</ul></li>
					<li><a class="blred" href="employee">Staff </a>
						<div class="open"></div>
						<ul>
							<li><a href="employee-registration"><span>Staff
										Registration</span></a></li>
							<li><a href="employee-attendance-menu"><span>Staff
										Attendance</span></a></li>
							<li><a href="employee-details"><span>Search Staff
										and Manage Profiles</span></a></li>
							<li><a href="classes-assign"><span>Assign Class</span></a></li>
<li><a href="salary-menu"><span>Employee Salary</span></a></li>
						</ul></li>
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					<li><a class="blblue" href="settings">Settings</a>
						<div class="open"></div>
						<ul>
							<li><a href="manage-session.html"><span>Manage
										Sessions</span></a>
							<li><a href="manage-class.html"><span>Manage
										Student Classes</span></a></li>
							<li><a href="manage-section.html"><span>Manage
										Student Sections</span></a></li>
							<li><a href="manage-student-categories"><span>Manage
										Student Categories</span></a></li>
							<li><a href="manage-country"><span>Manage
										Countries</span></a></li>
							<li><a href="manage-state"><span>Manage States</span></a></li>
							<li><a href="manage-city"><span>Manage Cities</span></a></li>
							<li><a href="add-employee-role"><span>Add
										Employee Role</span></a></li>
							<li><a href="manage-lastdates.html"><span> Manage
										Due Date</span></a></li>
							<li><a href="manage-student-subjects"><span>
										Manage Subjects </span></a></li>

						</ul></li>
					<li class="active"><a href="manage-notice.html"
						class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span><font
										color="aqua" size="3">Create New Notice </font></span></a></li>
							<li><a href="show-notice.html?pageno=1"><span><font
										color="yellow" size="3">Edit,Delete & View Notice </font></span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					<li><a class="blred" href="add-collections.html">Collection
					</a>
						<div class="open"></div>

						<ul>
							<li><a class="blblue1" href="collections-report-menu"><span>Show
										All Collections </span></a></li>
							<li><a href="all-expense-menu"><span>Show All
										Expenses</span></a></li>
							<li><a href="available-collections-menu"><span>Check
										available Collections</span></a></li>
							<li><a href="add-expense"><span>Add Expenses</span></a></li>


						</ul></li>
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
			</sec:authorize>

<sec:authorize ifAnyGranted="ROLE_BRANCH">
				<c:if test="${sessionScope.active== 'home'}">

					<li class="active"><a class="blpurple" href="home"><font
							size="5"><b>Dashboard</b></font></a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
										<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
				
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>

					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>

				
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'book'}">

					<li class="active"><a class="blpurple" href="home"><font
							size="5"><b>Dashboard</b></font></a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
					
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>

					<li class="active"><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>

					
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'students'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li class="active"><a class="blgreen" href="students-manage"><font
							size="5"><b>Students</b></font> </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
				
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1" href="create-edit-view-fee-category"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee </span></a></li>



						</ul></li>
				
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="search-by-admission.html"><span>Search
										by Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
						<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
				
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'fee'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
				
					<li class="active"><a class="blyellow" href="manage-fee"><font
							size="5"><b>Fees</b></font></a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span><font
										color="lightgreen" size="3">Create Edit View Fee
											Category</font></span></a></li>
							<li><a href="allot-fees-menu"><span><font
										color="aqua" size="3">Fee Allotment To Student</font></span></a></li>
							<li><a href="fee-payment-tally.html"><span><font
										color="red" size="3">Fee Payment</font></span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span><font
										color="yellow" size="3">Check Fee Payment Status </font></span></a></li>

							<li><a href="fee-submission-details"><span><font
										color="blue" size="3">Fee Submission Records </font></span></a></li>
							<li><a href="fee-defaulter-menu"><span><font
										color="violet" size="3">Fee Dues </font></span></a></li>

						</ul></li>
				
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="search-by-admission.html"><span>Search
										by Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
				
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
			
				<c:if test="${sessionScope.active== 'feeslip'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
											<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>

						</ul></li>
				
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
				
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li class="active"><a class="bldblue" href="settings"><font
							size="5"><b>Search</b></font></a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span><font
										color="lightgreen" size="3">Search by Slip No. </font></span></a></li>
							<li><a href="search-by-student-name.html"><span><font
										color="aqua" size="3">Search by Student Name </font></span></a></li>
							<li><a href="search-by-date.html"><span><font
										color="red" size="3">Search by Date </font></span></a></li>
							<li><a href="search-by-admission.html"><span><font
										color="blue" size="3">Search by Admission No.</font></span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				<c:if test="${sessionScope.active== 'dress'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
	<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>
						</ul></li>
				
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
				
					<li><a href="manage-notice.html" class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span>Create New
										Notice </span></a></li>
							<li><a href="show-notice.html?pageno=1"><span>Edit,Delete
										& View Notice </span></a></li>
						</ul></li>
					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li class="active"><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
				
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
				
				<c:if test="${sessionScope.active== 'notice'}">

					<li><a class="blpurple" href="home">Dashboard</a></li>

					<li><a class="blgreen" href="students-manage">Students </a>
						<div class="open"></div>
						<ul>
							<li><a href="studentsadmission"><span>Students
										Admission</span></a></li>
							<li><a href="student-attendance-menu"><span>Students
										Attendance</span></a></li>
							<li><a href="student-details"><span>Search
										Students and Manage Profiles</span></a></li>
							<li><a href="exam-report-menu.html"><span>Exam
										Report Section</span></a></li>
							<li><a href="student-login-details"><span>View
										Students Login Details</span></a></li>
							<li><a href="cancelled-students"><span>View
										Cancelled Students</span></a></li>
							<li><a href="batch-promote.html"><span>Batch
										Promote</span></a></li>
	<li><a href="gatepass-menu"><span>
								Gate Pass</span></a></li>
						</ul></li>
				
					<li><a class="blyellow" href="manage-fee">Fees</a>
						<div class="open"></div>
						<ul>
							<li><a class="blblue1"
								href="create-edit-view-fees-categories"><span>Create
										Edit View Fee Category</span></a></li>
							<li><a href="allot-fees-menu"><span>Fee Allotment
										To Student</span></a></li>
							<li><a href="fee-payment-tally.html"><span>Fee
										Payment</span></a></li>
							<li><a class="blblue1" href="search-students-fee-details"><span>Check
										Fee Payment Status </span></a></li>

							<li><a href="fee-submission-details"><span>Fee
										Submission Records </span></a></li>
							<li><a href="fee-defaulter-menu"><span>Fee Dues </span></a></li>

						</ul></li>
					
					<li class="active"><a href="manage-notice.html"
						class="blgreen">Notice</a>

						<ul>
							<li><a href="create-notice.html"><span><font
										color="aqua" size="3">Create New Notice </font></span></a></li>
							<li><a href="show-notice.html?pageno=1"><span><font
										color="yellow" size="3">Edit,Delete & View Notice </font></span></a></li>
						</ul></li>

					<li><a class="bldblue" href="settings">Search</a>
						<div class="open"></div>
						<ul>
							<li><a href="search-by-slip-no.html"><span>Search
										by Slip No. </span></a></li>
							<li><a href="search-by-student-name.html"><span>Search
										by Student Name </span></a></li>
							<li><a href="search-by-date.html"><span>Search by
										Date </span></a></li>
							<li><a href="manage-country"><span>Search by
										Admission No.</span></a></li>

						</ul></li>
					<li><a href="uniform-menu" class="blyellow">Uniform</a>
						<div class="open"></div>

						<ul>
							<li><a href="uniform-purchase"><span>Purchase
										Uniform </span></a></li>
							<li><a href="sell-uniform"><span>Sell Uniform</span></a></li>
							<li><a href="view-uniform-stock"><span> View
										Uniform Stock Details</span></a></li>
							<li><a href="purchased-uniform-details"><span>
										Purchased Uniform Details</span></a></li>

							<li><a href="check-uniform-purchased"><span>
										Search Purchased Uniforms by size</span></a></li>
							<li><a href="check-uniform-sold"><span> View Sold
										Uniforms</span></a></li>
							<li><a href="class-wise-solddetails"><span> View
										ClassWise Sold Uniform Details</span></a></li>

						</ul></li>
					<li><a href="book-menu" class="blpurple">Book</a>
						<div class="open"></div>
						<ul>
							<li><a href="book-purchase"><span>Purchase Books</span></a></li>
							<li><a href="sell-book"><span>Sell Book</span></a></li>
							<li><a href="book-purchase-details"><span>
										Purchased Book Details</span></a></li>
							<li><a href="classwise-book-purchased"><span>
										Check Class Wise Book Purchased Details</font>
								</span></a></li>
							<li><a href="check-book-sold"><span>Check Sold
										Book Details</span></a></li>
						</ul></li>
					
					<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>
				</c:if>
			</sec:authorize>




			<sec:authorize ifAnyGranted="ROLE_EMPLOYEE">


				<li class="active"><a class="blpurple" href="home"><font
						size="5"><b>Dashboard</b></font></a></li>
				<li class="active"><a class="blyellow"
					href="employeemy-profile"><font size="3"><b>View
								Profile</b></font></a></li>
				<%-- 	<li class="active"><a class="blgreen"
					href="change-emp-password-page?id=${EMPLOYER_id}"><font
						size="3"><b>Change Password</b></font></a></li>
 --%>
				<li><a class="bldblue" href="settings"><font size="3"><b>Search</b></font></a>
					<div class="open"></div>
					<ul>
						<li><a href="search-by-slip-no.html"><span>Search
									by Slip No. </span></a></li>
						<li><a href="search-by-student-name.html"><span>Search
									by Student Name </span></a></li>
						<li><a href="search-by-date.html"><span>Search by
									Date </span></a></li>
						<li><a href="manage-country"><span>Search by
									Admission No.</span></a></li>

					</ul></li>
				<c:if test="${sessionScope.assigned== 'yes'}">
					<li><a class="bldblue" href="settings"><font size="3"><b>Exam
									Section</b></font></a>
						<div class="open"></div>
						<ul>
							<li><a href="final-exam-menu-page.html"><span>Annual
										Exam Section </span></a></li>
							<li><a href="monthly-exam-menu.html"><span>Monthly
										Exam Section </span></a></li>

						</ul></li>
					<li class="active"><a class="blgreen"
						href="student-attendance-menu"><font size="3"><b>Student
									Attendance</b></font></a></li>
				</c:if>
				<li class="active"><a class="blyellow"
					href="employee-my-attendace-report"><font size="3"><b>My
								Attendance</b></font></a></li>


				<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>

			</sec:authorize>

			<sec:authorize ifAnyGranted="ROLE_STUDENT">

				<li class="active"><a class="blpurple" href="home"><font
						size="5"><b>Dashboard</b></font></a></li>
				<li class="active"><a class="blyellow" href="student-profile"><font
						size="3"><b>Profile</b></font></a></li>
				<li class="active"><a class="blgreen"
					href="attendancestu-report.html"><font size="3"><b>Monthly
								Attendance Report</b></font></a></li>
				<li class="active"><a class="blgreen"
					href="my-monthly-exam-report.html"><font size="3"><b>Monthly
								Test Report</b></font></a></li>
				<li class="active"><a class="blgreen"
					href="view-my-report-cards.html"><font size="3"><b>Report
								Card</b></font></a></li>


				<li><a class="blorange" id="logout" href="${baseurl}logout">LOGOUT</a></li>

			</sec:authorize>
		</ul>
		<a class="close"> <span class="ico-remove"></span>
		</a>
	</div>
	.
	<div class="widget">
		<div class="datepicker"></div>
	</div>
</div>
