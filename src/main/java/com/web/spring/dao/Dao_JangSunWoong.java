package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.spring.vo.DataBetweenMrAndRep;
import com.web.spring.vo.DataBetweenRepAndMr;
import com.web.spring.vo.Gantt_Links;
import com.web.spring.vo.Gantt_Task;
import com.web.spring.vo.HumanResource;
import com.web.spring.vo.HumanResourceSch;
import com.web.spring.vo.MaterialResource;
import com.web.spring.vo.MaterialResourceSch;
import com.web.spring.vo.ProjectBasic;
import com.web.spring.vo.Repository;


@Mapper
public interface Dao_JangSunWoong{
	

	
	//프로젝트기본 리스트
	@Select("SELECT * FROM PROJECTBASIC WHERE prjNo = #{prjNo}")
	ProjectBasic getProjectBasic(long prjNo);
	//프로젝트기본 변경
	int uptPrjBasic(ProjectBasic upt);
	//프로젝트기본 삭제
	int delPrjBasic(long prjNo);
	//프로젝트기본 삭제 부수효과1
	int delRiskByPrjBasic(long prjNo);
	//프로젝트기본 삭제 부수효과2
	int delMATERIALRESOURCEByPrjBasic(long prjNo);
	//프로젝트기본 삭제 부수효과3
	int delHUMANRESOURCEByPrjBasic(long prjNo);
	//프로젝트기본 삭제 부수효과4
	int delPROJECTTEAMByPrjBasic(long prjNo);
	
	
	
	//프로젝트이름 추출
	String getPrjName(long prjNo);
	//자원테이블의 프로젝트이름 변경하기
	int changePrjName(long prjNo);
	

	
	
	

	
	
	
	
	
	
	// 총데이터건수(페이징 처리가 안된 검색으로 전체 건수)
	int totMR(MaterialResourceSch mrsch);
	
	// 페이징처리가 되어 각 페이지마다 데이터 가져온 sql
	List<MaterialResource> getMRList(MaterialResourceSch mrsch);
	
	

	
	
	
	
	
	
	
	
	//물적자원 총액
	int totalPriceMr(MaterialResourceSch mrsch);	
	//물적자원 추가
	int insertMR(MaterialResource mrIns);
	//물적자원 삭제
	int delMaterialResource(int materialresourceno);
	//물적자원 상세
	MaterialResource getDetailMR(int materialresourceno);
	//물적자원 변경
	int uptMR(MaterialResource uptMR);
	
	
	

	// 총데이터건수(페이징 처리가 안된 검색으로 전체 건수)
	int totHR(HumanResourceSch hrsch);
	
	// 페이징처리가 되어 각 페이지마다 데이터 가져온 sql
	List<HumanResource> getHRList(HumanResourceSch hrsch);

	
	
	
	//인적자원 총액
	int totalPriceHr(HumanResourceSch hrsch);
	//인적자원 추가
	int insertHR(HumanResource hrIns);	
	//인적자원 추가시 중복체크
	int telDupCk(String teldup);
	//인적자원 삭제
	int delHumanResource(String tel);
	//인적자원 상세
	HumanResource getDetailHR(String tel);
	//인적자원 변경
	int uptHR(HumanResource uptHR);

	
	
	//비품창고 리스트 출력
	List<Repository> getRepositoryList(Repository sch);
	
	//물적자원 갯수 출력
	int getMRCnt(int materialresourceno);
	
	
	//물적자원->비품창고 1단계
	int transferToRepositoryStep1(DataBetweenRepAndMr dbram);

	//물적자원->비품창고 2단계
	int transferToRepositoryStep2(DataBetweenRepAndMr dbram);
	

	
	
	
	
	//비품창고->물적자원 1단계
	int transferToMaterialResourceStep1(DataBetweenMrAndRep dbmar);
	
	//비품창고->물적자원 2단계
	int transferToMaterialResourceStep2(DataBetweenMrAndRep dbmar);
	
	//비품창고 repcnt추출
	int getRepCnt(int repno);
	

	
	
	
	//물적자원 갯수 0개일때 해당 항목 삭제
	int deleteZeroCntMR();
			
	//비품창고 갯수 0개일때 해당 항목 삭제
	int deleteZeroCntRepository();
	

	
	//DB에서 gantt_task 테이블에 존재하는 모든 항목을 출력한다
	List<ProjectBasic> getGanttTask();
	//DB에서 gantt_links 테이블에 존재하는 모든 항목을 출력한다
	List<Gantt_Links> getGanttLinks();
	
	
	
	//gantt chart에서 프로젝트 삭제시 DB에 적용한다.
	//(자식프로젝트 삭제 기능 추가해서 2단계로 나뉜다.)
	//프로젝트 삭제시 입력한 id를 parent값으로 갖는 하위 프로젝트들을 모두 검색하고
	//하위프로젝트의 id를 리턴한다. (1단계)
	//단, relativeProject는 하위프로젝트를 검색하는 로직이다.
	//즉, mapper에서 찾는 DB 테이블이 Projectbasic이 아니라 Task여야한다.
	//(또한 Task테이블의 컬럼명이 다르므로 주의하자.)
	//삭제할 데이터가 project이든 task이든 task테이블에서  찾기 떄문에 RelativeTask이다.
	//반면 deleteRelative는 Project와 Task 두가지 버전 존재한다.
	//왜냐하면 project삭제시 projectbasic테이블에서 최종삭제하고, task삭제시 task테이블에서 최종삭제 하기 떄문이다.
	List<Long> selectRelativeTask(long id);
	
	
	//프로젝트 삭제시 입력한 id를 parent값으로 갖는 하위 프로젝트들을 모두 검색하고
	//삭제한것이 프로젝트일 떄 (parent=0일떄)사용한다. (2단계)
	int deleteRelativeProject(long id);
	
	//프로젝트 삭제시 입력한 id를 parent값으로 갖는 하위 프로젝트들을 모두 검색하고
	//삭제한것이 태스크일 떄 (parent!=0일떄)사용한다. (2단계)
	int deleteRelativeTask(long id);
	
	
	
	//gantt chart에서 프로젝트 추가시 DB에 추가한다.
	int insertProjectFromGantt(Gantt_Task insGT);
	
	
	//gantt chart에서 태스크 추가시 DB에 추가한다.
	int insertTaskFromGantt(Gantt_Task insGT);
	
	
	
	
	
	
	//gantt chart에서 프로젝트 수정시 DB에 적용한다.
	/*
		경우의수1. 최상위 프로젝트 수정
		경우의수2. 중간 테스크 수정
		경우의수3. 최하위 테스크 수정
		
		테이블이 projectbasic이냐 아니면 task냐에 따라서 별도 처리필요하다.
		들어온 task속성중 parent가 0이면 projectbasic 테이블에서 변경하고,
		parent가 0이 아니면 task테이블에서 변경하면 된다.
	*/
	int updateProjectFromGantt(Gantt_Task uptGT);
	
	//gantt chart에서 테스크 수정시 DB에 적용한다.
	int updateTaskFromGantt(Gantt_Task uptGT);
	
	
	
	//gantt chart에서 링크 추가시 DB에 추가한다.
	int insertLinkFromGantt(Gantt_Links insGL);
	
	
	
	//gantt chart에서 링크 삭제시 DB에 적용한다.
	int deleteLinkFromGantt(long delID);
	
	
	//project 삭제시 해당 프로젝트에 연결된 link가 삭제된다.
	int deleteLinkByProjectDelete(long prjID);

	

	
}