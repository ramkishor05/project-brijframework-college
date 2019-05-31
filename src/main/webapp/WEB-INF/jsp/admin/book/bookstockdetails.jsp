<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/style/js" var="words" />
<script type="text/javascript" src="${words}/towards.js">
</script>
<script>
function getBookStockDetails(sectionId) {
	var sessionId=$("#sessionId").val();
	var classId=$("#classId").val();
	$("#bookstock").empty();
	$("#bookstock")
			.append('<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
	var url = 'getBookStockDetails/' + classId+'/'+sessionId+'/'+sectionId;
	$
			.ajax({
				url : url,

				type : 'POST',
				success : function(data, status) {
					$("#bookstock").empty();
					var j = JSON.parse(data);
					var st = "";
					var length = j.length;
					if (length == 0) {
						st = '<div class="failedmsg">No data found</div>';
					} else {

						st = st
								+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
								+ '</div><div class="block">'
								+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Book Title</th><th>Quantity Bought</th><th>Stock Left</th></tr></thead><tbody>';
						for ( var i = 0; i < length; i++) {
							st += '<tr><td>' + (i + 1) + '. </td><td>'
							        + j[i].bookTitle
									+ '</td><td>' + j[i].boughtQuantity
									+ '</td><td>' + j[i].remainingQuantity
								    + '</td></tr>';
						}
						st += '</table>';
					}
					$("#bookstock").append(st);
				},
				error : function(error, status) {
				}
			});
}
function getClear()
{
	$("#classId").val('');
	}
function getSectionList(id) {
	$("#bookstock").empty();
	$.ajax({
		type : "post",
		url : 'getsectionlist/' + id,
		success : function(data, status) {
			$("#sectionId").empty();
			var j = JSON.parse(data);
			var content = '<option value="">Select Section</option>';
			for (var i = 0; i < j.length; i++) {
				content += '<option value='+j[i].sectionId+'>'
						+ j[i].sectionName + '</option>';
			}
			$("#sectionId").append(content);
		},
		error : function(e) {

		}
	});
}

</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1> Book Stock Details</h1>
		<h3>View Book Stock Details</h3>
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

	<div class="row-form">
		<div class="span2">
			Session<font color="red">*</font>
		</div>
		<div class="span4">
			<select name="sessionId" class="form-control input-sm"
				 id="sessionId" x-data-toggle-x="tooltip" onchange="getClear();"
				title="Specify the session of the student" required="required"style="width: 257px;"
				data-original-title="Specify session">
				<c:forEach var="list" items="${sessionList}">
					<c:choose>
						<c:when test="${current.sessionId==list.sessionId}">
							<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
						</c:when>
						<c:otherwise>
							<option value="${list.sessionId}">${list.sessionDuration}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Class<font color="red">*</font>
		</div>
		<div class="span4">
			<select name="classId" class="form-control input-sm"
						id="classId" x-data-toggle-x="tooltip" required="required"
						title="Specify the class of the student" style="width: 257px;"
						data-original-title="Specifyclass" onchange="getSectionList(this.value);">
                    <option value="">Select a class</option>
						<c:forEach var="list" items="${classList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
					</select>
		</div></div>
		<div class="row-form">
		<div class="span2">
			Section<font color="red">*</font>
		</div>
		<div class="span4">
		<select id="sectionId" class="validate[required]"
					style="width: 257px;" onchange="getBookStockDetails(this.value);"
					name="sectionId" class="select">
						<option value="">Select a Section</option>
				</select></div>
	</div>
	<div class="row-form">
		<div class="span3"></div>
		<div class="span9">

			<div id="err" class="form-inline">
				<p id="v1"></p>

			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Book Stock Details</h2>
					<ul class="buttons">
						<li><a onclick="source('table_default'); return false;"
							href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>
				<div class="data-fluid" id="bookstock"></div>
			</div>
		</div>

	</div>
</div>