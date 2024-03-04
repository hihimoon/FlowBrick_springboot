package com.web.spring.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.spring.dao.Dao_JangSunWoong;
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



@Service
public class WebService_JangSunWoong {

	@Autowired(required =false)
	private Dao_JangSunWoong dao;
	
	// 상세화면 클릭시
	public ProjectBasic getProjectBasic(long prjNo) {
		return dao.getProjectBasic(prjNo);
	}

	// 수정기능
	public String uptPrjBasic(ProjectBasic upt) {
		return dao.uptPrjBasic(upt)>0?"수정성공":"수정실패";
	}
	
	
	

	//프로젝트기본 삭제 부수효과1
	public int delMATERIALRESOURCEByPrjBasic(long prjNo) {
		return dao.delMATERIALRESOURCEByPrjBasic(prjNo);
	}
	//프로젝트기본 삭제 부수효과2
	public int delHUMANRESOURCEByPrjBasic(long prjNo) {
		return dao.delHUMANRESOURCEByPrjBasic(prjNo);
	}
	//삭제기능
	public String delPrjBasic(long prjNo) {
		delMATERIALRESOURCEByPrjBasic(prjNo); 
		delHUMANRESOURCEByPrjBasic(prjNo);
		return dao.delPrjBasic(prjNo)>0?"삭제성공":"삭제실패";
	}
	
	//프로젝트이름 추출
	public String getPrjName(long prjNo) {
		return dao.getPrjName(prjNo);
	}
	//자원테이블의 프로젝트명 변경
	public int changePrjName(long prjNo) {
		return dao.changePrjName(prjNo);
	}


	
	//물적자원리스트및검색
	public List<MaterialResource> getMRList(MaterialResourceSch mrsch){
		// 초기화면에 전체데이터 출력을 위해.. 공백 처리..
		if(mrsch.getMaterialresourcename()==null) mrsch.setMaterialresourcename("");

		// 페이징 처리를 위한 알고리즘 처리..
		// 1. 전체데이터 건수 설정.(DB)
		mrsch.setCount(dao.totMR(mrsch));
		// 2.  한번에 보여줄 페이지 크기 지정
		///    (화면에서 요청값을 지정하지 않으면 5건이 한페이지 단위)
		if(mrsch.getPageSize()==0) mrsch.setPageSize(5);
		// 3. 총페이지수 [1][2][3][4][5][6]
		// 	 17건 ==> 3페이지?? 4페이지? 어떻게?
		// Math.ceil(sch.getCount()/(double)sch.getPageSize())
		//           15/3 => 3
		//           17/3 => 3.666  소숫점이 있으면 올림처리..	
		// 나머지값 즉, 해당 페이지크기에 딱 떨어지지 않을 때, 한페이지 더 만들어짐
		//int totPage = (int)Math.ceil(sch.getCount()/(double)sch.getPageSize());
		mrsch.setPageCount((int)Math.ceil(mrsch.getCount()/(double)mrsch.getPageSize()));
		// 4. 클릭한 현재 페이지 번호(초기화면에는 default로 1로 설정)

		//    마지막페이지에서 next를 눌렀을 때, 더이상 curpage가 증가되지 않게
		
		if(mrsch.getCurPage()>mrsch.getPageCount()) 
			mrsch.setCurPage(mrsch.getPageCount());
		
		if(mrsch.getCurPage()==0) mrsch.setCurPage(1);		
		// 해당 페이지의 마지막번호  : 페이지당건수 * 현재페이지
		// 5. 페이지의 마지막 번호는 현재클릭한 페이지번호 * 페이지당 보일 데이터 건수 
		mrsch.setEnd(mrsch.getCurPage()*mrsch.getPageSize());
		///    sch.getEnd()
		//     총데이터건수 18건수. end데이터가 20이 되는 문제 발생.
		//     총데이터건수보다는 크지 않게 처리하여야 한다.
		//     마지막 페이지에서 발견되는 로직의 문제 처리..
		//     (sql상 문제되지 않기에)
		//     처리하지 않아도 된다.
		if(mrsch.getEnd()>mrsch.getCount()) {
			mrsch.setEnd(mrsch.getCount() );
		}
		/*
		페이지당데이터건수	현재페이지번호 	시작번호		마지막번호
		5				1			1			5
		5				2			6			10
		5				3			11			15
		?? 이렇게 처리되는 경우 시작번호를 도출해보세요...
		조별로 ==> 조장님 제출..
		sch.setStart(??);
		 * */
		// 6. 페이지의 시작 번호는 (현재클릭한 페이지번호-1) * 페이지당 보일 데이터 건수 + 1 
		mrsch.setStart((mrsch.getCurPage()-1)*mrsch.getPageSize()+1);
		/*
		# 페이지 블럭 처리
			1. 블럭사이즈 지정(홀수 고정)
		 * */
		mrsch.setBlockSize(5);
		// 	2. 클릭한 현재 페이지번호 기준으로 블럭번호 처리
		/*                               블럭번호
		 * 이전 [1][2][3][4][5] 이후       1   
		 * 이전 [6][7][8][9][10] 이후      2
		 * 이전 [11][12][13]     이후      3 
		 * 
		 현재 클릭한 페이지번호를 통해서 블럭번호를 도출하고,
		 그 블럭번호에 의해서 블럭의 범위를 화면에 출력 처리..
		 블럭번호를 가져오는 로직 조별로 협의해서 전달..
		 * */
		System.out.println("현재 페이지 번호");
		System.out.println(mrsch.getCurPage());
		System.out.println("블럭의 크기");
		System.out.println(mrsch.getBlockSize());
		int blockNum = (int)Math.ceil(mrsch.getCurPage()/
							(double)mrsch.getBlockSize());
		//   3. 마지막블럭번호
		mrsch.setEndBlock(blockNum*mrsch.getBlockSize());
		// 블럭의 마지막크기가 전체페이지 크기보다 클수 있다. 이에 대한
		// 조건 처리를 하여야 한다.(필수) 위 예제와 같이 페이지의 전체 크기는
		// 13건인데, 마지막블럭번호가 15가 처리될 수 있어서, 아래 로직으로
		// 처리하여야 한다.
		if(mrsch.getEndBlock()>mrsch.getPageCount()) {
			mrsch.setEndBlock(mrsch.getPageCount());
		}
		
		//   4. 시작블럭번호
		mrsch.setStartBlock((blockNum-1)*mrsch.getBlockSize()+1);
		System.out.println(blockNum);
		System.out.println(mrsch.getBlockSize());
		
		System.out.println("## 시작 블럭 크기 #");
		System.out.println(mrsch.getStartBlock());
		
		
		return dao.getMRList(mrsch);
	}	
	
	
	

	
	//물적자원리스트 price 합(총액)
	public int totalPriceMr(MaterialResourceSch mrsch) {
		return dao.totalPriceMr(mrsch);
	}
	
	//물적자원 추가
	public String insertMR(MaterialResource mrIns) {
		
		return dao.insertMR(mrIns)>0?"등록성공":"등록실패";
	}
	
	//물적자원 상세정보
	public MaterialResource getDetailMR(int materialresourceno) {
		return dao.getDetailMR(materialresourceno);
	}

	//물적자원 삭제
	public String delMaterialResource(int materialresourceno) {
		return dao.delMaterialResource(materialresourceno)>0?"삭제성공":"삭제실패";
	}
	
	//물적자원 수정
	public String uptMR(MaterialResource uptMR) {
		return dao.uptMR(uptMR)>0?"수정성공":"수정실패";
	}
	

	
	//인적자원리스트및검색
	public List<HumanResource> getHRList(HumanResourceSch hrsch){
		if(hrsch.getTel()==null) hrsch.setTel("");
		hrsch.setCount(dao.totHR(hrsch));
		if(hrsch.getPageSize()==0) hrsch.setPageSize(5);
		hrsch.setPageCount((int)Math.ceil(hrsch.getCount()/(double)hrsch.getPageSize()));
		if(hrsch.getCurPage()>hrsch.getPageCount()) 
			hrsch.setCurPage(hrsch.getPageCount());
		if(hrsch.getCurPage()==0) hrsch.setCurPage(1);		
		hrsch.setEnd(hrsch.getCurPage()*hrsch.getPageSize());
		if(hrsch.getEnd()>hrsch.getCount()) {
			hrsch.setEnd(hrsch.getCount() );
		}
		hrsch.setStart((hrsch.getCurPage()-1)*hrsch.getPageSize()+1);
		hrsch.setBlockSize(5);
		int blockNum = (int)Math.ceil(hrsch.getCurPage()/(double)hrsch.getBlockSize());
		hrsch.setEndBlock(blockNum*hrsch.getBlockSize());
		if(hrsch.getEndBlock()>hrsch.getPageCount()) {
			hrsch.setEndBlock(hrsch.getPageCount());
		}
		hrsch.setStartBlock((blockNum-1)*hrsch.getBlockSize()+1);
		return dao.getHRList(hrsch);
	}	
	

	
	//인적자원리스트 price 합(총액)
	public int totalPriceHr(HumanResourceSch hrsch) {
		return dao.totalPriceHr(hrsch);
	}
	
	//인적자원 추가
	public String insertHR(HumanResource hrIns) {
		return dao.insertHR(hrIns)>0?"등록성공":"등록실패";
	}
	//인적자원 추가시 중복체크
	public int telDupCk(String teldup) {
		return dao.telDupCk(teldup);
	}
	//인적자원 상세정보
	public HumanResource getDetailHR(String tel) {
		return dao.getDetailHR(tel);
	}

	//인적자원 삭제
	public String delHumanResource(String tel) {
		return dao.delHumanResource(tel)>0?"삭제성공":"삭제실패";
	}
	
	//인적자원 수정
	public String uptHR(HumanResource uptHR) {
		return dao.uptHR(uptHR)>0?"수정성공":"수정실패";
	}
	
	
	
	
	
	
	
	//비품창고와 물적자원 리스트 출력
	public List<Repository> getRepositoryList(Repository sch){
		if(sch.getMaterialresourcename()==null) {sch.setMaterialresourcename("");};
		return dao.getRepositoryList(sch);
	}
	
	public int getMRCnt(int materialresourceno) {
		return dao.getMRCnt(materialresourceno);
	}
	
	public int transferToRepositoryStep1(DataBetweenRepAndMr dbram) {
		return dao.transferToRepositoryStep1(dbram);
	}
	
	public int transferToRepositoryStep2(DataBetweenRepAndMr dbram) {
		return dao.transferToRepositoryStep2(dbram);
	}

	
	
	

	public int transferToMaterialResourceStep1(DataBetweenMrAndRep dbmar) {
		return dao.transferToMaterialResourceStep1(dbmar);
	}
	
	public int transferToMaterialResourceStep2(DataBetweenMrAndRep dbmar) {
		return dao.transferToMaterialResourceStep2(dbmar);
	}
	
	public int getRepCnt(int repno){
		return dao.getRepCnt(repno);
	}
	


	public int deleteZeroCntMR() {
		return dao.deleteZeroCntMR();
	}
			
	public int deleteZeroCntRepository() {
		return dao.deleteZeroCntRepository();
	}
	
	
	
	
	public List<ProjectBasic> getGanttTask(){
		return dao.getGanttTask();
	}
	
	public List<Gantt_Links> getGanttLinks(){
		return dao.getGanttLinks();
	}
	
	
	
	
	
	// 간트차트에서 프로젝트 삭제 구성메서드 1단계(이거 자체로 사용하는것이 아니고, deleteProjectFromGantt메서드에서 사용할것이다.)
	public List<Long> selectRelativeTask(long id){
		return dao.selectRelativeTask(id);
	}
	// 간트차트에서 프로젝트 삭제 구성메서드 2단계(이거 자체로 사용하는것이 아니고, deleteProjectFromGantt메서드에서 사용할것이다.)
	public int deleteRelativeProject(long id) {
		return dao.deleteRelativeProject(id);
	}
	
	// 간트차트에서 프로젝트 삭제 구성메서드 2단계(이거 자체로 사용하는것이 아니고, deleteProjectFromGantt메서드에서 사용할것이다.)
	public int deleteRelativeTask(long id) {
		return dao.deleteRelativeTask(id);
	}

	
	// 간트차트에서 프로젝트 삭제
	/*
	경우의수1 : 최상위 프로젝트를 삭제할 경우 최상위프로젝트는 parent=0 이다. 이건 시작을 projectbasic테이블로 접근해야한다.
	경우의수2 : 상위프로젝트와 하위프로젝트가 존재하는 중간프로젝트를 삭제할 경우 이건 시작부터 task테이블로 접근해야한다.
	경우의수3 : 최하위 프로젝트를 삭제할 경우
	
	경우의수2와 3은 동일하다고 생각한다.
	경우의수1은 이 메서드에 추가로 projectbasic테이블에서 prjno==id인 항목을 삭제하면 된다.
	 */
	public String deleteProjectFromGantt(long id) {
		// 1단계
		if(selectRelativeTask(id).size()>0) {
			for(long childID:selectRelativeTask(id)) {
				if(childID!=0) {
					deleteProjectFromGantt(childID);
				}
			}
		}
		// 2단계
		deleteRelativeTask(id);
		// 프로젝트에 관련된 링크 삭제
		// (링크 직접 삭제 하는 기능이 아니고 프로젝트 삭제시 부수효과로 연결된 링크가 삭제되는 개념)
		deleteLinkByProjectDelete(id);
		// 리턴
		return "Success to delete all the relative projects and links";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int insertProjectFromGantt(Gantt_Task insGT) {
		return dao.insertProjectFromGantt(insGT);
	}
	
	//gantt chart에서 태스크 추가시 DB에 추가한다.
	public int insertTaskFromGantt(Gantt_Task insGT) {
		return dao.insertTaskFromGantt(insGT);
	}
	
	
	
	
	public int updateProjectFromGantt(Gantt_Task uptGT) {
		return dao.updateProjectFromGantt(uptGT);
	}
	public int updateTaskFromGantt(Gantt_Task uptGT) {
		return dao.updateTaskFromGantt(uptGT);
	}
	
	
	
	
	
	
	
	public int insertLinkFromGantt(Gantt_Links insGL) {
		return dao.insertLinkFromGantt(insGL);
	}
	
	
	public int deleteLinkFromGantt(long delID) {
		return dao.deleteLinkFromGantt(delID);
	}
	
	public int deleteLinkByProjectDelete(long prjID) {
		return dao.deleteLinkByProjectDelete(prjID);
	}
	

}
