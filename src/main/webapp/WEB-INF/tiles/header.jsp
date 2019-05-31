<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/" var="baseurl" />



<ul class="menu"
	style="height: 61px; margin-left: -48px; width: 1096px;">
	<!-- **********************************Dashboard******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li><a href="home" class="parent"><span
				style="height: 40px; width: 130px;">Dashboard</span></a></li>
	</sec:authorize>

	<!-- **********************************Student******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li class="icon"><a href="students-manage" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Students</span></a>
			<ul>
				<li><a href="application-form.html"><span><font
							size="3">Enquiry Form</font></span></a></li>
				<li><a href="studentsadmission"><span><font size="3">Students
								Admission</font></span></a></li>
				<li><a href="student-attendance-menu"><span><font
							size="3">Students Attendance</font></span></a></li>
				<li><a href="student-details"><span><font size="3">Search
								Students and Manage Profiles</font></span></a></li>
				<li><a href="student-performa"><span><font size="3">Students
								Information</font></span></a></li>
				<li><a href="registration-menu"><span><font size="3">Registration
								Details</font></span></a>

					<ul>
						<li><a href="application-details.html"><span><font
									size="3">Registration Details</font></span></a></li>
						<li><a href="cancelled-registration"><span><font
									size="3">Registration Cancellation Details</font></span></a></li>
						<li><a href="transferred-students"><span><font
									size="3">Students Transferred Details</font></span></a></li>


					</ul></li>
				<li><a href="batch-promote.html"><span><font
							size="3">Batch Promote</font></span></a></li>
				<li><a href="exam-report-menu.html"><span><font
							size="3">Exam Report Section</font></span></a></li>
				<li><a href="student-login-details"><span><font
							size="3">View Students Login Details</font></span></a></li>
				<li><a href="cancelled-students"><span><font
							size="3">View Cancelled Students</font></span></a></li>

				<li><a href="characterCertificate.html"><span><font
							size="3">Character Certificate</font></span></a></li>
				<li><a href="gatepass-menu"><span><font size="3">
								Gate Pass</font></span></a>
					<ul>
						<li><a href="generate-gatepass"><span><font
									size="3">Generate Gate Pass</font></span></a></li>
						<li><a href="check-gatePass"><span><font size="3">Check
										Gate Pass Details</font></span></a></li>
					</ul></li>
				<li><a href="app-form.html" target="_blank"><span><font
							size="3">Download App Form</font></span></a></li>
				<li><a href="student-documents"><span><font size="3">Student
								Documents</font></span></a></li>
			</ul></li>
	</sec:authorize>

	<!-- **********************************Staff******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li class="icon"><a href="employee" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Staff</span></a>
			<ul>
				<li><a href="employee-registration"><span><font
							size="3">Staff Registration</font></span></a></li>
				<li><a href="employee-attendance-menu"><span><font
							size="3">Staff Attendance</font></span></a></li>
				<li><a href="employee-details"><span><font size="3">Search
								Staff and Manage Profiles</font></span></a></li>
				<li><a href="classes-assign"><span><font size="3">Assign
								Class</font></span></a></li>
				<li><a href="employee-documents"><span><font
							size="3">Employee Documents</font></span></a></li>
				<li><a href="salary-menu"><span><font size="3">Employee
								Salary </font></span></a>

					<ul>
						<li><a href="create-salary"><span><font size="3">Allot
										Salary</font></span></a></li>
						<li><a href="pay-salary"><span><font size="3">Pay
										Salary</font></span></a></li>
						<li><a href="inhand-cheque"><span><font size="3">InHand
										Cheque List</font></span></a></li>
						<li><a href="view-monthwise-paidsalary"><span><font
									size="3">View Month Wise Paid Salary Details</font></span></a></li>
						<li><a href="pay-advance-salary"><span><font
									size="3">Pay Advance </font></span></a></li>

					</ul></li>

			</ul></li>
	</sec:authorize>

	<!-- **********************************FEES******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li class="icon"><a href="fees-menu" class="parent"><span
				class="ico-caret-down" style="height: 40px; width: 60px;">Fees</span></a>
			<ul>
				<li><a class="blblue1" href="create-edit-view-fees-categories"><span><font
							size="3">Create Edit View Fee Category</font></span></a></li>
				<li><a href="allot-fees-menu"><span><font size="3">Fee
								Allotment To Student</font></span></a>
					<ul>
						<li><a href="allot-classwise-fee"><span><font
									size="3">Allot Fee Class Wise</font></span></a></li>
						<li><a href="allot-sectionwise-fee"><span><font
									size="3">Allot Fee Section Wise</font></span></a></li>
						<li><a href="allot-studentwise-fee"><span><font
									size="3">Allot Fee Student Wise</font></span></a></li>

					</ul></li>
				<li><a href="fee-payment-tally.html"><span><font
							size="3">Fee Payment</font></span></a></li>
				<li><a href="search-students-fee-details"><span><font
							size="3">Check Fee Payment Status </font></span></a></li>

				<li><a href="fee-submission-details"><span><font
							size="3">Fee Submission Records </font></span></a></li>
				<li><a class="blblue1" href="fee-defaulter-menu"><span><font
							size="3">Fee Dues </font></span></a>
					<ul>
						<li><a href="all-defaulters?pageno=1"><span><font
									size="3">All Dues</font></span></a></li>
						<li><a href="class-wise-defaulters"><span><font
									size="3">Class Dues</font></span></a></li>
					</ul></li>
				<li><a href="cheque-inprogress.html"><span><font
							size="3">Inprogress Cheque List</font></span></a></li>
				<li><a href="view-student-alloted-fee.html"><span><font
							size="3">View Allotted Fees To Student</font></span></a></li>
				<li><a href="view-edit-student-alloted-fee.html"><span><font
							size="3">View Concession List</font></span></a></li>
				<li><a href="view-fee-pay-by-cheque.html"><span><font
							size="3">View Fee Pay By Cheque</font></span></a></li>
				<li><a href="fee-slip-search.html"><span><font
							size="3">Fee Slip Search</font></span></a>
					<ul>
						<li><a href="search-by-slip-no.html"><span><font
									size="3">Search by Slip No. </font></span></a></li>
						<li><a href="search-by-student-name.html"><span><font
									size="3">Search by Student Name </font></span></a></li>
						<li><a href="search-by-date.html"><span><font
									size="3">Search by Date </font></span></a></li>
						<li><a href="search-by-admission.html"><span><font
									size="3">Search by Admission No.</font></span></a></li>
						
					</ul></li>
					

			</ul></li>
	</sec:authorize>
	<!-- **********************************BOOK******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li class="icon"><a href="book-menu" class="parent"><span
				class="ico-caret-down" style="width: 90px; height: 40px;">Book</span></a>
			<ul>
				<li><a href="book-purchase"><span><font size="3">Purchase
								Books</font></span></a></li>
				<li><a href="sell-book"><span><font size="3">Sell
								Book</font></span></a></li>
				<li><a href="book-purchase-details"><span><font
							size="3">Purchased Book Details</font></span></a></li>
				<li><a href="classwise-book-purchased"><span><font
							size="3">Check Class Wise Book Purchased Details</font></span></a></li>
				<li><a href="check-book-sold"><span><font size="3">Check
								Sold Book </font></span></a></li>
				<li><a href="sold-book-details"><span><font size="3">
								Sold Book Details </font></span></a></li>
				<li><a href="view-book-stock"><span><font size="3">View
								Book Stock Details</font></span></a></li>

			</ul></li>

	</sec:authorize>

	<!-- **********************************UNIFORM******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">

		<li class="icon"><a href="uniform-menu" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Uniform</span></a>

			<ul>
				<li><a href="uniform-purchase"><span><font size="3">Purchase
								Uniform </font></span></a></li>
				<li><a href="sell-uniform"><span><font size="3">Sell
								Uniform</font></span></a></li>
				<li><a href="view-uniform-stock"><span><font
							size="3">View Uniform Stock Details</font></span></a></li>
				<li><a href="purchased-uniform-details"><span><font
							size="3">Purchased Uniform Details</font></span></a></li>

				<li><a href="check-uniform-purchased"><span><font
							size="3">Search Purchased Uniforms by size</font></span></a></li>
				<li><a href="check-uniform-sold"><span><font
							size="3">View Sold Uniforms</font></span></a></li>
				<li><a href="sold-uniform-details"><span><font
							size="3">Sold Uniforms Details</font></span></a></li>
				<li><a href="class-wise-solddetails"><span><font
							size="3">View ClassWise Sold Uniform Details</font></span></a></li>
			</ul></li>

	</sec:authorize>

	<!-- **********************************COLLECTION******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">

		<li class="icon"><a href="collections-menu" class="parent"><span
				class="ico-caret-down" style="width: 110px; height: 40px;">Collection</span></a>

			<ul>
				<li><a class="blblue1" href="collections-report-menu"><span><font
							size="3">Show All Collections </font></span></a>
					<ul>
						<li><a href="show-overall-collections"><span><font
									size="3">Overall Fee Collections</font></span></a></li>
						<li><a href="show-overall-uniform?pageno=1"><span><font
									size="3">Overall Uniform Collections</font></span></a></li>
						<li><a href="show-overall-book?pageno=1"><span><font
									size="3">Overall Books Collections</font></span></a></li>
						<li><a href="show-todays-collections"><span><font
									size="3">Today's Collections</font></span></a></li>
						<li><a href="show-datewise-collections"><span><font
									size="3">Date Wise Collections</font></span></a></li>
					</ul></li>
				<li><a href="all-expense-menu"><span><font size="3">Show
								All Expenses</font></span></a>
					<ul>
						<li><a href="show-overall-expenses"><span><font
									size="3">Overall Expenses</font></span></a></li>
						<li><a href="show-todays-expenses"><span><font
									size="3">Today's Expenses</font></span></a></li>
						<li><a href="show-datewise-expenses"><span><font
									size="3">Date Wise Expenses</font></span></a></li>
					</ul></li>
				<li><a href="add-expense"><span><font size="3">Add
								Expenses</font></span></a>
				<li><a href="available-collections-menu"><span><font
							size="3">Check available Collections</font></span></a>
					<ul>

						<li><a href="monthly-available-collections-report"><span><font
									size="3">Monthly Available Collections Report</font></span></a></li>
						<li><a href="yearly-available-collections-report"><span><font
									size="3">Yearly Available Collections Report</font></span></a></li>
						<li><a href="today-collections-expense-report"><span><font
									size="3">Today's Available Collections Report</font></span></a></li>
					</ul></li>
			</ul></li>
	</sec:authorize>

	<!-- **********************************NOTICE******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">

		<li class="icon"><a href="manage-notice.html" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Notice</span></a>
			<ul>
				<li><a href="create-notice.html"><span><font
							size="3">Create New Notice </font></span></a></li>
				<li><a href="show-notice.html?pageno=1""><span><font
							size="3">Edit,Delete & View Notice </font></span></a></li>
			</ul></li>

	</sec:authorize>


	<!-- **********************************SETTINGS******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li class="icon"><a href="settings" class="parent"><span
				class="ico-caret-down" style="height: 40px; width: 90px;">Settings</span></a>
			<ul>
				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-session.html"><span><font
								size="3">Manage Sessions</font></span></a></li>
				</sec:authorize>
				<%-- <sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="library.html"><span><font
								size="3">Manage Library</font></span></a></li>
				</sec:authorize>
 --%>
				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-class.html"><span><font
								size="3">Manage Classes</font></span></a></li>
				</sec:authorize>

				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-section.html"><span><font
								size="3">Manage Section</font></span></a></li>
				</sec:authorize>

				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-student-categories"><span><font
								size="3">Manage Student Categories</font></span></a>
						<ul>
							<li><a href="create-student-categories"><span><font
										size="3">Create Student Category</font></span></a></li>
							<li><a href="update-student-categories"><span><font
										size="3">Update Student Category</font></span></a></li>
							<li><a href="delete-student-categories"><span><font
										size="3">Delete Student Category</font></span></a></li>

						</ul></li>


				</sec:authorize>

				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-country"><span><font size="3">Manage
									Countries</font></span></a>
						<ul>
							<li><a href="create-country"><span><font size="3">Create
											Countries</font></span></a></li>
							<li><a href="show-country"><span><font size="3">Update
											Countries</font></span></a></li>
							<li><a href="delete-country"><span><font size="3">Delete
											Countries</font></span></a></li>
						</ul></li>
				</sec:authorize>

				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-state"><span><font size="3">Manage
									States</font></span></a>
						<ul>
							<li><a href="create-state"><span><font size="3">Create
											States</font></span></a></li>
							<li><a href="update-state"><span><font size="3">Update
											States</font></span></a></li>
							<li><a href="delete-state"><span><font size="3">Delete
											States</font></span></a></li>
						</ul></li>
				</sec:authorize>

				<sec:authorize ifAnyGranted="ROLE_ADMIN">
					<li><a href="manage-city"><span><font size="3">Manage
									Cities</font></span></a>
						<ul>
							<li><a href="create-city"><span><font size="3">Create
											Cities</font></span></a></li>
							<li><a href="show-city"><span><font size="3">Update
											Cities</font></span></a></li>
							<li><a href="delete-city"><span><font size="3">Delete
											Cities</font></span></a></li>
						</ul></li>
					<li><a href="add-employee-role"><span><font
								size="3">Add Employee Role</font></span></a></li>
					<li><a href="manage-bounce-amount"><span><font
								size="3">Manage Bounce Amount</font></span></a></li>
					<li><a href="manage-lastdates.html"><span><font
								size="3">Manage Due Date</font></span></a></li>
					<li><a href="manage-student-subjects"><span><font
								size="3">Manage Subjects</font></span></a></li>
					<li><a href="fine.html"><span><font size="3">Manage
									Fine</font></span></a></li>
					<li><a href="bank_menu"><span><font size="3">Manage
									Bank</font></span></a></li>
					<li><a href="manage-document.html"><span><font
								size="3">Manage Documents</font></span></a></li>
				</sec:authorize>
				
			</ul></li>
	</sec:authorize>


	<!-- **********************************LOGOUT******************************** -->
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		<li><a href="${baseurl}logout"><span>Logout</span></a></li>
	</sec:authorize>
	<!-- **********************************END ROLL ADMIN******************************** -->

	<!-- **********************************ROLL EMPLOYEE******************************** -->
	<!-- **********************************Dashboard******************************** -->
	<sec:authorize ifAnyGranted="ROLE_EMPLOYEE">
		<li><a href="home" class="parent"><span
				style="height: 40px; width: 130px;">Dashboard</span></a></li>

		<li class="icon"><a href="students-manage" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Students</span></a>
			<ul>
				<li><a href="application-form.html"><span><font
							size="3">Students Registration</font></span></a></li>
				<li><a href="studentsadmission"><span><font size="3">Students
								Admission</font></span></a></li>
				<li><a href="student-attendance-menu"><span><font
							size="3">Students Attendance</font></span></a></li>
				<li><a href="student-details"><span><font size="3">Search
								Students and Manage Profiles</font></span></a></li>
				<li><a href="registration-menu"><span><font size="3">Students
								Registration Details</font></span></a>

					<ul>
						<li><a href="application-details.html"><span><font
									size="3">Registration Details</font></span></a></li>
						<li><a href="cancelled-registration"><span><font
									size="3">Registration Cancellation Details</font></span></a></li>
						<li><a href="transferred-students"><span><font
									size="3">Students Transferred Details</font></span></a></li>


					</ul></li>
				<li><a href="exam-report-menu.html"><span><font
							size="3">Exam Report Section</font></span></a></li>
				<li><a href="student-login-details"><span><font
							size="3">View Students Login Details</font></span></a></li>
				<li><a href="cancelled-students"><span><font
							size="3">View Cancelled Students</font></span></a></li>

				<li><a href="batch-promote.html"><span><font
							size="3">Batch Promote</font></span></a></li>
				<li><a href="gatepass-menu"><span><font size="3">
								Gate Pass</font></span></a>
					<ul>
						<li><a href="generate-gatepass"><span><font
									size="3">Generate Gate Pass</font></span></a></li>
						<li><a href="check-gatePass"><span><font size="3">Check
										Gate Pass Details</font></span></a></li>
					</ul></li>
				<li><a href="app-form.html" target="_blank"><span><font
							size="3">Download App Form</font></span></a></li>
				<li><a href="student-documents"><span><font size="3">Student
								Documents</font></span></a></li>
			</ul></li>
		<!-- **********************************PROFILE******************************** -->
		<li class="icon"><a href="fees-menu" class="parent"><span
				class="ico-caret-down" style="height: 40px; width: 60px;">Fees</span></a>
			<ul>
				<li><a class="blblue1" href="create-edit-view-fees-categories"><span><font
							size="3">Create Edit View Fee Category</font></span></a></li>
				<li><a href="allot-fees-menu"><span><font size="3">Fee
								Allotment To Student</font></span></a>
					<ul>
						<li><a href="allot-classwise-fee"><span><font
									size="3">Allot Fee Class Wise</font></span></a></li>
						<li><a href="allot-sectionwise-fee"><span><font
									size="3">Allot Fee Section Wise</font></span></a></li>
						<li><a href="allot-studentwise-fee"><span><font
									size="3">Allot Fee Student Wise</font></span></a></li>

					</ul></li>
				<li><a href="fee-payment-tally.html"><span><font
							size="3">Fee Payment</font></span></a></li>
				<li><a href="search-students-fee-details"><span><font
							size="3">Check Fee Payment Status </font></span></a></li>

				<li><a href="fee-submission-details"><span><font
							size="3">Fee Submission Records </font></span></a></li>
				<li><a class="blblue1" href="fee-defaulter-menu"><span><font
							size="3">Fee Dues </font></span></a>
					<ul>
						<li><a href="all-defaulters?pageno=1"><span><font
									size="3">All Dues</font></span></a></li>
						<li><a href="class-wise-defaulters"><span><font
									size="3">Class Dues</font></span></a></li>
					</ul></li>
				<li><a href="cheque-inprogress.html"><span><font
							size="3">Inprogress Cheque List</font></span></a></li>
				<li><a href="view-student-alloted-fee.html"><span><font
							size="3">View Allotted Fees To Student</font></span></a></li>
				<li><a href="fee-slip-search.html"><span><font
							size="3">Fee Slip Search</font></span></a>
					<ul>
						<li><a href="search-by-slip-no.html"><span><font
									size="3">Search by Slip No. </font></span></a></li>
						<li><a href="search-by-student-name.html"><span><font
									size="3">Search by Student Name </font></span></a></li>
						<li><a href="search-by-date.html"><span><font
									size="3">Search by Date </font></span></a></li>
						<li><a href="search-by-admission.html"><span><font
									size="3">Search by Admission No.</font></span></a></li>
					</ul></li>

			</ul></li>
	</sec:authorize>
	<%-- <sec:authorize ifAnyGranted="ROLE_EMPLOYEE">
		<li><a href="employeemy-profile" class="parent"><span
				style="height: 40px; width: 130px;">View Profile</span></a></li>
	</sec:authorize> --%>

	<%-- <sec:authorize ifAnyGranted="ROLE_EMPLOYEE">
		<li><a href="change-emp-password-page?id=${EMPLOYER_id}"
			class="parent"><span style="height: 40px; width: 185px;">Change
					Password</span></a></li>
	</sec:authorize> --%>

	<!-- **********************************SEARCH******************************** -->


	<!-- **********************************EXAM REPORT******************************** -->

	<sec:authorize ifAnyGranted="ROLE_EMPLOYEE">
		<c:if test="${sessionScope.assigned== 'yes'}">
			<li class="icon"><a href="exam-report-menu.html" class="parent"><span
					class="ico-caret-down" style="width: 155px; height: 40px;">Exam
						Section</span></a>
				<ul>
					<li><a href="final-exam-menu-page.html"><span><font
								size="3">Annual Exam Section</font></span></a>
						<ul>
							<li><a href="assign-annual-marks-to-student.html"><span><font
										size="3">Create Report Cards</font></span></a></li>
							<li><a href="view-student-report-cards.html"><span><font
										size="3">View Report Cards</font></span></a></li>
						</ul></li>
					<li><a href="monthly-exam-menu.html"><span><font
								size="3">Monthly Exam Section</font></span></a>
						<ul>
							<li><a href="assign-marks-to-student.html"><span><font
										size="3">Assign Marks</font></span></a></li>
							<li><a href="view-monthly-exam-report.html"><span><font
										size="3">View Reports</font></span></a></li>
							<li><a href="viewmonthlysubjectmarks.html"><span><font
										size="3">Edit Subject Marks</font></span></a></li>
						</ul></li>
				</ul></li>
		</c:if>
		<li><a href="home" class="parent"><span
				class="ico-caret-down" style="width: 155px; height: 40px;">Attendance</span></a>
			<ul>
				<li><a href="employee-my-attendace-report"><span
						style="width: 170px;"><font size="3">My Attendance</font></span></a></li>
				<c:if test="${sessionScope.assigned== 'yes'}">
					<li><a href="student-attendance-menu"><span><font
								size="3">Student Attendance</font></span></a></li>
				</c:if>
			</ul></li>
		<li class="icon"><a href="manage-notice.html" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Notice</span></a>
			<ul>
				<li><a href="create-notice.html"><span><font
							size="3">Create New Notice </font></span></a></li>
				<li><a href="show-notice.html?pageno=1"><span><font
							size="3">Edit,Delete & View Notice </font></span></a></li>
			</ul></li>

	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_EMPLOYEE">
		<li class="icon"><a href="book-menu" class="parent"><span
				class="ico-caret-down" style="width: 90px; height: 40px;">Book</span></a>
			<ul>
				<li><a href="book-purchase"><span><font size="3">Purchase
								Books</font></span></a></li>
				<li><a href="sell-book"><span><font size="3">Sell
								Book</font></span></a></li>
				<li><a href="book-purchase-details"><span><font
							size="3">Purchased Book Details</font></span></a></li>
				<li><a href="classwise-book-purchased"><span><font
							size="3">Check Class Wise Book Purchased Details</font></span></a></li>
				<li><a href="check-book-sold"><span><font size="3">Check
								Sold Book Details</font></span></a></li>
				<li><a href="view-book-stock"><span><font size="3">View
								Book Stock Details</font></span></a></li>

			</ul></li>
		<li class="icon"><a href="uniform-menu" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Uniform</span></a>

			<ul>
				<li><a href="uniform-purchase"><span><font size="3">Purchase
								Uniform </font></span></a></li>
				<li><a href="sell-uniform"><span><font size="3">Sell
								Uniform</font></span></a></li>
				<li><a href="view-uniform-stock"><span><font
							size="3">View Uniform Stock Details</font></span></a></li>
				<li><a href="purchased-uniform-details"><span><font
							size="3">Purchased Uniform Details</font></span></a></li>

				<li><a href="check-uniform-purchased"><span><font
							size="3">Search Purchased Uniforms by size</font></span></a></li>
				<li><a href="check-uniform-sold"><span><font
							size="3">View Sold Uniforms</font></span></a></li>
				<li><a href="class-wise-solddetails"><span><font
							size="3">View ClassWise Sold Uniform Details</font></span></a></li>
			</ul></li>
		<li><a href="${baseurl}logout"><span>Logout</span></a></li>
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_STUDENT">

		<li><a href="home" class="parent"><span
				style="height: 40px; width: 150px;">Dashboard</span></a></li>

	</sec:authorize>
	<!-- **********************************END ROLL EMPLOYEE******************************** -->

	<!-- **********************************ROLE USER******************************** -->
	<!-- **********************************PROFILE******************************** -->
	<sec:authorize ifAnyGranted="ROLE_STUDENT">
		<li><a href="student-profile"><span
				style="height: 40px; width: 150px;">Profile </span></a></li>
	</sec:authorize>

	<!-- **********************************ATTENDANCE******************************** -->
	<sec:authorize ifAnyGranted="ROLE_STUDENT">
		<li><a href="attendancestu-report.html"><span
				style="height: 40px; width: 190px;">Attendance Report</span></a></li>
	</sec:authorize>

	<!-- **********************************REPORT******************************** -->
	<sec:authorize ifAnyGranted="ROLE_STUDENT">
		<li><a href="my-monthly-exam-report.html"><span
				style="height: 40px; width: 170px;">Test Report</span></a></li>
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_STUDENT">
		<li><a href="view-my-report-cards.html"><span
				style="height: 40px; width: 150px;">Report Card</span></a></li>
	</sec:authorize>
	<!-- **********************************LOGOUT******************************** -->
	<sec:authorize ifAnyGranted="ROLE_STUDENT">
		<li><a href="${baseurl}logout"><span>Logout</span></a></li>
	</sec:authorize>
	<sec:authorize ifAnyGranted="ROLE_BRANCH">
		<li><a href="branchhome" class="parent"><span
				style="height: 40px; width: 130px;">Dashboard</span></a></li>
	</sec:authorize>

	<!-- **********************************Student******************************** -->
	<sec:authorize ifAnyGranted="ROLE_BRANCH">
		<li class="icon"><a href="students-manage" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Students</span></a>
			<ul>
				<li><a href="application-form.html"><span><font
							size="3">Students Registration</font></span></a></li>
				<li><a href="studentsadmission"><span><font size="3">Students
								Admission</font></span></a></li>
				<li><a href="student-attendance-menu"><span><font
							size="3">Students Attendance</font></span></a></li>
				<li><a href="student-details"><span><font size="3">Search
								Students and Manage Profiles</font></span></a></li>
				<li><a href="application-details.html"><span><font
							size="3">Students Registration Details</font></span></a></li>
				<li><a href="exam-report-menu.html"><span><font
							size="3">Exam Report Section</font></span></a></li>
				<li><a href="student-login-details"><span><font
							size="3">View Students Login Details</font></span></a></li>
				<li><a href="cancelled-students"><span><font
							size="3">View Cancelled Students</font></span></a></li>
				<li><a href="batch-promote.html"><span><font
							size="3">Batch Promote</font></span></a></li>
				<li><a href="gatepass-menu"><span><font size="3">
								Gate Pass</font></span></a>
					<ul>
						<li><a href="generate-gatepass"><span><font
									size="3">Generate Gate Pass</font></span></a></li>
						<li><a href="check-gatePass"><span><font size="3">Check
										Gate Pass Details</font></span></a></li>
					</ul></li>
				<li><a href="app-form.html" target="_blank"><span><font
							size="3">Download App Form</font></span></a></li>
				<li><a href="student-documents"><span><font size="3">Student
								Documents</font></span></a></li>
			</ul></li>
		<li class="icon"><a href="employee" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Staff</span></a>
			<ul>
				<li><a href="employee-registration"><span><font
							size="3">Staff Registration</font></span></a></li>
				<li><a href="employee-attendance-menu"><span><font
							size="3">Staff Attendance</font></span></a></li>
				<li><a href="employee-details"><span><font size="3">Search
								Staff and Manage Profiles</font></span></a></li>
				<li><a href="classes-assign"><span><font size="3">Assign
								Class</font></span></a></li>
				<li><a href="employee-documents"><span><font
							size="3">Employee Documents</font></span></a></li>
				<li><a href="salary-menu"><span><font size="3">Employee
								Salary </font></span></a>

					<ul>
						<li><a href="create-salary"><span><font size="3">Allot
										Salary</font></span></a></li>
						<li><a href="pay-salary"><span><font size="3">Pay
										Salary</font></span></a></li>
						<li><a href="inhand-cheque"><span><font size="3">InHand
										Cheque List</font></span></a></li>
						<li><a href="view-monthwise-paidsalary"><span><font
									size="3">View Month Wise Paid Salary Details</font></span></a></li>
						<li><a href="pay-advance-salary"><span><font
									size="3">Pay Advance </font></span></a></li>

					</ul></li>

			</ul></li>
	</sec:authorize>

	<!-- **********************************Staff******************************** -->


	<!-- **********************************FEES******************************** -->
	<sec:authorize ifAnyGranted="ROLE_BRANCH">
		<li class="icon"><a href="fees-menu" class="parent"><span
				class="ico-caret-down" style="height: 40px; width: 60px;">Fees</span></a>
			<ul>
				<li><a class="blblue1" href="create-edit-view-fees-categories"><span><font
							size="3">Create Edit View Fee Category</font></span></a></li>
				<li><a href="allot-fees-menu"><span><font size="3">Fee
								Allotment To Student</font></span></a>
					<ul>
						<li><a href="allot-classwise-fee"><span><font
									size="3">Allot Fee Class Wise</font></span></a></li>
						<li><a href="allot-sectionwise-fee"><span><font
									size="3">Allot Fee Section Wise</font></span></a></li>
						<li><a href="allot-studentwise-fee"><span><font
									size="3">Allot Fee Student Wise</font></span></a></li>

					</ul></li>
				<li><a href="fee-payment-tally.html"><span><font
							size="3">Fee Payment</font></span></a></li>
				<li><a href="search-students-fee-details"><span><font
							size="3">Check Fee Payment Status </font></span></a></li>

				<li><a href="fee-submission-details"><span><font
							size="3">Fee Submission Records </font></span></a></li>
				<li><a class="blblue1" href="fee-defaulter-menu"><span><font
							size="3">Fee Dues </font></span></a>
					<ul>
						<li><a href="all-defaulters?pageno=1"><span><font
									size="3">All Dues</font></span></a></li>
						<li><a href="class-wise-defaulters"><span><font
									size="3">Class Dues</font></span></a></li>
					</ul></li>
				<li><a href="cheque-inprogress.html"><span><font
							size="3">Inprogress Cheque List</font></span></a></li>
				<li><a href="view-student-alloted-fee.html"><span><font
							size="3">View Allotted Fees To Student</font></span></a></li>
				<li><a href="fee-slip-search.html"><span><font
							size="3">Fee Slip Search</font></span></a>
					<ul>
						<li><a href="search-by-slip-no.html"><span><font
									size="3">Search by Slip No. </font></span></a></li>
						<li><a href="search-by-student-name.html"><span><font
									size="3">Search by Student Name </font></span></a></li>
						<li><a href="search-by-date.html"><span><font
									size="3">Search by Date </font></span></a></li>
						<li><a href="search-by-admission.html"><span><font
									size="3">Search by Admission No.</font></span></a></li>
					</ul></li>

			</ul></li>
	</sec:authorize>
	<!-- **********************************BOOK******************************** -->
	<sec:authorize ifAnyGranted="ROLE_BRANCH">
		<li class="icon"><a href="book-menu" class="parent"><span
				class="ico-caret-down" style="width: 90px; height: 40px;">Book</span></a>
			<ul>
				<li><a href="book-purchase"><span><font size="3">Purchase
								Books</font></span></a></li>
				<li><a href="sell-book"><span><font size="3">Sell
								Book</font></span></a></li>
				<li><a href="book-purchase-details"><span><font
							size="3">Purchased Book Details</font></span></a></li>
				<li><a href="classwise-book-purchased"><span><font
							size="3">Check Class Wise Book Purchased Details</font></span></a></li>
				<li><a href="check-book-sold"><span><font size="3">Check
								Sold Book Details</font></span></a></li>
				<li><a href="view-book-stock"><span><font size="3">View
								Book Stock Details</font></span></a></li>

			</ul></li>

	</sec:authorize>

	<!-- **********************************UNIFORM******************************** -->
	<sec:authorize ifAnyGranted="ROLE_BRANCH">

		<li class="icon"><a href="uniform-menu" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Uniform</span></a>

			<ul>
				<li><a href="uniform-purchase"><span><font size="3">Purchase
								Uniform </font></span></a></li>
				<li><a href="sell-uniform"><span><font size="3">Sell
								Uniform</font></span></a></li>
				<li><a href="view-uniform-stock"><span><font
							size="3">View Uniform Stock Details</font></span></a></li>
				<li><a href="purchased-uniform-details"><span><font
							size="3">Purchased Uniform Details</font></span></a></li>

				<li><a href="check-uniform-purchased"><span><font
							size="3">Search Purchased Uniforms by size</font></span></a></li>
				<li><a href="check-uniform-sold"><span><font
							size="3">View Sold Uniforms</font></span></a></li>
				<li><a href="class-wise-solddetails"><span><font
							size="3">View ClassWise Sold Uniform Details</font></span></a></li>
			</ul></li>

	</sec:authorize>

	<!-- **********************************COLLECTION******************************** -->

	<!-- **********************************NOTICE******************************** -->
	<sec:authorize ifAnyGranted="ROLE_BRANCH">

		<li class="icon"><a href="manage-notice.html" class="parent"
			style="background: black; border-color: transparent;"
			style="height: 40px; width: 60px;"><span class="ico-caret-down">Notice</span></a>
			<ul>
				<li><a href="create-notice.html"><span><font
							size="3">Create New Notice </font></span></a></li>
				<li><a href="show-notice.html?pageno=1""><span><font
							size="3">Edit,Delete & View Notice </font></span></a></li>
			</ul></li>

	</sec:authorize>


	<!-- **********************************SETTINGS******************************** -->

	<!-- **********************************LOGOUT******************************** -->
	<sec:authorize ifAnyGranted="ROLE_BRANCH">
		<li><a href="${baseurl}logout"><span>Logout</span></a></li>
	</sec:authorize>
	<!-- **********************************END ROLL ADMIN******************************** -->

</ul>


