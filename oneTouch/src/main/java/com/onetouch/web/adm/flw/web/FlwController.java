package com.onetouch.web.adm.flw.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.onetouch.web.adm.bom.dao.PrdVO;
import com.onetouch.web.adm.bom.service.BomService;
import com.onetouch.web.adm.flw.dao.FlwVO;
import com.onetouch.web.adm.flw.service.FlwService;
import com.onetouch.web.adm.mng.dao.MngVO;
import com.onetouch.web.adm.mng.service.MngService;
import com.onetouch.web.zzz.dao.ModifyVO;

@RequestMapping("/adm")
@Controller
public class FlwController {
	
	//bom서비스 호출해서 제품리스트, 제품클릭하면 제품정보뜨는거 쓰기
	@Autowired FlwService flwservice;
	@Autowired BomService bomservice;
	@Autowired MngService mngservice;
	
	//공정흐름관리 보여주는 페이지로이동
	@RequestMapping("/FlwList")
	public String flwList() {
		return "tiles/adm/admFlwList";
	}
	
	//제품규격 리스트 담아주기
	@ResponseBody
	@GetMapping("/prdSizeList")
	public List<PrdVO> prdSizeList() {
		List<PrdVO> prdSizeList = new ArrayList<>();
		prdSizeList = bomservice.selectPrdSize();
		return prdSizeList;
	}
	
	//관리단위 리스트 담아주기
	@ResponseBody
	@GetMapping("/flwUnitList")
	public List<MngVO> unitList() {
		List<MngVO> unitList = new ArrayList<>();
		unitList = mngservice.selectUnit();
		return unitList;
	}
	
	//제품구분 리스트 담아주기
	@ResponseBody
	@GetMapping("/prdSectList")
	public List<PrdVO> prdSectList() {
		List<PrdVO> prdSectList = new ArrayList<>();
		prdSectList = bomservice.selectPrdSect();
		return prdSectList;
	}
	
	//제품리스트 조회처리
	@ResponseBody
	@GetMapping("/admPrdList")
	public Map<String, Object> prdListAll() {
		Map<String, Object> map = new HashMap<>();
		map.put("contents", bomservice.selectPrdAll());
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//제품상세정보 조회처리
	@ResponseBody
	@GetMapping("/admPrdDtlList")
	public Map<String, Object> prdListDtl(PrdVO prdvo) {
		
		System.out.println("dtl"+prdvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", bomservice.selectPrd(prdvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//공정흐름 조회처리
	@ResponseBody
	@GetMapping("/admFlwList")
	public Map<String, Object> FlwList(FlwVO flwvo) {
		
		System.out.println(flwvo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("contents", flwservice.selectFlw(flwvo));
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("result", true);
		maps.put("data", map);
		
		return maps;
	}
	
	//공정흐름관리 등록수정삭제
	@ResponseBody
	@PostMapping("/flwModifyData")
	public List<FlwVO> modify(@RequestBody ModifyVO<FlwVO> mvo) {
		FlwVO flwvo = new FlwVO();
		System.out.println("modify" + mvo);
		flwservice.modify(mvo);
		if(mvo.getCreatedRows().size() > 0) {
			flwvo.setPrdCd(mvo.getCreatedRows().get(0).getPrdCd());
		}
		if(mvo.getUpdatedRows().size() > 0) {
			flwvo.setPrdCd(mvo.getUpdatedRows().get(0).getPrdCd());
		}
		if(mvo.getDeletedRows().size() > 0) {
			flwvo.setPrdCd(mvo.getDeletedRows().get(0).getPrdCd());
		}
		return flwservice.selectFlw(flwvo);
	}
	
	//form 수정
	@ResponseBody
	@PostMapping("/updatePrd")
	public List<PrdVO> updatePrd(PrdVO prdvo) {
		bomservice.updatePrd(prdvo);
		return bomservice.selectPrdAll();
	}
	
	//form 등록
	@ResponseBody
	@PostMapping("/insertPrd")
	public List<PrdVO> insertPrd(PrdVO prdvo) {
		bomservice.insertPrd(prdvo);
		return bomservice.selectPrdAll();
	}
	
	//form 삭제
	@ResponseBody
	@PostMapping("/deletePrd")
	public List<PrdVO> deletePrd(PrdVO prdvo) {
		System.out.println("삭제확인"+prdvo);
		bomservice.deletePrd(prdvo);
		return bomservice.selectPrdAll();
	}

}
