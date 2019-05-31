<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
function checkData()
{
	$('#maxBooks').val('');
	$('#maxDays').val('');
	$('#fineAmount').val('');
	$('#maxFine').val('');
	 $('#submitbutton').prop('value', 'Create');;
	sessionId=$('#sessionId').val();
	if(sessionId=='')
		{
		
		}
	else
		{
		$.ajax({
			url:'checkData',
			method:'POST',
			data:{
				'sessionId':sessionId,
			},
		success:function(data)
		{
			var libraryList=JSON.parse(data);
			if(!libraryList)
				{
				
				}
			else
				{
				$('#maxBooks').val(libraryList.maxBooks);
				$('#maxDays').val(libraryList.maxDays);
				$('#fineAmount').val(libraryList.fineAmount);
				$('#maxFine').val(libraryList.maxFine);
				 $('#submitbutton').prop('value', 'Update');
				}
		},
		error:function(data)
		{
		
		},
		});
		
		}
	}
</script>
<body onload="checkData();">
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/library.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Library Settings</h1>
		<h3>Manage Library</h3>
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
	
	<div id="content">
		<f:form method="post" commandName="manageLibrary" action="add-library"
			id="validate">
			<br>
			<table style="width: 800px;">
				<tr>
					<td style="width: 200px;"></td>
					<td><font color="red">${msg}</font></td>
				</tr>
				<tr>
					<td style="width: 200px;">Session:</td>
					<td><f:select path="sessionId" style="width: 300px;" class="form-control input-sm"
									id="sessionId" x-data-toggle-x="tooltip" required="required"
									title="Specify the session of the student" onchange="checkData();"
									data-original-title="Specify session">
									<c:forEach var="list" items="${sesionList}">
										<c:choose>
											<c:when test="${current.sessionId==list.sessionId}">
												<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
											</c:when>
											<c:otherwise>
												<option value="${list.sessionId}">${list.sessionDuration}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Max No Of Books</td>
					<td><f:input path="maxBooks" id="maxBooks"
							class="validate[required,custom[integer]]"
							maxlength="20" placeholder="Enter Max Books"
							style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Maximum No of Days:</td>
					<td><f:input path="maxDays" id="maxDays" maxlength="4"
							class="validate[required,custom[integer]]"
							placeholder="Enter Maximum Days" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Fine Amount:</td>
					<td><f:input path="fineAmount" id="fineAmount" maxlength="4"
							class="validate[required,custom[number]]"
							placeholder="Enter Fine Amount" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Max Fine:</td>
					<td><f:input path="maxFine" id="maxFine" 
							class="validate[required,custom[number]]"
							placeholder="Enter Max Fine" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
			<div class="toolbar bottom tar" id="hide" style="width: 460px;"
				id="hide">
				<div class="btn-group">
					<input class="btn btn-success" id="submitbutton" type="submit" value="Create">
				</div>
			</div>
			<div id="successmsg">
				<font color="red">${message}</font>
			</div>
		</f:form>
	</div>

</div>
