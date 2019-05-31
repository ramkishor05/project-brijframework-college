<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/style/theme/images/back.png" var="backurl" />
<c:url value="/style/theme/images/admission_page_logo.jpg"
	var="StudentAddLogo" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<style>
.popup {
	display: none;
	background-color: white;
	border: 1px solid lightgray;
	width: 400px;
	height: 100px;
	border-radius: 6px;
	margin: auto;
	z-index: 1;
	position: fixed;
	display: block;
	top: 152px;
	left: 200px;
	padding: 40px;
}
</style>
<script type="text/javascript">
	var count = 0;
	var flag = 0;
	var classId1 = 0;
	function getSubjectDetails(i) {
		var subjectName = $('#id' + i).text();
		var classId = $('#classId').val();
		$
				.ajax({
					type : "post",
					url : 'getSubjectDetails.html',
					data : {
						'subjectName' : subjectName,
						'classId1' : classId1
					},
					success : function(data, status) {
						var obj = JSON.parse(data);
						if (obj.length == 0) {
							var errorMessage = "No Book Found";
							$('#subjectDetailsDiv').css('color', 'red');
							$('#subjectDetailsDiv').css('text-align', 'center');
							$('#subjectDetailsDiv').empty();
							$('#subjectDetailsDiv').append(errorMessage);
						} else {
						var content = '';
						content = content
								+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
								+ '</div><div class="block"  style="width: 615px; margin-left: -1px; margin-top: -61px;"><div class="head blue"><h4 style="text-align: center; height: 30px;">Book Details</h4><div class="icon" style="margin-top: -39px; height: 22px; float:right;"><a href="javascript:hidePopup1();"><span class="ico-cancel"></span></a></div></div>'
								+ '<table class="table table-bordered table-primary"><tbody>';
						content += '<table class="table fTable lcnp" style="width: 1059px;">';
						content += '<thead>';
						content += '<tr><th style="width: 142px; text-align: center;">Book Name</th><th style="width: 65px; text-align: center;">Quantity</th><th style="width: 65px; text-align: center;">Remaining Quantity</th>';
						content += '</tr></thead><tbody>';
						for (var i = 0; i < obj.length; i++) {
							content += '<tr>';
							content += '<td style="text-align: center;">'
									+ obj[i].bookName + '</td>';
							content += '<td style="text-align: center;">'
									+ obj[i].quantity + '</td>';
							content += '<td style="text-align: center;">'
									+ obj[i].remainingQuantity + '</td>';
							content += '</tr>';
						}
						content += '</tbody><tbody></tbody></table></div></div>';
						$('#subjectDetailsDiv').empty();
						$('#subjectDetailsDiv').append(content);
						$('#subjectDetailsDiv').show();
						}
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function getsubjectList() {
		var classId = $('#classId').val();
		classId1 = classId;
		$
				.ajax({
					type : "post",
					url : 'getSubjectList.html',
					data : {
						'classId' : classId,

					},
					success : function(data, status) {
						var obj = JSON.parse(data);
						if (obj.length == 0) {
							var errorMessage = "No Subject Found";
							$('#subjectDetails').css('color', 'red');
							$('#subjectDetails').css('text-align', 'center');
							$('#subjectDetails').empty();
							$('#subjectDetails').append(errorMessage);
						} else {
							var content = '';
							content = content
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block" style="margin-left: 726px; margin-top: -64px; width: 235px;"><div class="head dblue"><h4 style="text-align: center; height: 41px;">Subjects</h4><div class="icon" style="margin-top: -43px; margin-left: 219px;"><a href="javascript:hidePopup();"><span class="ico-cancel"></span></a></div></div>'
									+ '<table class="table table-bordered table-primary"><tbody>';
							content += '<table class="table fTable lcnp" style="width: 1059px;">';
							content += '<table class="table fTable lcnp" ';
				content+='style="margin-top: -41px; width: 282px;"';
							content += '<thead>';
							content += '</thead><tbody>';
							for (var i = 0; i < obj.length; i++) {

								content += '<tr><td><a id="id'
										+ i
										+ '" href=javascript:getSubjectDetails('
										+ i + ');>' + obj[i].subjectName
										+ '</a></td></tr>';
							}
							content += '</tbody></table></div></div>';
							/* 	$('#subjectList').empty();
								$('#subjectList').append(content); */
							$('#subjectDetails').empty();
							$('#subjectDetails').append(content);
						}
						$('#subjectDiv').show();
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function setIsbn() {
		var quantity = $('#quantity').val();
		var content = '<table style="margin-left: 2px;">';
		content += '<tr><td>Enter ISBN No. for books :</td></tr>';
		var totalRow;
		var row;
		totalRow = quantity / 4;
		for (var i = 0; i < Math.floor((quantity / 4)); i++) {
			content += '<tr>'
			for (var j = 0; j < 4; j++) {
				content += '<td style="padding:5px;"><input type="text" name="isbnList['+count+'].isbnNo" id="quantity" style="width: 235px;" /></td>';
				count++;
			}
			content += '</tr>'
		}
		content += '<tr>'
		for (var k = 0; k < (quantity % 4); k++) {

			content += '<td style="padding:5px;"><input type="text"  name="isbnList['+count+'].isbnNo"    id="quantity" style="width: 235px;" /></td>';
			count++;
		}
		content += '</tr>'
		content += '</table>';
		$('#isbn').empty();
		$('#isbn').append(content);

	}

	function hidePopup() {
		$('#subjectDetails').hide();
		$('#subjectDetailsDiv').hide();
	}

	function hidePopup1() {
		$('#subjectDetailsDiv').hide();
	}

	function getClear() {
		$("#msg").empty();
		$("#failedmsg").hide();
		$("#classId").val('');
		$("#sectionId").val('');
		$("#subjectName").val('');
	}
	function closePopup() {
		$('#popup').hide();
	}
</script>
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">
		<div id="content-header">
			<img alt="Show_settings" src="${img_url}/book1.jpg"
				style="width: 80px; height: 66px;">
			<h1>Add Book</h1>
			<h3>Manage library Books</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>

		<div align="center" id="error" style="color: red; margin-top: 16px;"></div>
		<div id="page-yield">



			<table
				style="width: 500px; height: 100px; margin-left: 0px; margin-top: -51px;">

				<tr>
					<td style="width: 110px; height: 30px;">Class Name:<span
						style="color: red;">*</span></td>
					<td><select id="classId" required="required" name="classId"
						style="width: 234px;" onchange="getsubjectList();">
							<option selected="selected" value="0" title="">-- Select
								Class --</option>
							<c:forEach var="list" items="${list}" varStatus="loop">
								<option value="${list.classId}" data-original-title="" title="">
									${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>
			</table>
		</div>

		<div id="subjectDetails"></div>

		<div id="subjectDetailsDiv" class="block"
			style="margin-top: 47px; display: none;"></div>



	</div>
</div>