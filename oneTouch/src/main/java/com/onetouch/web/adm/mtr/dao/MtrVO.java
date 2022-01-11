package com.onetouch.web.adm.mtr.dao;

import lombok.Data;

@Data
public class MtrVO {

	private String mtrCd;		//자재코드
	private String mtrNm;		//자재명
	private String std;			//규격
	private String unit;		//단위
	private String compNm;		//업체명
	private String safe_stck;	//안전재고
	private String mtrSect;		//자재구분
	private String useYn;		//사용여부
	private String mngAmt;		//관리수량
}
