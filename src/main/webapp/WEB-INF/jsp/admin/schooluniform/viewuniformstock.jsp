<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<style>
.stockbox {
	display: none;
	background-color:lightyellow;
	border: 1px solid grey;
	width: 550px;
	
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
	
}

.stockbox-header {
	width: 550px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}
</style>


<script>
function getstockbyname(name)
{
	
	$.ajax({
		type : "post",
		url : 'getStockbyName',
		data : {
			'name' : name,
		},
		success : function(data, status) {
			$("#stockbyCategory").empty();
			var j = JSON.parse(data);
			var st = "";
			$("#myModalLabel").text(name);
			
			var length = j.length;
			if (length == 0) {
				st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
			} else {
                   st = st
						+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
						+ '</div><div class="block" style="margin-left: 21px; margin-right: 15px; margin-top: 39px;"><div class="head green"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Category Wise Stock</h4></div>'
						+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Category</th><th>Quantity Bought</th><th>Stock Left</th><th>Operation</th></tr></thead><tbody>';
				for ( var i = 0; i < length; i++) {
					st += '<tr><td>' + (i + 1)
							+ '</td><td><a href=javascript:stockbysize("'+name+'","'+ j[i].uniformCategory+'");>' + j[i].uniformCategory
							+ '</a></td><td>' + j[i].boughtQuantity
							+ '</td><td>' + j[i].remainingQuantity
							+ '</td><td><a  href=javascript:stockbysize("'+name+'","'+ j[i].uniformCategory+'");><span class="label label-primary">View More</span></a></td></tr>';
				}
				st += '</table></div></div></div>';
			}
			$("#stockbyCategory").append(st);
			$(".stockbox").show();
		},
		error : function(e) {

		}
	});
	}
	
function hidestockbox() {
	$(".stockbox").hide();
	$("#stockbyCategory").empty();
	$("#stockbySize").empty();
}
function stockbysize(name,category)
{
	var cl=name+category;
	$("#"+cl).remove();
	$.ajax({
		type : "post",
		url : 'getStockbySize',
		data : {
			'name' : name,
			'category' :category,
		},
		success : function(data, status) {
		
			var j = JSON.parse(data);
			var st = "";
	      var length = j.length;
			if (length == 0) {
				st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
			} else {
                   st = st
						+ '<div id="'+cl+'"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
						+ '</div><div class="block" style="margin-left: 21px; margin-right: 15px; margin-top: 39px;"><div class="head blue"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Size Wise Stock</h4></div>'
						+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Sizes</th><th>Quantity Bought</th><th>Stock Left</th></tr></thead><tbody>';
				for ( var i = 0; i < length; i++) {
					st += '<tr><td>' + (i + 1)
							+ '</td><td>'+ j[i].uniformSize
							+ '</td><td>' + j[i].boughtQuantity
							+ '</td><td>' + j[i].remainingQuantity
							+ '</td></tr>';
				}
				st += '</table></div></div></div>';
			}
			$("#stockbySize").append(st);
		
		},
		error : function(e) {

		}
	});
	}
</script>
<div class="stockbox">
	<div class="stockbox-header">
		<a href="javascript:hidestockbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true"><span class="ico-remove-sign"></span></a>
		<h3 id="myModalLabel">Stock Details by Category</h3>
	</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="stockbyCategory"></div>
				<div id="stockbySize"></div>
			</div>

		</div>

		<div class="editbox-footer"
			style="float: right;">
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidestockbox();"style="margin-right: 16px;"
				aria-hidden="true">Close</a>
		</div>

</div>

<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px;">
		<h1>Uniform Stock Details</h1>
		<h3>View Overall Stock Details</h3>
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
	<div class="span12" style="margin-left: 0px; width: 1059px;"></div>

	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2> Uniform Stock</h2>
				<ul class="buttons">
					<li><a return false; href="#"><div class="icon">
								<span class="ico-info"></span>
							</div></a></li>
				</ul>
			</div>
			<div class="data-fluid">
				<table class="table fTable lcnp" style="width: 1059px;">
					<thead>
						<tr>
							<th>S No</th>
							<th>Uniform Name</th>
							<th>Total Quantity Bought</th>
							<th>Total Stock Left</th>
							<th>Operations</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${stock}"
							varStatus="loop">
							<tr>
								<td class="center"><font size="2">${loop.count}</font></td>
								<td class="center"><font size="2"><a href="javascript:getstockbyname('${list.uniformName}');">${list.uniformName}</a></font></td>
								<td class="center"><font size="2">${list.boughtQuantity}</font></td>
								<td class="center"><font size="2">${list.remainingQuantity}</font></td>
								<td><a href="javascript:getstockbyname('${list.uniformName}');"><span class="label label-primary">View More</span></a></td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>