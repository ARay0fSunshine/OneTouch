package com.onetouch.web.adm.mng.dao;

import java.util.List;

public interface MngMapper {
	List<MngVO> selectAll();
	List<MngVO> selectPrc();
	void delete(List<MngVO> list);
}
