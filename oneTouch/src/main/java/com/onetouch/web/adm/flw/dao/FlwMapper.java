package com.onetouch.web.adm.flw.dao;

import java.util.List;

import com.onetouch.web.adm.bom.dao.PrdVO;

public interface FlwMapper {
	List<FlwVO> selectFlw(FlwVO flwvo);
	void deleteFlw(FlwVO flwvo);
	void updateFlw(FlwVO flwvo);
	void updatePrd(PrdVO prdvo);
}
