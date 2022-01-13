package com.onetouch.web.fct.fix.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class FixVO {

	String fixCd;
	String fctCd;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm ", timezone = "Asia/Seoul")
	Date reqDt;		//입고일	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date strDt;		//입고일	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date finDt;		//입고일
	String fixPhs;				//수리상태 "수리요청", "수리중", "수리완료"
	String fixCmt;
	int  cnt;
	int unitCost;
	int totCost;
}
