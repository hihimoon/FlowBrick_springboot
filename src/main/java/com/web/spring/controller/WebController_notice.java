package com.web.spring.controller;


import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.service.WebService_notice;
import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeFile;
import com.web.spring.vo.NoticeSch;
import com.web.spring.vo.Wizet_PrjList;

@Controller
public class WebController_notice {
	@Autowired(required = false)
	private WebService_notice service;
	
	// http://211.63.89.67:2222/pms/notice.do
	// http://localhost:2222/notice.do
	@RequestMapping("notice.do")
	public String notice(@ModelAttribute("sch") NoticeSch sch, Model d) {
		
	    // 오늘 날짜
        LocalDate today = LocalDate.now();

        List<Notice> notice = service.noticeList(sch);
        
        for (Notice n : notice) {
        	
            Date date = n.getRegdte();
            LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

            long differenceInDays = today.toEpochDay() - localDate.toEpochDay();
            n.setDiff(differenceInDays);
		}       

		d.addAttribute("noticeList", notice);
		return "notice";
	}
	
	// 공지사항 작성
	@RequestMapping("insertNoticeFrm.do")
	public String insertNoticeFrm() {
		return "notice_insert";
	}
	@RequestMapping("insertNotice.do")
	public String insertNotice(Notice ins, Model d) {
		d.addAttribute("msg", service.insertNotice(ins));		
		return "notice_insert";
	}

	// 상세화면 조회
	@RequestMapping("detailNotice.do")
	public String getBoard(@RequestParam("no") int no, Model d) {
		d.addAttribute("notice", service.getDetailNotice(no));
		//d.addAttribute("notice_file", service.getNoticeFiles(no));
		return "notice_detail";
	}
	// 수정 페이지로 이동
	@RequestMapping("updateNoticeFrm.do")
	public String updateNoticeFrm(@RequestParam("no") int no, Model d) {
		d.addAttribute("notice", service.getDetailNotice(no));
		return "notice_update";		
	}
	// 수정 처리
	@RequestMapping("updateNotice.do")
	public String updateNotice(Notice upt, Model d) {
		// 수정 처리 내용
		d.addAttribute("proc","upt");
		d.addAttribute("msg", service.updateNotice(upt));
		System.out.println("수정처리끝");
		// 수정이후, 데이터
		d.addAttribute("notice", service.getNotice(upt.getNo()));
		return "notice_detail";
	}
	// 파일만삭제
	@RequestMapping("deleteFile.do")
	public String deleteFile(NoticeFile del, Model d) {
		System.out.println(del.getFname()+"을 삭제합니다.");
		d.addAttribute("msg", service.deleteFile(del));
		System.out.println("파일삭제끝");
		d.addAttribute("notice", service.getDetailNotice(del.getNo()));
		return "notice_update";
	}
	
	// 삭제 처리
	@RequestMapping("deleteNotice.do")
	public String deleteNotice(@RequestParam("no") int no, Model d) {
		d.addAttribute("proc","del");
		
		d.addAttribute("msg", service.deleteNotice(no));
		
		return "notice_detail";
	}
	// 다운로드
	@RequestMapping("download.do")
	public String download(@RequestParam("fname") String fname,
				Model d) {
		d.addAttribute("downloadFile", fname);
		return "downloadViewer";
	}
}
