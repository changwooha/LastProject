<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="/upgo3/resources/style/warehousetable.css">
<link rel="stylesheet" href="/upgo3/resources/style/tabs.css">
<link rel="stylesheet" href="/upgo3/resources/style/warehousestatetable.css">
<link rel="stylesheet" href="/upgo3/resources/style/warehousediv.css"> -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

	$(function() {		

		// tabs start
		$("#tabs").tabs();
		// finish tabs

		// datepicker start(From ~ To , restrict some date)
		var dateFormat = "mm/dd/yy", 
		//Warehouse In Datepicker
		from1 = $("#warehouseInDateS").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 2
		}).on("change", function() {			
		to1.datepicker("option", "minDate", getDate(this));
		}), 
		
		to1 = $("#warehouseInDateF").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 2
		}).on("change", function() {
			from1.datepicker("option", "maxDate", getDate(this));
		});
		//
		
		//Warehouse Out Datepicker
		from2 = $("#warehouseOutDateS").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 2
		}).on("change", function() {			
		to2.datepicker("option", "minDate", getDate(this));
		}), 
		
		to2 = $("#warehouseOutDateF").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 2
		}).on("change", function() {
			from2.datepicker("option", "maxDate", getDate(this));
		});
		//
		
		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} catch (error) {
				date = null;
			}
			return date;
		}
		// finish datepicker usage
	});
</script>
<script>
	$(function(){
		
		// Change Table Background Color by Warehouse Status
		var ware = ${wlTotalQuantityBywlNo};
		$("#warehousestatetable").find("td").each(function(e){
			var num = $(this).attr("num");
			if(ware[num-1]>39){
				$(this).css("background","red");	
			}else if(ware[num-1]>24){
				$(this).css("background","orange");
			}else{
				$(this).css("background","green");
			}
		});
		//////////////////////////////////////////////////////
		
		////////////Warehouse Status(been clicked)
		$("#warehousestatetable").on("click", "td", function() {
			var warehouseno = $(this).attr("num");
			$.ajax({
		        type:"POST",
		        url:"alwaysAnswerSuccess.action",
		        data : {"warehouseno":warehouseno} ,
		        success: function(data,status,xhr){
		        	$("#clickedWarehouseInfo").load('warehouseStatus.action',{ "warehouseno" : warehouseno});
		        },
		        error: function(xhr, status, error) {
		            alert(error);
		        }
		    });
		});
		////////////////////////////////////////////////////////////
		$("#warehouseInSearch").on("click",function() {
			var inDateS = $('#warehouseInDateS').val();
			var inDateF = $('#warehouseInDateF').val();
			$.ajax({
		        type:"POST",
		        url:"alwaysAnswerSuccess.action", 
		        success: function(data,status,xhr){
		        	$("#warehouseIn").load('warehouseInAndOut.action',{ "DateS" : inDateS, "DateF" : inDateF, "type":0}); 
		        },
		        error: function(xhr, status, error) {
		            alert(error);
		        }  
		    }); 
		});
		
		$("#warehouseOutSearch").on("click",function() {
			var outDateS = $('#warehouseOutDateS').val();
			var outDateF = $('#warehouseOutDateF').val();
			$.ajax({
		        type:"POST",
		        url:"alwaysAnswerSuccess.action", 
		        success: function(data,status,xhr){
		        	$("#warehouseOut").load('warehouseInAndOut.action',{ "DateS" : outDateS, "DateF" : outDateF, "type":1}); 
		        },
		        error: function(xhr, status, error) {
		            alert(error);
		        }  
		    }); 
		});
		
		$("#warehouseIn").on("click", "tr" ,function() {
			var clickedProduct = $(this).find(".prdCode").attr("prdCode");
			alert(clickedProduct);
			$.ajax({
		        type:"POST",
		        url:"alwaysAnswerSuccess.action", 
		        success: function(data,status,xhr){
		        	$("#clickedProductInfoIn").load('clickedProductInfoInInAndOut.action',{ "prdCode" : clickedProduct, "type": 0 }); 
		        },
		        error: function(xhr, status, error) {
		            alert(error);
		        }  
		    }); 
		});
		
		$("#warehouseOut").on("click", "tr" ,function() {
			var clickedProduct = $(this).find(".prdCode").attr("prdCode");
			alert(clickedProduct);
			$.ajax({
		        type:"POST",
		        url:"alwaysAnswerSuccess.action", 
		        success: function(data,status,xhr){
		        	$("#clickedProductInfoOut").load('clickedProductInfoInInAndOut.action',{ "prdCode" : clickedProduct, "type": 1 }); 
		        },
		        error: function(xhr, status, error) {
		            alert(error);
		        }  
		    }); 
		});
		
		
	});
</script>
<style>
#warehousetablediv, #warehousetablediv2{
	position:relative;
	display:inline;
}

#warehousestatetable, #warehousestatetable2{
    border-style: solid;
    border-width: 5px;
    font-size: 15px;
    margin: 2px;
    padding: 5px;
}

.tabletd{
    border-style: solid;
    border-width: 2px;
    font-size: 40px;
    text-align:center;
    margin: 2px;
    padding: 5px;
    width:130px;
    height:130px;    
}

#secter{
	background-image:url(/resources/jpg/sector.jpg);
	position:relative;
	display:inline;
}
</style>
<style>
@import url(https://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100);

/*** Table Styles **/
.table-fill {
  background: white;
  border-radius:3px;
  border-collapse: collapse;
  height: 320px;
  margin: auto;
  padding:5px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
  animation: float 5s infinite;
}
 
th {
  color:#D5DDE5;;
  background:#1b1e24;
  border-bottom:4px solid #9ea7af;
  border-right: 1px solid #343a45;
  font-size:15px;
  font-weight: 100;
  padding:20px;
  text-align:center;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
  vertical-align:middle;
  text-align:center;
}


th:first-child {
  border-top-left-radius:3px;
}
 
th:last-child {
  border-top-right-radius:3px;
  border-right:none;
}
  
tr {
  border-top: 1px solid #C1C3D1;
  border-bottom-: 1px solid #C1C3D1;
  color:#666B85;
  font-size:12px;
  font-weight:normal;
  text-shadow: 0 1px 1px rgba(256, 256, 256, 0.1);
}
 
tr:hover td {
  background:#4E5066;
  color:#FFFFFF;
  border-top: 1px solid #22262e;
  border-bottom: 1px solid #22262e;
}
 
tr:first-child {
  border-top:none;
}

tr:last-child {
  border-bottom:none;
}
 
tr:nth-child(odd) td {
  background:#EBEBEB;
}
 
tr:nth-child(odd):hover td {
  background:#4E5066;
}

tr:last-child td:first-child {
  border-bottom-left-radius:3px;
}
 
tr:last-child td:last-child {
  border-bottom-right-radius:3px;
}
 
td {
  background:#FFFFFF;
  padding:20px;
  text-align:left;
  vertical-align:middle;
  font-weight:300;
  font-size:12px;
  text-shadow: -1px -1px 1px rgba(0, 0, 0, 0.1);
  border-right: 1px solid #C1C3D1;
  text-align:center;
}

td:last-child {
  border-right: 0px;
}


</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/oHeader.jsp"></jsp:include>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">창고 현황</a></li>
			<li><a href="#tabs-2">입고관리</a></li>
			<li><a href="#tabs-3">출고관리</a></li>
		</ul>
		<div id="tabs-1">
			<div id="warehousetablediv" style="text-align:center;width:42%;display:inline-block;">
				<table id="warehousestatetable">
					<tr>
						<td class="tabletd" id="warehouse1" num="1">1</td>
						<td class="tabletd" id="warehouse2" num="2">2</td>
						<td class="tabletd" id="sector" rowspan="5" ><h1>S<br>E<br>C<br>T<br>O<br>R</h1></td>
						<td class="tabletd" id="warehouse11" num="11">11</td>
						<td class="tabletd" id="warehouse12" num="12">12</td>
					</tr>
					<tr>
						<td class="tabletd" id="warehouse3" num="3">3</td>
						<td class="tabletd" id="warehouse4" num="4">4</td>
						<td class="tabletd" id="warehouse13" num="13">13</td>
						<td class="tabletd" id="warehouse14" num="14">14</td>
					</tr>
					<tr>
						<td class="tabletd" id="warehouse5" num="5">5</td>
						<td class="tabletd" id="warehouse6" num="6">6</td>
						<td class="tabletd" id="warehouse15" num="15">15</td>
						<td class="tabletd" id="warehouse16" num="16">16</td>
					</tr>
					<tr>
						<td class="tabletd" id="warehouse7" num="7">7</td>
						<td class="tabletd" id="warehouse8" num="8">8</td>
						<td class="tabletd" id="warehouse17" num="17">17</td>
						<td class="tabletd" id="warehouse18" num="18">18</td>
					</tr>
					<tr>
						<td class="tabletd" id="warehouse9" num="9">9</td>
						<td class="tabletd" id="warehouse10" num="10">10</td>
						<td class="tabletd" id="warehouse19" num="19">19</td>
						<td class="tabletd" id="warehouse20" num="20">20</td>
					</tr>
				</table>
			</div>
			<div style="text-align:center;display:inline-block;vertical-align:top;">
				<table id="clickedWarehouseInfo">
					<thead>
						<tr>
							<th>제품코드</th>
							<th>이름</th>
							<th>위치 수량 / 총 수량</th>
							<th>가격</th>
							<th>색상</th>
							<th>규격</th>
							<th>안전재고</th>
							<th>설치시간</th>
							<th>발주</th>
						</tr>
					</thead>
					<tbody>
						<c:if test = "${products ne null }">
						<c:forEach var="i" begin="0" end="${size - 1}" step="1">
						<tr>
							<td>${products[i].prdCode}</td>
							<td>${products[i].prdName}</td>
							<td>${warehouselocations[i].wlQuantity} / ${products[i].prdQuantity}</td>
							<td>${products[i].prdPrice}</td>
							<td>${products[i].prdColor}</td>
							<td>${products[i].prdSize}</td>
							<td>${products[i].prdSafeStock}</td>
							<td>${products[i].prdInstallTime}</td>
							<td><input type="button" class="productorder" value="발주"></td>
						</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<div id="tabs-2" style="text-align:center;">
			<p>
				Date: <input type="text" class="datepicker" id="warehouseInDateS"> ~
				Date: <input type="text" class="datepicker" id="warehouseInDateF">
				<input type="button" value="search" id="warehouseInSearch">
			</p>
			<div style="text-align:center;width:35%;display:inline-block;">
				<table class="table-fill" id="warehouseIn">
					<thead>
						<tr>
							<th>입고일</th>
							<th>제품코드</th>
							<th>제품이름</th>
							<th>재고수량</th>
							<th>입고수량</th>
						</tr>
					</thead>
					<tbody class="table-hover">
						<c:if test = "${stores ne null }">
						<c:forEach var="i" begin="0" end="${storeSize - 1}" step="1">
						<tr class="storereleasedata">
							<td>${stores[i].srDate}</td>
							<td class="prdCode" prdCode="${storeProducts[i].prdCode}">${storeProducts[i].prdCode}</td>
							<td>${storeProducts[i].prdName}</td>
							<td>${storeProducts[i].prdQuantity}</td>
							<td>${storeOrderDetails[i].odtQuantity}</td>
						</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<div style="text-align:center;width:60%;display:inline-block;vertical-align:top;">
				<table id="clickedProductInfoIn">
					<c:if test = "${clickedProduct ne null }">
					<thead>
						<tr>
							<th>제품 코드</th>
							<th>제품 이름</th>
							<th>제품 가격</th>
							<th>제품 총 수량</th>
							<th>제품 카테고리</th>
							<th>제품 색상</th>
							<th>제품 사이즈</th>
							<th>제품 안전재고</th>
							<th>제품 설치시간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${clickedProduct.prdCode}</td>
							<td>${clickedProduct.prdName}</td>
							<td>${clickedProduct.prdPrice}</td>
							<td>${clickedProduct.prdQuantity}</td>
							<td>${clickedProduct.prdCategory}</td>
							<td>${clickedProduct.prdColor}</td>
							<td>${clickedProduct.prdSize}</td>
							<td>${clickedProduct.prdSafeStock}</td>
							<td>${clickedProduct.prdInstallTime}</td>
						</tr>
					</tbody>
					</c:if>
				</table>
			</div>
		</div>
		<div id="tabs-3" style="text-align:center;">
			<p>
				Date: <input type="text" class="datepicker" id="warehouseOutDateS"> ~
				Date: <input type="text" class="datepicker" id="warehouseOutDateF">
				<input type="button" value="search" id="warehouseOutSearch">
			</p>
			<div style="text-align:center;width:35%;display:inline-block;vertical-align:top;">
				<table class="table-fill" id="warehouseOut">
					<thead>
						<tr>
							<th>출고일</th>
							<th>제품코드</th>
							<th>제품이름</th>
							<th>창고위치</th>
							<th>출고수량</th>
						</tr>
					</thead>
					<tbody class="table-hover">
						<c:if test = "${releases ne null }">
						<c:forEach var="i" begin="0" end="${releaseSize - 1}" step="1">
						<tr>
							<td>${releases[i].srDate}</td>
							<td class="prdCode" prdCode="${releaseProducts[i].prdCode}">${releaseProducts[i].prdCode}</td>
							<td>${releaseProducts[i].prdName}</td>
							<td>${releaseProducts[i].prdQuantity}</td>
							<td>${releaseOrderDetails[i].odtQuantity}</td>
						</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<div style="text-align:center;width:60%;display:inline-block;vertical-align:top;">
				<table id="clickedProductInfoOut">
					<c:if test = "${clickedProduct ne null }">
					<thead>
						<tr>
							<th>제품 코드</th>
							<th>제품 이름</th>
							<th>제품 가격</th>
							<th>제품 총 수량</th>
							<th>제품 카테고리</th>
							<th>제품 색상</th>
							<th>제품 사이즈</th>
							<th>제품 안전재고</th>
							<th>제품 설치시간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${clickedProduct.prdCode}</td>
							<td>${clickedProduct.prdName}</td>
							<td>${clickedProduct.prdPrice}</td>
							<td>${clickedProduct.prdQuantity}</td>
							<td>${clickedProduct.prdCategory}</td>
							<td>${clickedProduct.prdColor}</td>
							<td>${clickedProduct.prdSize}</td>
							<td>${clickedProduct.prdSafeStock}</td>
							<td>${clickedProduct.prdInstallTime}</td>
						</tr>
					</tbody>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</body>
</html>