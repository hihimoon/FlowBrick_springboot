package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.Task;
import com.web.spring.vo.TaskSch;
import com.web.spring.vo.TeamEmp;
import com.web.spring.vo.TeamMate;

@Mapper
public interface Dao_task {
	// 총 업무 건수
	public int cntTask(TaskSch sch);
	// 업무 리스트
	public List<Task> taskList(TaskSch sch);
	// 업무 상세
	public Task taskDetail(long taskNo);
	// 업무 기본정보 등록
	public int insertTask(Task ins);
	// 업무 팀원 등록
	public int insertTaskTeamMate(TeamMate ins);
	// 사원 리스트
	@Select("SELECT DISTINCT e.empno, e.ename, e.job, d.dname \r\n"
			+ "FROM fb_emp e, fb_dept d\r\n"
			+ "WHERE e.deptno = d.deptno\r\n"
			+ "ORDER BY empno")
	public List<TeamEmp> empList();
	// 업무 삭제
	public int deleteTask(long taskNo);
	
}



