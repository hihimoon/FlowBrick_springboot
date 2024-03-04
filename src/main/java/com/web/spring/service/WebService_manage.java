package com.web.spring.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.dao.Dao_manage;
import com.web.spring.dao.Dao_notice;
import com.web.spring.dao.Dao_risk;
import com.web.spring.vo.Emp;
import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeFile;
import com.web.spring.vo.NoticeSch;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.Risk;
import com.web.spring.vo.RiskFile;
import com.web.spring.vo.RiskSch;

import jakarta.servlet.http.HttpSession;

@Service
public class WebService_manage {
	@Autowired(required = false)
	private Dao_manage dao;
	
	// 리스크 리스트 불러오기
	public List<Risk> riskList(RiskSch sch) {
		if(sch.getPrjName()==null) sch.setPrjName("");
		if(sch.getEname()==null) sch.setEname("");
		if(sch.getRiskName()==null) sch.setRiskName("");
		
		sch.setCount(dao.cntRisk(sch));
		
		if(sch.getPageSize()==0) sch.setPageSize(5);
		int totPage= (int)Math.ceil(sch.getCount()/(double)sch.getPageSize());
		sch.setPageCount(totPage);
		
		if(sch.getCurPage()>sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		if(sch.getCurPage()==0) sch.setCurPage(1);
		
		sch.setEndNo(sch.getCurPage()*sch.getPageSize());
		if(sch.getEndNo()>sch.getCount()) {
			sch.setEndNo(sch.getCount());
		}
		sch.setStartNo((sch.getCurPage()-1)*sch.getPageSize()+1);
		
		sch.setBlockSize(5);
		int blockNum = (int)Math.ceil(sch.getCurPage()/
				(double)sch.getBlockSize());
		sch.setEndBlock(blockNum*sch.getBlockSize());
		if(sch.getEndBlock()>sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
		return dao.riskList(sch);
	}
	
	public int allowRisk(int riskNo) {
		
		return dao.allowRisk(riskNo);
	}
	public int denyRisk(int riskNo) {
		
		return dao.denyRisk(riskNo);
	}
	
}
