package com.web.spring.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.dao.Dao_notice;
import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeFile;
import com.web.spring.vo.NoticeSch;

@Service
public class WebService_notice {
	@Autowired(required = false)
	private Dao_notice dao;
	// 공지사항 리스트 불러오기
	public List<Notice> noticeList(NoticeSch sch) {
		if(sch.getTitle()==null) sch.setTitle("");
		if(sch.getWriter()==null) sch.setWriter("");
		
		sch.setCount(dao.totNotice(sch));
		
		if(sch.getPageSize()==0) sch.setPageSize(5);
		
		sch.setPageCount((int)Math.ceil(sch.getCount()/(double)sch.getPageSize()));
		
		if(sch.getCurPage()>sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		
		if(sch.getCurPage()==0) sch.setCurPage(1);
		
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		
		if(sch.getEnd()>sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		
		sch.setBlockSize(5);
		
		//System.out.println("현재 페이지 번호");
		//System.out.println(sch.getCurPage());
		//System.out.println("블럭의 크기");
		//System.out.println(sch.getBlockSize());
		int blockNum = (int)Math.ceil(sch.getCurPage()/
				(double)sch.getBlockSize());

		sch.setEndBlock(blockNum*sch.getBlockSize());

		if(sch.getEndBlock()>sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}

		sch.setStartBlock((blockNum-1)*sch.getBlockSize()+1);
		//System.out.println(blockNum);
		//System.out.println(sch.getBlockSize());
		
		//System.out.println("## 시작 블럭 크기 #");
		//System.out.println(sch.getStartBlock());
		
		return dao.noticeList(sch);
	} 
	
    @Value("${file.upload}") // application 의 properties 의 변수
    private String path;
	//private String path = "C:/a01_springbt/workspace/flowbrick/src/main/resources/static/z02_upload/";
	// 등록처리
	public String insertNotice(Notice ins) {
		int ck01 = dao.insertNotice(ins);
		String msg = ck01>0?"공지사항 등록성공":"등록실패"; msg+="\\n";
		int ck02 = 0;
		// 파일업로드 정보 등록 처리.
		MultipartFile [] mpfs = ins.getReports();	

		if( mpfs!=null && mpfs.length>0) {
			
			try {
				for(MultipartFile mpf:mpfs) {
				//  1) 파일업로드 처리
					String fname = mpf.getOriginalFilename();
					
					// MultipartFile ==> File 변환해서 저장.
					System.out.println("파일:"+fname);
				//	System.out.println("경로:"+path);
					mpf.transferTo(new File(path+fname));
				//  2) db파일업로드 정보 입력	
				//  등록되는 갯수만큼 numbering 처리..				
					ck02+=dao.insertNoticeFile(
							new NoticeFile(fname,path,ins.getTitle(), mpf.getSize()));	
				}
			} catch (IllegalStateException e) {
				System.out.println("#파일업로드 예외1:"+e.getMessage());
				msg+="#파일업로드 예외1:"+e.getMessage()+"\\n";
			} catch(Exception e) {
				System.out.println("#기타 예외3:"+e.getMessage());
				msg+="#기타 예외3:"+e.getMessage()+"\\n";
			}
			msg+="파일 "+ck02+"건 등록 완료";
		}
		return msg;
	}
	
	// 상세화면
	public Notice getDetailNotice(int no) {
		// 조회할 때, 조회수 count up
		dao.readCntUptNotice(no);
		return getNotice(no);
	}
	public Notice getNotice(int no) {
		// 기본 상세정보
		Notice notice = dao.getNotice(no);
		// 파일 정보까지 추가하고 board리턴..
		notice.setFnames(dao.getNoticeFile(no));
		return notice;
	}
	public List<NoticeFile> getNoticeFiles(int no){
		
		return dao.getNoticeFiles(no);
	}
	// 수정처리
	public String updateNotice(Notice upt) {
		int ck01 = dao.updateNotice(upt);
		String msg = ck01>0?"공지사항 수정성공":"수정실패"; msg+="\\n";
		int ck02 = 0;
		// 파일업로드 정보 등록 처리.
		MultipartFile [] mpfs = upt.getReports();
		
		if( mpfs!=null && mpfs.length>0) {
			
			try {
				for(MultipartFile mpf:mpfs) {
				//  1) 파일업로드 처리
					String fname = mpf.getOriginalFilename();
					System.out.println("용량:"+mpf.getSize());
					// MultipartFile ==> File 변환해서 저장.
					System.out.println("파일:"+fname);
				//	System.out.println("경로:"+path);
					mpf.transferTo(new File(path+fname));
				//  2) db파일업로드 정보 입력	
				//  등록되는 갯수만큼 numbering 처리..				
					ck02+=dao.UpdateNoticeFile(
							new NoticeFile(upt.getNo(),fname,path,upt.getTitle(), mpf.getSize()));	
				}
			} catch (IllegalStateException e) {
				System.out.println("#파일업로드 예외1:"+e.getMessage());
				msg+="#파일업로드 예외1:"+e.getMessage()+"\\n";
			} catch(Exception e) {
				System.out.println("#기타 예외3:"+e.getMessage());
				msg+="#기타 예외3:"+e.getMessage()+"\\n";
			}
			msg+="파일 "+ck02+"건 등록 완료";
		}
		return msg;
	}
	// 파일만 삭제처리
	public String deleteFile(NoticeFile del) {
		String fname = del.getFname();
		File fileToDelete = new File(path+fname);
		if(fileToDelete.exists()) fileToDelete.delete();		
		return dao.deleteFile(del)>0?"삭제성공":"삭제실패";
	}
	
	
	// 삭제처리
	public String deleteNotice(int no) {
		// 1. 파일 목록 가져오기
		List<String> delFnames = dao.getNoticeFile(no);
		for(String fname:delFnames) {
			// 2. 경로명과 파일명과 함께 파일 객체 생성
			File fileToDelete = new File(path+fname);
			// 3. 파일이 존재할 때, 물리적으로 해당 파일 삭제처리..
			if(fileToDelete.exists()) fileToDelete.delete();
		}
		int ck01 = dao.deleteNotice(no);
		int ck02 = dao.deleteNoticeFile(no);
		String msg = ck01>0?"글번호 "+no+" 삭제 성공":"삭제 실패"; 
		System.out.println(msg);
		if( ck02>0 ) {
			msg+="\\n";
			msg+="등록 파일 "+ck02+"건 삭제";
		}
		return msg;
	}	 
}
