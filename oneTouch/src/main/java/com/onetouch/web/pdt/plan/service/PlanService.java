package com.onetouch.web.pdt.plan.service;

import java.util.List;

import com.onetouch.web.pdt.ord.dao.OrdVO;
import com.onetouch.web.pdt.plan.dao.PlanVO;

public interface PlanService {
	List<PlanVO> list();
	List<PlanVO> selectDtl(String no);
}
