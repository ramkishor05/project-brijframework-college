<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/css" var="css_url" />
<c:url value="/style/theme/images/back.png" var="backurl" />
<spring:url value="/img" var="img" />
<spring:url value="/img" var="img_url" />
<c:url value="/style/theme/images/" var="StudentDetailLogo" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
	function getStudentPerforma(id) {
		$("#detail").empty();
		$("#pdf").empty();

		$
				.ajax({
					type : "post",
					url : 'get-studentperforma-byId',
					data : {
						'studentId' : id,
					},
					success : function(data, status) {
						var j = JSON.parse(data);
						var content = "";

						if (j.length == 0) {
							content += ''

						} else {
							/*content+='<div class="span6" style="margin-top: 84px; height: 141px; margin-left: 0px; width: 383px;">'
								  +'<div class="block">'
								  +'<div class="data-fluid">'
								  +'<div class="row-form" style="float: right;">'
								  +'<div class="span3"></div>'
								  +'<div class="span9" style="float: right;">'

								  +'<div class="span3" style="width: 138px; height: 137px;">'
								  +'<img src="${img}/studentImages/'+j.photo+'" style="width: 127px; height: 124px;">'
								  +'</div></div></div></div></div></div>' */

							var st = '<div class="row-form" style="height: 30px;"><div>'
									+ '<div class="span12"  style="margin-left: 0px; width: 1076px;"><a href="PDFstudent-byId?id='
									+ id
									+ ' "target="_blank"><img src="${img}/pdf.png"style="float: right; margin-top: 23px; margin-left: -10px; margin-right: 76px;"></a></div>'
									+ '</div></div>'

							content += '<div class="data-fluid">'
									+ '<div class="row-form" style="height: 30px;">'
									+ '<div class="span5"  style="margin-left: 200px; width: 135px;"><strong>Name:</strong></div>'
									+ '<div class="span3"><strong>'
									+ j.fullName
									+ '</strong></div>'
									+ '</div></div>'
									+ '<div class="data-fluid">'
									+ '<div class="row-form" style="height: 30px;">'
									+ '<div class="span5" style="width: 135px; margin-left: 200px;"><strong>Class:</strong></div>'
									+ '<div class="span3"><strong>'
									+ j.className
									+ '</strong></div>'
									+ '</div></div>'
									+ '<div class="data-fluid">'
									+ '<div class="row-form" style="height: 30px;">'
									+ '<div class="span5" style="width: 135px; margin-left: 200px;"><strong>Section:</strong></div>'
									+ '<div class="span3"><strong>'
									+ j.sectionName
									+ '</strong></div>'
									+ '</div></div>'
									+ '<div class="data-fluid">'
									+ '<div class="row-form" style="height: 30px;">'
									+ '<div class="span5" style="width: 138px; margin-left: 200px;"><strong>Admission No.:</strong></div>'
									+ '<div class="span3"><strong>'
									+ j.admissionNo
									+ '</strong></div>'
									+ '</div></div>'
									+ '<div style="margin-left: 500px; height: 190px; width: 200px; margin-top: -190px;"> <img src="${img}/studentImages/'+j.imageName+'" style="width: 127px; height: 140px;"></div>'
									+ '<h3  class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all" role="tab" id="ui-accordion-1-header-0" aria-controls="ui-accordion-1-panel-0" aria-selected="false" tabindex="-1"> Institutional Information  </h3>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 250px; margin-left: 200px;"><h5>Admission Date : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.admissionDate
									+ ' </h5></div>'
									+ '<div style="width: 257px; margin-left: 500px; margin-top: -30px;"><h5>Date Of withdrawl : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.dateOfWithdrawl
									+ ' </h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 271px;"><h5>Class : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.admitclass
									+ '</h5></div>'
									+ '<div style="width: 257px; margin-left: 500px; margin-top: -30px;"><h5>Class : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.newClass
									+ '</h5></div>'
									+ '</div>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 257px;"><h5>Roll No. : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.rollno
									+ '</h5></div>'
									+ '<div style="width: 257px; margin-left: 500px; margin-top: -30px;"><h5>LF No. : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.lfno
									+ '</h5></div>'
									+ '</div>'
									+ '<h3  class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all" role="tab" id="ui-accordion-1-header-0" aria-controls="ui-accordion-1-panel-0" aria-selected="false" tabindex="-1"> </span>Personal Information  </h3>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 221px;"><h5>Father Name : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.fatherName
									+ '</h5></div>'
									+ '<div style="width: 200px; margin-left: 532px;margin-top: -30px;"><h5 style="width: 468px;">Mother Name : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    '
									+ j.motherName
									+ ' </h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 204px;"><h5>Guradian Name : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.guardianName
									+ '</h5></div>'
									+ '<div style="width: 230px; margin-left: 475px; margin-top: -30px;"><h5>Physically Challenged : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.physicallyChallenged
									+ ' </h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 220px; margin-left: 221px;"><h5>Date Of Birth : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.dateOfBirth
									+ '</h5></div>'
									+ '<div style="width: 200px; margin-left: 576px;margin-top: -30px;"><h5>Gender : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.gender
									+ '</h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 230px; margin-left: 252px;"><h5>Religion : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.religionName
									+ '</h5></div>'
									+ '<div style="width: 200px; margin-left: 588px;margin-top: -30px;"><h5>Caste : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   '
									+ j.religionCaste
									+ '   </h5></div>'
									+ '</div>'
									+ '<h3  class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all" role="tab" id="ui-accordion-1-header-0" aria-controls="ui-accordion-1-panel-0" aria-selected="false" tabindex="-1">Contact Information  </h3>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 285px; margin-left: 254px;"><h5>Address : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.addressLine1
									+ '</h5></div>'
									+ '<div style="width: 200px; margin-left: 600px;margin-top: -30px;"><h5>City : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.city
									+ '</h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 274px;"><h5>State : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.state
									+ ' </h5></div>'
									+ '<div style="width: 200px; margin-left: 572px;margin-top: -30px;"><h5>Country : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.country
									+ ' </h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 252px;"><h5>Pincode : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.pinCode
									+ '</h5></div>'
									+ '<div style="width: 250px; margin-top: -30px; margin-left: 559px;"><h5>Phone No : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.phone
									+ ' </h5></div>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 250px; margin-left: 218px;"><h5>Mobile No : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.mobile
									+ '</h5></div>'
									+ '<div style="width: 250px; margin-left: 556px;margin-top: -30px;"><h5>Email-Id : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.email
									+ ' </h5></div>'
									+ '</div>'

									+ '<h3  class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all" role="tab" id="ui-accordion-1-header-0" aria-controls="ui-accordion-1-panel-0" aria-selected="false" tabindex="-1" style="margin-left: -16px; width: 1058px;">Previous School  Information  </h3>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 285px; margin-left: 197px;"><h5>School Name : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.schoolName
									+ '</h5></div>'
									+ '<div style="width: 200px; margin-left: 600px;margin-top: -30px;"><h5> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      </h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 229px;"><h5>Address : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     '
									+ j.schoolAddress
									+ ' </h5></div>'
									+ '<div style="width: 200px; margin-left: 572px;margin-top: -30px;"><h5> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </h5></div>'
									+ '</div><div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 242px;"><h5>Phone : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.schoolPhone
									+ '</h5></div>'
									+ '<div style="width: 250px; margin-top: -30px; margin-left: 559px;"><h5> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5></div>'

									+ '</div>'

									+ '<h3  class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all" role="tab" id="ui-accordion-1-header-0" aria-controls="ui-accordion-1-panel-0" aria-selected="false" tabindex="-1" style="width: 1055px; margin-left: -15px;"> Fee Dues  </h3>'
									+ '<div class="row-form" style="height: 23px;">'

									+ '<div style="width: 200px; margin-left: 175px;"><h5>Balance Amount : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      '
									+ j.balanceAmount + '</h5></div>'

									+ '</div>'

						}
						
						$("#detail").append(content);
						$("#detail").show();
						$("#pdf").append(st);

					},
					error : function(error, status) {
						
						var content='<div class="failedmsg">There Are No Students</div>';
						$("#detail").append(content);
						$("#detail").show();
						$("#pdf").append(st);
					}
				});

	}
</script>

<div style="background: white;">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/student_profile.jpg"
			style="width: 70px;">
		<h1>Student Information</h1>
		<h3>Student complete profile</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
	</div>
	<br>
	<div style="background: white;">
		Enter Student Id:<input type="text" id="uniquevalue"
			style="width: 250px;" onkeyup="getStudentPerforma(this.value);">
	</div>
	<div id="pdf"></div>
	<div id="detail" style=""></div>
	<div id="ui-accordion-1-panel-0"
		class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"
		aria-hidden="false" aria-expanded="true" role="tabpanel"
		aria-labelledby="ui-accordion-1-header-0"
		style="height: 1000px; display: none; margin-top: 30px;"></div>
</div>