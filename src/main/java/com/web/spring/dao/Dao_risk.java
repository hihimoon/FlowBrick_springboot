package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.Emp;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.ProjectSch;
import com.web.spring.vo.ProjectTeam;
import com.web.spring.vo.Risk;
import com.web.spring.vo.RiskFile;
import com.web.spring.vo.RiskSch;
import com.web.spring.vo.TeamEmp;
import com.web.spring.vo.TeamMate;

@Mapper
public interface Dao_risk {
	// 총 리스크 건수
	public int cntRisk(RiskSch sch);
	// 리스크 리스트
	public List<Risk> riskList(RiskSch sch);
	
	// 리스크 상세
	public Risk getRiskDetail(int riskNo);
	
	// 리스크 파일 불러오기
	public List<String> getRiskFile(int riskNo);
	
	// 리스크 등록
	public int insertRisk(Risk ins);
	public int insertRiskFile(RiskFile ins);
	
	// 사원 리스트
	@Select("SELECT DISTINCT e.empno, e.ename, e.job, d.dname \r\n"
			+ "FROM fb_emp e, fb_dept d\r\n"
			+ "WHERE e.deptno = d.deptno\r\n"
			+ "ORDER BY empno")
	public List<TeamEmp> empList();
	
	// 프로젝트 리스트
	@Select("SELECT DISTINCT pb.*\r\n"
			+ "FROM PROJECTBASIC pb, PROJECTTEAM pt, TEAMMATE tm\r\n"
			+ "WHERE 1=1\r\n"
			+ "AND pb.PRJNO = pt.PRJNO\r\n"
			+ "AND pt.TEAMNO = tm.TEAMNO\r\n"
			+ "AND tm.EMPNO = #{empno}")
	public List<ProjectBasic> getProjectByEmp(int empno);
	@Select("SELECT * FROM PROJECTBASIC WHERE prjno = #{prjNo}")
	public List<ProjectBasic> getProjectByPrjNo(long prjNo);
	@Select("SELECT * FROM FB_EMP WHERE empno = #{empNo}")
	public List<Emp> getEmpByEmpNo(int empno);
	
	public int updateRisk(Risk upt);
	public int updateRiskFile(RiskFile upt);
	
	public int deleteRisk(int riskNo);
	public int deleteRiskFile(int riskNo);
	public int deleteFile(int fileNo);
	
}



