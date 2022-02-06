<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="${path}/resources/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="${path}/resources/jquery-ui/images">
<link rel="stylesheet" href="${path}/resources/jquery-ui/MonthPicker.css">


<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script src="${path}/resources/js/grid-common.js"></script>
<script src="${path}/resources/jquery-ui/jquery.ui.monthpicker.js"></script>

</head>
<body>
<br>
<h3>통계</h3>
<hr>
<div id="tabs">
	<ul>
	  <li><a href="#mtrInTab">자재입고량</a></li>
	  <li><a href="#mtrOutTab">자재출고량</a></li>
	  <li><a href="#pdtCntTab">제품생산량</a></li>
	  <li><a href="#fltCntTab">제품불량량</a></li>
	</ul>
	<br>
	&nbsp;
	<select id=selectSts>
		<option>일별</option>
		<option>월별</option>
		<option>연도별</option>
		<option id="optionD">자재별,일별</option>
		<option id="optionM">자재별,월별</option>
		<option id="optionY">자재별,연도별</option>
	</select>
	<br><br>
	<form id="stsDateFrm">
		<div id="dateOnly">&nbsp;
			<label>해당일자</label>
			<input type="text" id="startDate" name="startDate" class="datepicker jquerydtpicker">&nbsp;
			<label> ~ </label>&nbsp;
			<input type="text" id="endDate" name="endDate" class="datepicker jquerydtpicker">&nbsp;
			<button type="button" id="btnFind" class="btnFind">조회</button>
		</div>
	</form>
	<form id="stsMonthFrm">
		<div id="monthOnly">&nbsp;
			<label>해당일자</label>
			<!-- <input type="text" id="startDate2" name="startDate" class="monthpicker" class="monthpicker jquerymonpicker"/> -->
			<input type="text" id="startDate2" name="startDate" class="monthpicker" class="datepicker jquerymonpicker"/>&nbsp;
			<label> ~ </label>&nbsp;
			<input type="text" id="endDate2" name="endDate" class="monthpicker" class="datepicker jquerymonpicker"/>&nbsp;
			<button type="button" id="btnFind" class="btnFind">조회</button>
		</div>
	</form>
	<form id="stsYearFrm">
		<div id="yearOnly">&nbsp;
			<label>해당일자</label>&nbsp;
			<select id="startDate3" name="startDate">
				<option>2018</option>
				<option>2019</option>
				<option>2020</option>
				<option>2021</option>
				<option>2022</option>
			</select>
			<label> ~ </label>&nbsp;
			<select id="endDate3" name="endDate">
				<option>2018</option>
				<option>2019</option>
				<option>2020</option>
				<option>2021</option>
				<option>2022</option>
			</select>
			<button type="button" id="btnFind" class="btnFind">조회</button>
		</div>
	<br>
	</form>
	<div id="mtrInTab"></div>
	<div id="mtrOutTab"></div>
	<div id="pdtCntTab"></div>
	<div id="fltCntTab"></div>
</div>
<script type="text/javascript">
let flag = 1;

$("#monthOnly").hide();
$("#yearOnly").hide();

$(function() {
    //input을 datepicker로 선언
    $(".datepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png" //"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
        //,buttonText: "선택" //버튼 호버 텍스트              
        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
    });                    
    
    //초기값을 오늘 날짜로 설정해줘야 합니다.
    $('#startDate').datepicker('setDate', 'today-1M');
    $('#endDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    	       
    
});
    
    

$(".monthpicker").monthpicker({
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	,showOn: "both" 
	,buttonImage: "/oneTouch/resources/template/images/cal_lb_sm.png"
	,buttonImageOnly: true
	,changeYear: true
	,yearRange: 'c-2:c+2'
	,dateFormat: 'yy-mm'
	

});


//월별 초기값
$('#startDate2').monthpicker('setDate', 'today-1M');
$('#endDate2').monthpicker('setDate', 'today');
    
//연도별 초기값
document.getElementById('startDate3').value = '2020';
document.getElementById('endDate3').value = '2022';

//---------Jquery tabs---------
$( function() {
    $( "#tabs" ).tabs({
    	activate: function( event, ui ) {
    		if(ui.newTab[0].innerText == '자재입고량'){
    			flag = 1;
    			document.getElementById('optionD').innerText = "자재별,일별";
    			document.getElementById('optionM').innerText = "자재별,월별";
    			document.getElementById('optionY').innerText = "자재별,연도별";
    			mtrInGrid.refreshLayout();
    			
    		} /*else if(ui.newTab[1].innerText == '자재출고량'){
    			flag = 2;
	    		document.getElementById('optionD').innerText = "자재별,일별";
	    		document.getElementById('optionM').innerText = "자재별,월별";
	    		document.getElementById('optionY').innerText = "자재별,연도별";
    			mtrOutGrid.refreshLayout();
	    		
    		} */else if(ui.newTab[0].innerText == '제품생산량'){
    			flag = 3;
    			document.getElementById('optionD').innerText = "제품별,일별";
    			document.getElementById('optionM').innerText = "제품별,월별";
    			document.getElementById('optionY').innerText = "제품별,연도별";
    			pdtCntGrid.refreshLayout();
    			
    		} /*else {
    			flag = 4;
	    		document.getElementById('optionD').innerText = "자재별,일별";
	    		document.getElementById('optionM').innerText = "자재별,월별";
	    		document.getElementById('optionY').innerText = "자재별,연도별";
    			fltCntGrid.refreshLayout();
	    		
    		} */
    	}
    });
});
//---------Jquery tabs 끝---------

//---------mtrInGrid---------
//컬럼
let mtrInColumns = [{
		header:'입고일',
		name:'inDate',
		align: 'center'
	},
	{
		header:'자재코드',
		name:'mtrCd',
		align: 'center'
	},
	{
		header:'입고량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const mtrInDataSource = {
		api: {
			readData: { 
				url: './mtrInDate', 
				method: 'GET',
				initParams: $("#stsDateFrm").serializeObject()
			}
		},
		contentType: 'application/json'	
	};

//그리드
let mtrInGrid;
function mtrInGridDraw(mtrInColumns) {
	if(mtrInGrid != undefined) {
		mtrInGrid.destroy();		
	}
	mtrInGrid = new Grid({
		el: document.getElementById('mtrInTab'),
		columns: mtrInColumns,
		data: mtrInDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
mtrInGridDraw(mtrInColumns);
//---------mtrInGrid 끝---------

//---------pdtCntGrid---------
//컬럼
let pdtCntColumns = [{
		header:'제품생산일',
		name:'workFinDt',
		align: 'center'
	},
	{
		header:'제품코드',
		name:'prdCd',
		align: 'center'
	},
	{
		header:'입고량',
		name:'cnt',
		align: 'center'
	}];
	
//데이터소스	
const pdtCntDataSource = {
		api: {
			readData: { 
				url: './pdtDate', 
				method: 'GET',
				initParams: $("#stsDateFrm").serializeObject()
			}
		},
		contentType: 'application/json'	
	};

//그리드
let pdtCntGrid;
function pdtCntGridDraw(pdtCntColumns) {
	if(pdtCntGrid != undefined) {
		pdtCntGrid.destroy();		
	}
	pdtCntGrid = new Grid({
		el: document.getElementById('pdtCntTab'),
		columns: pdtCntColumns,
		data: pdtCntDataSource,
		bodyHeight: 400,
		scrollY : true
	})
}
pdtCntGridDraw(pdtCntColumns);
//---------pdtCntGrid 끝---------

//---------조회 버튼---------
let selectSts = document.getElementById('selectSts');
let btnFind1 = document.getElementsByClassName('btnFind')[0];
let btnFind2 = document.getElementsByClassName('btnFind')[1];
let btnFind3 = document.getElementsByClassName('btnFind')[2];
function btnFindFunc() {
	if(flag == 1) {
		if(selectSts.value == "일별") {
			mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
		} else if(selectSts.value == "월별") {
			mtrInGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
		} else if(selectSts.value == "연도별") {
			mtrInGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		} else if(selectSts.value == "자재별,일별") {
			mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
		} else if(selectSts.value == "자재별,월별") {
			mtrInGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
		} else if(selectSts.value == "자재별,연도별") {
			mtrInGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		}
	} else if(flag == 3) {
		if(selectSts.value == "일별") {
			pdtCntGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
		} else if(selectSts.value == "월별") {
			pdtCntGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
		} else if(selectSts.value == "연도별") {
			pdtCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		} else if(selectSts.value == "제품별,일별") {
			pdtCntGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
		} else if(selectSts.value == "제품별,월별") {
			pdtCntGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
		} else if(selectSts.value == "제품별,연도별") {
			pdtCntGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		}
	}
	  
}
btnFind1.addEventListener("click", function(){
	btnFindFunc();
});
btnFind2.addEventListener("click", function(){
	btnFindFunc();
});
btnFind3.addEventListener("click", function(){
	btnFindFunc();
});
//---------조회 버튼 끝---------

//---------셀렉트 바뀔때 이벤트--------
selectSts.addEventListener("change", function(){
	let dtClm = {
			header:'입고일',
			name:'inDate',
			align: 'center'
		};
	let cdClm = {
			header:'자재코드',
			name:'mtrCd',
			align: 'center'
		};
	let cntClm = {
			header:'입고량',
			name:'cnt',
			align: 'center'
		};
	let dtclm2 = {
			header:'제품생산일',
			name:'workFinDt',
			align: 'center'
		};
	let cdClm2 = {
			header:'제품코드',
			name:'prdCd',
			align: 'center'
		};
	
	//자재입고
	if(flag == 1) {
		if(selectSts.value == "일별") {
			dtClm.header = '입고일';
			mtrInColumns = [dtClm,cdClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInDate';
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
			console.log($("#stsDateFrm").serializeObject());
			//mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);
		} else if(selectSts.value == "월별") {
			dtClm.header = '입고월';
			mtrInColumns = [dtClm,cdClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMonth';
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
			//mtrInGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
		} else if(selectSts.value == "연도별") {
			dtClm.header = '입고연도';
			mtrInColumns = [dtClm,cdClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInYear';
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			mtrInGridDraw(mtrInColumns);
			//mtrInGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		} else if(selectSts.value == "자재별,일별") {
			dtClm.header = '입고일';
			mtrInColumns = [cdClm,dtClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMtrD';	
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
			//mtrInGrid.readData(1,$("#stsDateFrm").serializeObject(),true);;
		} else if(selectSts.value == "자재별,월별") {
			dtClm.header = '입고월';
			mtrInColumns = [cdClm,dtClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMtrM';
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			mtrInGridDraw(mtrInColumns);
			//mtrInGrid.readData(1,$("#stsMonthFrm").serializeObject(),true);
		} else if(selectSts.value == "자재별,연도별") {
			dtClm.header = '입고연도';
			mtrInColumns = [cdClm,dtClm,cntClm];
			mtrInDataSource.api.readData.url = './mtrInMtrY';	
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			mtrInGridDraw(mtrInColumns);
			//mtrInGrid.readData(1,$("#stsYearFrm").serializeObject(),true);
		} 
		
	//제품생산	
	} else if(flag == 3) {
		if(selectSts.value == "일별") {
			dtClm2.header = '제품생산일';
			pdtCntColumns = [dtClm2,cdClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtDate';
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
		} else if(selectSts.value == "월별") {
			dtClm2.header = '제품생산월';
			pdtCntColumns = [dtClm2,cdClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtMonth';
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
		} else if(selectSts.value == "연도별") {
			dtClm2.header = '제품생산연도';
			pdtCntColumns = [dtClm2,cdClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtYear';
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			pdtCntGridDraw(pdtCntColumns);
		} else if(selectSts.value == "자재별,일별") {
			dtClm2.header = '제품생산일';
			pdtCntColumns = [cdClm2,dtClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtPrdD';	
			$("#dateOnly").show();
			$("#monthOnly").hide();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
		} else if(selectSts.value == "자재별,월별") {
			dtClm2.header = '제품생산월';
			pdtCntColumns = [cdClm2,dtClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtPrdM';
			$("#dateOnly").hide();
			$("#monthOnly").show();
			$("#yearOnly").hide();
			pdtCntGridDraw(pdtCntColumns);
		} else if(selectSts.value == "자재별,연도별") {
			dtClm2.header = '제품생산연도';
			pdtCntColumns = [cdClm2,dtClm2,cntClm];
			pdtCntDataSource.api.readData.url = './pdtPrdY';	
			$("#dateOnly").hide();
			$("#monthOnly").hide();
			$("#yearOnly").show();
			pdtCntGridDraw(pdtCntColumns);
		} 
	}
	
})
//---------셀렉트 바뀔때 이벤트 끝--------


//---------mtrInGrid 끝---------
//---------mtrOutGrid---------
//---------mtrOutGrid 끝---------
//---------pdtCntGrid---------
//---------pdtCntGrid 끝---------
//---------fltCntGrid---------
//---------fltCntGrid 끝---------




//---------Grid 깨지는거 refresh---------
window.setTimeout(function(){mtrInGrid.refreshLayout()}, 100);
//window.setTimeout(function(){mtrOutGrid.refreshLayout()}, 300);
window.setTimeout(function(){pdtCntGrid.refreshLayout()}, 300);
//window.setTimeout(function(){fltCntGrid.refreshLayout()}, 300);
//---------Grid 깨지는거 refresh끝---------

</script>
</body>
</html>