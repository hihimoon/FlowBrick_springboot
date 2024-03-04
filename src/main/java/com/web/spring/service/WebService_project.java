package com.web.spring.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.dao.Dao_project;
import com.web.spring.vo.Emp;
import com.web.spring.vo.InsertProjectRequest;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.ProjectSch;
import com.web.spring.vo.ProjectTeam;
import com.web.spring.vo.TeamEmp;
import com.web.spring.vo.TeamMate;


@Service
public class WebService_project {
	
	@Autowired(required = false)
	private Dao_project dao;
	
	public List<ProjectBasic> projectList(ProjectSch sch) {
		if(sch.getPrjName()==null) sch.setPrjName("");
		
		// 페이징 처리
		sch.setCount(dao.cntProject(sch));
		if(sch.getPageSize()==0) sch.setPageSize(10);
		int totPage = (int)Math.ceil(sch.getCount()/(double)sch.getPageSize());
		sch.setPageCount(totPage);
		if(sch.getCurPage()>sch.getPageCount()) {
			sch.setCurPage(sch.getPageCount());
		}
		if(sch.getCurPage()==0) sch.setCurPage(1);
		sch.setEndNo(sch.getCurPage()*sch.getPageSize());
		if(sch.getEndNo()>sch.getCount()) {
			sch.setEndNo(sch.getCount());
		}
		sch.setStartNo((sch.getCurPage()-1)*sch.getPageSize()+1);
		
		sch.setBlockSize(5);
		int blockNum = (int)Math.ceil(sch.getCurPage()/(double)sch.getBlockSize());
		sch.setEndBlock(blockNum*sch.getBlockSize());
		if(sch.getEndBlock()>sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
		
		return dao.projectList(sch);
	}
	
	public List<TeamEmp> empList(){
		return dao.empList();
	}
	
	// 프로젝트, 팀, 팀원 등록
    public String insertProject(ProjectBasic pb, ProjectTeam pt, List<String> empno) {
        String msg = "";

        // 프로젝트 기본 정보 등록
        int pbIns = dao.insertProjectBasic(pb);
        msg += (pbIns > 0) ? "기본정보 등록 성공\n" : "등록 실패\n";
        System.out.println(msg);
        // 프로젝트 팀 등록
        int ptIns = dao.insertProjectTeam(pt);
        msg += ptIns + "개의 팀 등록 완료\n";
        System.out.println(msg);
        // 팀원 등록
        int tmIns = 0;
        int countTmIns =0;
        for(String memberNums : empno) {
        	String[] nums = memberNums.replace(" ", "").split(",");
        	countTmIns = nums.length;
        	for(String num : nums) {
        		try {        			
        			int empNum = Integer.parseInt(num);
        			tmIns = dao.insertTeamMate(empNum);
        		}catch (NumberFormatException e) {
					System.out.println("에러1 : " + e.getMessage());
				}
        		catch (Exception e) {
        			System.out.println("에러2 : " + e.getMessage());
				}
        	}
        }
        msg += countTmIns + "명의 팀원 등록 완료";

        return msg;
    }
    
    

	
	public String insertProjectBasic(ProjectBasic ins) {
		String msg = dao.insertProjectBasic(ins)>0?"기본정보 등록성공":"등록 실패";
		return msg;
	}
	
	public String insertProjectTeam(ProjectTeam ins) {
		String msg = dao.insertProjectTeam(ins)>0?"팀정보 등록성공":"등록 실패";
		return msg;
	}
	
	public String insertTeamMate(int empno) {
		return dao.insertTeamMate(empno)+"명 등록 완료";
	}
	
		
}
