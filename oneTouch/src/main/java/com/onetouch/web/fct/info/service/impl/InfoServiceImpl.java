package com.onetouch.web.fct.info.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.onetouch.web.fct.info.dao.InfoMapper;
import com.onetouch.web.fct.info.dao.InfoVO;
import com.onetouch.web.fct.info.service.InfoService;
import com.onetouch.web.pdt.plan.dao.PlanMapper;
@Service
public class InfoServiceImpl implements InfoService {
	@Autowired InfoMapper mapper;
	@Autowired PlanMapper pmapper;
	
	@Override
	public List<InfoVO> selectFctInfoAll() {
		return mapper.selectFctInfoAll();
	}


	@Override
	public void deleteFctInfo(List<InfoVO> list) {
		
		mapper.deleteFctInfo(list);
	}


	@Override
	public InfoVO selectFctInfo(InfoVO infoVO) {
		return mapper.selectFctInfo(infoVO);
	}



	
}
