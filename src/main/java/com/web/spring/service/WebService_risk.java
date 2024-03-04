package com.web.spring.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
public class WebService_risk {
	@Autowired(required = false)
	private Dao_risk dao;
	
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
	
	// 리스크 상세화면
	public Risk getRiskDetail(int riskNo) {
		Risk risk = dao.getRiskDetail(riskNo);
		risk.setFnames(dao.getRiskFile(riskNo));
		return risk;
	}
	
	// 로그인 session에 해당하는 프로젝트 리스트 출력
    public List<ProjectBasic> getProjectByEmp(HttpSession session) {
        // 세션에서 empno 값을 가져옵니다.
    	Emp empnoObject = new Emp();
        empnoObject = (Emp)session.getAttribute("empResult");
     
        // empno 값이 null인지 확인합니다.
        if (empnoObject != null) {
            int empno = empnoObject.getEmpno();
            
            // service의 getProject 메서드를 호출하여 프로젝트 목록을 가져옵니다.
            return dao.getProjectByEmp(empno);
        } else {
            // empno 값이 null이면 빈 리스트를 반환합니다.
            return new ArrayList<>();
        }
    }
    
    // 리스크 DB내 프로젝트 키에 해당하는 프로젝트명 출력
    public List<ProjectBasic> getProjectByPrjNo(long prjNo) {
    	return dao.getProjectByPrjNo(prjNo);
    }
    
    // 리스크 DB내 사원 키에 해당하는 사원명 출력
    public List<Emp> getEmpbyEmpNo(int empno) {
    	return dao.getEmpByEmpNo(empno);
    }
	
    // 파일 저장 경로
	@Value("${riskFile.upload}")
	private String path;
	
	// 등록 처리
	public String insertRisk(Risk ins) {
		int insertRiskInfo = dao.insertRisk(ins);
		String msg = insertRiskInfo>0?"리스크 등록 성공":"등록 실패"; msg+="\\n";
		
		int insertRiskFile =0;
		MultipartFile [] mpfs = ins.getReports();
		if(mpfs!=null && mpfs.length>0) {
			try {
				for(MultipartFile mpf:mpfs) {
				// 1) 파일업로드 처리
					String fname = mpf.getOriginalFilename();
					mpf.transferTo(new File(path+fname));
					insertRiskFile += dao.insertRiskFile(
							new RiskFile(fname, path, "프로젝트 : " + ins.getPrjName() + "리스크 : " +ins.getRiskName()));
				}
			} catch (IllegalStateException e) {
				msg += "파일업로드 오류 : " + e.getMessage() + "\\n";
			} catch (IOException e) {
				msg += "기타 오류 : " + e.getMessage() + "\\n";
			}
			msg += "리스크 파일 " + insertRiskFile + "건 등록 완료";
		}
		return msg;
	}
	
	// 리스크 업데이트 처리
	public String updateRisk(Risk upt) {
		int updateRiskInfo = dao.updateRisk(upt);
		String msg = updateRiskInfo>0?"리스크 수정 성공":"수정 실패"; msg+="\\n";
		int updateRiskFile=0;
		MultipartFile [] mpfs = upt.getReports();
		if(mpfs!=null && mpfs.length>0) {
			try {
				for(MultipartFile mpf:mpfs) {
				// 1) 파일업로드 처리
					String fname = mpf.getOriginalFilename();
					mpf.transferTo(new File(path+fname));
					updateRiskFile += dao.updateRiskFile(
							new RiskFile(upt.getRiskNo(), fname, path, "프로젝트 : " + upt.getPrjName() + "리스크 : " +upt.getRiskName()));
				}
			} catch (IllegalStateException e) {
				msg += "파일업로드 오류 : " + e.getMessage() + "\\n";
			} catch (IOException e) {
				msg += "기타 오류 : " + e.getMessage() + "\\n";
			}
			msg += "리스크 파일 " + updateRiskFile + "건 등록 완료";
				
		}
		return msg;
	}
	
	// 리스크 삭제
	public String deleteRisk(int riskNo) {
		// 1. 파일 목록 가져오기
		List<String> delFnames = dao.getRiskFile(riskNo);
		for(String fname:delFnames) {
			// 2. 경로명, 파일명과 함께 파일 객체 생성
			File fileToDelete = new File(path+fname);
			// 3. 파일이 존재할 때, 물리적으로 해당 파일 삭제 처리
			if(fileToDelete.exists()) { 
				fileToDelete.delete();
			}
		}
		int delRisk = dao.deleteRisk(riskNo);
		int delRiskFile = dao.deleteRiskFile(riskNo);
		String msg = delRisk>0?"리스크 삭제 성공":"삭제 실패";
		if(delRiskFile>0) {
			msg+="\\n";
			msg+="등록된 파일"+delRiskFile+"건 삭제 완료";
		}
		return msg;
	}
	
	// 파일 삭제 처리
	public String deleteFile(RiskFile del) {
		String fname = del.getFname();
		File fileToDelete = new File(path+fname);
		if(fileToDelete.exists()) {
			fileToDelete.delete();
		}
		return dao.deleteFile(del.getFileNo())>0?"삭제 성공":"삭제 실패";
	}
	
	
}
