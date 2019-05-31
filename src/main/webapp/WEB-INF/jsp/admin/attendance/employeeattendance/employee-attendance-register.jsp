<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<c:set var="now" value="<%=new java.util.Date()%>" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<link rel="stylesheet"
	href="${js_url}/fullcalendar/jquery-ui-1.10.4.custom.min.css">
<style>
.appendpop {
	display: none;
	position: fixed;
	z-index: 1;
	margin-top: -15px;
	border: 1px solid skyblue;
	border-radius: 6px;
	margin-left: 244px;
	height: auto;
	width: 650px;
	background-color: white;
	position: fixed;
}
</style>
<script type="text/javascript">

	function saveAttendanceRecord(title, todate, id) {
		 $.ajax({
			type : 'post',
			url : 'setemployee-attendance-record',
			data : {
				'id' : id,
				'title' : title,
				'cd' : todate
			},
			error : function(e) {
				alert('error in data');
			}
		}); 
	}
	function getCurrentDateData(currentDate){
		var flag=true;
		var checkTrue=[];
		
		var allArray=[];
		for(i=1;i<=$("#EmployeesDTOsLength").val();i++){
			allArray.push(i)
			var nameVariable=$('[name="name'+i+'"]');
			$.each(nameVariable,function(key,value){
					if(value.checked){
						checkTrue.push(i);
					}
			}); 
		}
		for(i=0;i<$("#EmployeesDTOsLength").val();i++){
			if(allArray[i]!=checkTrue[i]){
				flag=false;
			}
		}
        if(flag){
		 $.ajax({
				type : 'GET',
				url : 'getcurrentdatedata',
				data : {
					'currentDate' : currentDate
				},
				success : function(data, status) {
					var obj = JSON.parse(data);
					$("#submitData").empty();
					var submitData='<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
					    submitData += '<h2>Attendance Report For Date &nbsp;&nbsp;'+currentDate+'';
					    submitData += '</h2><ul class="buttons"><li><a  href="javascript:hidesubmitdata();">';
					    submitData += '<div class="icon"><span class="icon-remove"></span></div></a></li></ul></div>';
					    submitData += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table">';
						submitData += '<thead><tr><th width="25%">Title</th><th width="25%">Total</th></tr></thead><tbody>';
						$.each(obj,function(key,value){
							submitData += '<tr><td>'+value.status+'</td><td>'+value.totalNoOfDays+'</td></tr>';
						});
						submitData += '</tbody></table></div>';
						$("#submitData").append(submitData);
				},
				error : function(e) {
					alert('error in data');
				}
			}); 
        }
        else{
        	alert("Please Fill Atleast one Rodio button for every Staff Member");
        	$("#submitData").empty();
        }
	}
	
    function hidesubmitdata(){
		$("#submitData").empty();
	} 
	  $(function() {
			$('#admissionDate').datepick({
				dateFormat : "yyyy-mm-dd",
				inline:true,
				onSelect: function(dateText, inst) { 
					$("#submitData").empty();
			        var date = $(this).datepick('getDate')
			        var formatedDate=$.datepicker.formatDate('yy-mm-dd', new Date(date));
			        $.ajax({
						type : 'GET',
						url : 'getemployeeAttendancedatewisedata',
						data : {
							'Date' : formatedDate
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							$("#tablebody").empty();
							var tablebody='';
							var holiday='';
							if(obj.HOLIDAY!=''){
								holiday='<font  style="background-color:brown">'+obj.HOLIDAY+'</font>';
							}
							$('h2').empty();
							$('h2').append("Attendance For Date &nbsp;&nbsp; "+$.datepicker.formatDate('dd-M-yy', new Date(date))+"&nbsp;&nbsp;"+holiday+"");
							$.each(obj.EmployeesDTOs,function(key,value){
							   tablebody+='<tr><td>'+value.firstName+' '+value.lastName+'</td>';
							    tablebody+='<td>';
							   if(value.status=='PRESENT'){
								   tablebody+='<input type="radio" name="name'+(key+1)+'" value="PRESENT" checked="checked" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
									}
                                else{
                                	tablebody+='<input type="radio" name="name'+(key+1)+'" value="PRESENT" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
                                }
							   tablebody+='</td>'; 
							   tablebody+='<td>';
 							   if(value.status=='ABSENT'){
 								  tablebody+='<input type="radio" name="name'+(key+1)+'" value="ABSENT" checked="checked" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
 									}
                                 else{
                                	 tablebody+='<input type="radio" name="name'+(key+1)+'" value="ABSENT" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
                                 }
 							  tablebody+='</td>';
 							    tablebody+='<td>';
                               if(value.status=='LATE'){
                                 tablebody+='<input type="radio" name="name'+(key+1)+'" value="LATE" checked="checked" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
       									}
                                   else{
                                      tablebody+='<input type="radio" name="name'+(key+1)+'" value="LATE" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
                                       }
                               tablebody+='</td>';
							   tablebody+='<td>';
                                       if(value.status=='LEAVE'){
                                    	   tablebody+='<input type="radio" name="name'+(key+1)+'" value="LEAVE" checked="checked" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
             									}
                                             else{
                                            	 tablebody+='<input type="radio" name="name'+(key+1)+'" value="LEAVE" onclick=saveAttendanceRecord(this.value,"'+formatedDate+'",'+value.id+')>';
                                             }
                               tablebody+='</td>;' 
                            	   tablebody+='</tr>';
							});
							tablebody+='<tr><td width="25%"></td>';
							tablebody+='<td width="25%"><a href=javascript:getCurrentDateData("'+formatedDate+'") class="btn">Submit</a></td>';
							tablebody+='<td colspan="3" style="border: 1 px solid black;"><div id="currentdatedata"></div></td> </tr>';
							$("#tablebody").append(tablebody);
						},
						error : function(e) {
							alert('error in data');
						}
					}); 
			    }
			});
		});
	  
	  function getSummuary(){
		  $.ajax({
				type : 'GET',
				url : 'getemployeeattendancesummary',
				success : function(data, status) {
					var obj = JSON.parse(data);
					$("#appendpop").empty();
					var summary='<div class="row-fluid"><div class="span12"><div class="block" style="margin-bottom: 0px;">';
					summary+='<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
					summary+='<h2>Staff Attendance Summary till current Date</h2><ul class="buttons"><li><a href="javascript:hideappendpop();">';
					summary+='<div class="icon"><span class="icon-remove"></span></div></a></li></ul></div><div class="data-fluid">';
					summary+='<table width="100%" cellspacing="0" cellpadding="0" class="table"><thead><tr><th>Student Name</th>';
					summary+='<th>Total</th><th>Present</th><th>Absent</th><th>Late</th><th>Leave</th></tr></thead><tbody id="tablebody">';
					$.each(obj,function(key,value){
					summary+='<tr><td>'+value.firstName+'</td><td>'+value.totalNoOfDays+'</td><td>'+value.noOfDaysPresent+'</td><td>'+value.noOfDaysAbsent+'</td><td>'+value.noOfDaysLatet+'</td><td>'+value.noOfDaysLeave+'</td></tr>';
					}); 
				//summary+='<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>';		
					summary+='</tbody></table></div></div></div></div> ';
					$("#appendpop").append(summary);
					$("#appendpop").show();
				},
				error : function(e) {
					alert('error in data');
				}
			}); 
	  }
	  function hideappendpop(){
		  $("#appendpop").empty();
		  $("#appendpop").hide();
	  }
	  
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/empatt.jpg"
			style="width: 57px;">
		<h1>Employee Attendance</h1>
		<h3>Employee Attendance Register</h3>
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
	<c:if test="${! empty msg && msg!='0'}">
		<div class="alert alert-success"
			style="height: 30px; padding-top: 0px; padding-bottom: 0px;">
			<h5 align="center">
				<font color="red"><b>${msg}</b></font>
			</h5>
		</div>
	</c:if>
	<br> <br>

	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>
						Attendance For Date &nbsp;&nbsp;
						<fmt:formatDate pattern="dd-MMM-yyyy" value="${now}" />
						&nbsp;&nbsp;
						<c:if test="${MAP.HOLIDAY!=''}">
							<font style="background-color: brown">${MAP.HOLIDAY}</font>
						</c:if>

					</h2>
					<ul class="buttons">
						<li><a id="admissionDate" href="javascript:void(0);"
							class="btn">Calenders</a></li>
						<li><a href="javascript:getSummuary();" class="btn">Summary</a></li>
					</ul>
				</div>
				<input type="hidden" id="EmployeesDTOsLength"
					value="${fn:length(EmployeesDTOs)}" />
				<div class="data-fluid">
					<table width="100%" cellspacing="0" cellpadding="0" class="table">
						<thead>
							<tr>
								<th width="25%">Student Name</th>
								<th width="25%">Present</th>
								<th width="25%">Absent</th>
								<th width="25%">Late</th>
								<th width="25%">Leave</th>
							</tr>
						</thead>
						<tbody id="tablebody">
							<c:forEach items="${MAP.EmployeesDTOs}" var="EmployeesDTO"
								varStatus="count">
								<tr>
									<td>${EmployeesDTO.firstName}${EmployeesDTO.lastName}</td>

									<td><c:choose>
											<c:when test="${EmployeesDTO.status=='PRESENT'}">
												<input type="radio" name="name${count.count}"
													value="PRESENT" checked="checked"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">

											</c:when>
											<c:otherwise>
												<input type="radio" name="name${count.count}"
													value="PRESENT"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">
											</c:otherwise>
										</c:choose></td>

									<td><c:choose>
											<c:when test="${EmployeesDTO.status=='ABSENT'}">
												<input type="radio" name="name${count.count}" value="ABSENT"
													checked="checked"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">

											</c:when>
											<c:otherwise>
												<input type="radio" name="name${count.count}" value="ABSENT"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">
											</c:otherwise>
										</c:choose></td>

									<td><c:choose>
											<c:when test="${EmployeesDTO.status=='LATE'}">
												<input type="radio" name="name${count.count}" value="LATE"
													checked="checked"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">

											</c:when>
											<c:otherwise>
												<input type="radio" name="name${count.count}" value="LATE"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">
											</c:otherwise>
										</c:choose></td>

									<td><c:choose>
											<c:when test="${EmployeesDTO.status=='LEAVE'}">
												<input type="radio" name="name${count.count}" value="LEAVE"
													checked="checked"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">

											</c:when>
											<c:otherwise>
												<input type="radio" name="name${count.count}" value="LEAVE"
													onclick="saveAttendanceRecord(this.value,'<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>',${EmployeesDTO.id})">
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
							<tr>
								<td width="25%"></td>
								<td width="25%"><a
									href="javascript:getCurrentDateData('<fmt:formatDate pattern="yyyy-MM-dd" value="${now}"/>')"
									class="btn">Submit</a></td>
								<td colspan="3" style="border: 1 px solid black;"><div
										id="currentdatedata"></div></td>

							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span6">
			<div class="block">
				<div class="data-fluid"></div>
			</div>
		</div>
		<div class="span6">
			<div class="block" id="submitData"></div>
		</div>
	</div>

	<div class="appendpop" id="appendpop"></div>


</div>