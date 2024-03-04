package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.Calendar;
import com.web.spring.vo.ProjectBasic;


@Mapper
public interface Dao_calendar {

	// 캘린더 화면
	List<Calendar> getCalList(int empno);
	
	// 캘린더 등록
	int insertCalendar(Calendar ins);
	
	// 캘린더 업데이트
	int updateCalendar(Calendar upt);
	
	// 캘린더 삭제
	int deleteCalendar(@Param("calId") int calId);
}



