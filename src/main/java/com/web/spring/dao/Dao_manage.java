package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.ProjectSch;
import com.web.spring.vo.ProjectTeam;
import com.web.spring.vo.Risk;
import com.web.spring.vo.RiskFile;
import com.web.spring.vo.RiskSch;
import com.web.spring.vo.TeamEmp;
import com.web.spring.vo.TeamMate;

@Mapper
public interface Dao_manage {
	// 총 리스크 건수
	@Select("SELECT COUNT(*)\r\n"
			+ "		FROM risk r, fb_emp e, projectbasic p\r\n"
			+ "		WHERE 1=1\r\n"
			+ "		AND r.riskname like '%'||#{riskName}||'%'\r\n"
			+ "		AND e.ename like '%'||#{ename}||'%'\r\n"
			+ "		AND r.empno = e.empno\r\n"
			+ "		AND p.prjName like '%'||#{prjName}||'%'\r\n"
			+ "		AND r.prjNo = p.prjNo"
			+ "		AND r.state = '승인대기'")
	public int cntRisk(RiskSch sch);
	@Select("SELECT * \r\n"
			+ "	FROM (SELECT rownum cnt, rsk.*\r\n"
			+ "		  FROM (\r\n"
			+ "				SELECT p.prjname, e.ename, r.*\r\n"
			+ "				FROM risk r, fb_emp e, projectbasic p\r\n"
			+ "				WHERE 1=1\r\n"
			+ "				AND r.riskname like '%'||#{riskName}||'%'\r\n"
			+ "				AND e.ename like '%'||#{ename}||'%'\r\n"
			+ "				AND r.empno = e.empno\r\n"
			+ "				AND p.prjName like '%'||#{prjName}||'%'\r\n"
			+ "				AND r.prjNo = p.prjNo\r\n"
			+ "				AND r.state = '승인대기'"
			+ "				order by r.riskno DESC) rsk \r\n"
			+ "	)\r\n"
			+ "	where cnt BETWEEN #{startNo} AND #{endNo}")
	// 리스크 리스트
	public List<Risk> riskList(RiskSch sch);
	
	@Update("UPDATE RISK set state = '진행중' WHERE riskNo = #{riskNo}")
	public int allowRisk(int riskNo);
	@Update("UPDATE RISK set state = '반려' WHERE riskNo = #{riskNo}")
	public int denyRisk(int riskNo);
	
}



