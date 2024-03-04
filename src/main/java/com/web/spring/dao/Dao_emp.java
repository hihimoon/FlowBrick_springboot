package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.DeptSch;
import com.web.spring.vo.Dept;
import com.web.spring.vo.Emp;
import com.web.spring.vo.EmpInfo;
import com.web.spring.vo.EmpSch;

// pms.dao.Dao_login
@Mapper
public interface Dao_emp {

	// 로그인
	Emp login(Emp sch);

	// 회원가입
	int signUp(Emp ins);

	// 총 사원 건수
	int totEmp(EmpSch sch);

	// 사원 리스트
	List<Emp> empList(EmpSch sch);

	// 채팅 사원 리스트
	List<Emp> chatEmpList(Emp sch);

	// 사원상세
	Emp getEmp(int empno);

	// 사원정보 수정
	int empUpdate(Emp upt);

	// 부서정보 삭제시 사원정보 수정
	int empUpdateByDeptDelete(int deptno);

	// 사원정보 삭제
	int empDelete(int empno);

	// 마이페이지 회원정보 출력
	EmpInfo getEmpInfo(int empno);

	// 마이페이지 수정처리
	int updateEmpInfo(Emp upt);

	// 비밀번호 변경
	int updatePwd(Emp emp);

	// 부서등록
	int insertDept(Dept ins);

	// 총 부서 건수
	int totDept(DeptSch sch);

	// 부서 리스트
	List<Dept> deptList(DeptSch sch);

	// 부서상세
	Dept getDept(int deptno);

	// 부서정보 수정
	int deptUpdate(Dept upt);

	// 부서정보 삭제
	int deptDelete(int deptno);

	// 부서번호 중복검사
	int checkDupDeptno(int deptno);

	// 직책 불러오기
	@Select("SELECT DISTINCT job from fb_emp order by job")
	List<String> getJobs();

	// 권한 불러오기
	@Select("SELECT DISTINCT auth from fb_emp order by auth")
	List<String> getAuths();

	// 이메일로 사원정보 가져오기 (회원가입시 메일발송 / 사원번호, 비밀번호찾기시 메일발송)
	Emp getEmpByEmail(String email);

	// 이메일로 사원번호 존재 여부 찾기
	int checkEmpno(String email);

	// 비밀번호 찾기
	int forgotPwd(Emp emp);

	// 임시비밀번호 저장
	int updateTempPw(Emp upt);

}
