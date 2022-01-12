<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정관리</title>
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

</head>
<body>
<button type="button" id="btnAdd">추가</button>
<button type="button" id="btnDel">삭제</button>
<button type="button" id="btnSave">저장</button>
<div id="grid"></div>
<script type="text/javascript">
	let checked=[];
	let prcLists=[];
	
	let Grid = tui.Grid;
	Grid.applyTheme('striped',{
		cell:{
			header:{
				background:'#eef'
			},
			evenRow:{
				background:'#fee'
			}
		}
	})
		
	$.ajax({
		url: './prcList',
		dataType:'json',
		async : false
	}).done(function(datas){
		console.log(datas);
		prcLists = datas;
	});
	

	
	const columns = [{
			header : '공정코드',
			name : 'prcCd',
			editor: 'text'
		},
		{
			header : '공정명',
			name : 'prcNm',
			editor: 'text'
		},
		{
			header : '단위',
			name : 'mngUnit',
			editor: 'text'
		},
		{
			header : '생산일수',
			name : 'pdtDay',
			editor: 'text'
		},
		{
			header : '공정구분',
			name : 'dtlNm',
 				editor: {
				type: 'radio',
				options: {
					listItems: [
						
					]
				}
			} 
		},
		{
			header : '비고',
			name : 'cmt',
			editor: 'text'
		},
		{
			header : '표시순서',
			name : 'seq',
			editor: 'text'
		},
		{
			header : '사용여부',
			name : 'useYn',
			editor: {
				type: 'radio',
				options: {
			        listItems: [
			          { text: 'Y', value: 'Y' },
			          { text: 'N', value: 'N' }
			        ]
			     }
			}
		}];
	
/* 		console.log(columns[4].editor.options.listItems); */
	for(i=0; i<prcLists.length; i++) {
		let a = {}
		a.text = prcLists[i].dtlNm;
		a.value = prcLists[i].dtlNm;
		
		columns[4].editor.options.listItems.push(a);
	}
	
	
	

	//전체조회
	var dataSource = {
			api: {
				readData: {
					url:'./admMngList',
					method: 'GET'},
				modifyData: { 
					url: './admModifyData', 
					method: 'POST'}  
			},
			contentType: 'application/json'
	 };
	

			
	const grid = new Grid({
	  el: document.getElementById('grid'),
	  data: dataSource, //변수명과 필드명이 같으면 생략가능 원래: data : data,
	  rowHeaders : [ 'checkbox' ],
	  columns
	});
		
	
	
	//삭제버튼
	btnDel.addEventListener("click", function() {
		grid.removeCheckedRows(true);
	})
	
	//저장버튼
	btnSave.addEventListener("click", function() {
		grid.blur();
		grid.request('modifyData');
	})
	
	//등록버튼
	btnAdd.addEventListener("click", function() {
		grid.appendRow({})
	})	

</script>
</body>
</html>