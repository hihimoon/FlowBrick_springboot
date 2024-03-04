package com.web.spring.service;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.web.spring.dao.Dao_emp;
import com.web.spring.vo.Dept;
import com.web.spring.vo.DeptSch;
import com.web.spring.vo.Emp;
import com.web.spring.vo.EmpInfo;
import com.web.spring.vo.EmpSch;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMessage.RecipientType;

@Service
public class WebService_emp {
	@Autowired(required = false)
	private Dao_emp dao;
	@Autowired(required = false)
	private JavaMailSender sender;

	public Emp login(Emp sch) {
		return dao.login(sch); // null, 객체가 할당.
	}

	// 사원번호 찾기
	public String forgotEmpno(String email) {
		return dao.checkEmpno(email) > 0 ? "사원번호찾기 성공" : 
			"사원번호찾기 실패\\n해당 이메일 주소를 찾을 수 없습니다.";
	}

	// 비밀번호 찾기
	public String forgotPwd(Emp emp) {
		return dao.forgotPwd(emp) > 0 ? "비밀번호찾기 성공" : "비밀번호찾기 실패\\n해당 정보를 찾을 수 없습니다.";
	}

	// 임시 비밀번호 저장
	public int updateTempPw(Emp emp) {
		return dao.updateTempPw(emp);
	}

	// 메일발송 메서드
	public String sendMail(String email, String div) {
		String emailMsg = "";
		// 사원정보가져오기
		Emp empInfo = dao.getEmpByEmail(email);

		// 1. 메일 발송 데이터 전송을 위한 객체 생성.
		MimeMessage mmsg = sender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(mmsg, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
					StandardCharsets.UTF_8.name());

			helper.setTo(empInfo.getEmail()); // 받는사람
			String message = "";
			if (div.equals("reg")) {
				helper.setSubject("[FlowBrick] 사원번호와 임시비밀번호 전달 건"); // 메일제목

				message += empInfo.getEname() + "님의 사원번호는 " + empInfo.getEmpno() + " 입니다<br>";
				message += "임시 비밀번호는 " + empInfo.getPassword() + " 입니다";
				helper.setText(message, true); // ture넣을경우 html
			}
			if (div.equals("schEmpno")) {
				helper.setSubject("[FlowBrick] 사원번호찾기 정보 전달 건"); // 메일제목
				message += empInfo.getEname() + "님의 사원번호는 " + empInfo.getEmpno() + " 입니다<br>";
				helper.setText(message, true); //
			}
			if (div.equals("schPwd")) {
				helper.setSubject("[FlowBrick] 비밀번호찾기 정보 전달 건"); // 메일제목
				message += empInfo.getEname() + "님의 임시비밀번호는 " + empInfo.getPassword()+" 입니다<br>";
				helper.setText(message, true); //
			}

			// 4) 발송처리..
			sender.send(mmsg);

			emailMsg = "메일발송 성공";

		} catch (MessagingException e) {
			System.out.println("메시지 전송 에러 발송:" + e.getMessage());
			emailMsg = "메일 발송 에러 발생:" + e.getMessage();
		} catch (Exception e) {
			System.out.println("기타 에러 :" + e.getMessage());
			emailMsg = "기타 에러 발생:" + e.getMessage();
		}

		return emailMsg;

	}

	public String signUp(Emp ins) {
		String password = getTempPassword(); // 임시 비밀번호 생성
		ins.setPassword(password); // 생성된 임시 비밀번호를 emp 객체의 password에 설정
		return dao.signUp(ins) > 0 ? "등록성공" : "등록실패";
	}

	// 임시 비밀번호 생성
	public String getTempPassword() {
		char[] charList = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F','G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
				'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
		String tempPw = "";
		int idx = 0;
		for (int i = 0; i < 8; i++) {
			idx = (int) (Math.random() * 36);
			tempPw += charList[idx];
		}
		return tempPw;
	}

	public EmpInfo getEmpInfo(int empno) {
		return dao.getEmpInfo(empno);
	}

	public String updateEmpInfo(Emp upt) {
		return dao.updateEmpInfo(upt) > 0 ? "수정성공" : "수정실패";
	}

	// 비밀번호 변경
	public String updatePwd(Emp emp) {
		return dao.updatePwd(emp) > 0 ? "수정성공" : "수정실패";
	}

	public String insertDept(Dept ins) {
		return dao.insertDept(ins) > 0 ? "등록성공" : "등록실패";
	}

	// 부서번호 리스트 불러오기
	public List<Dept> deptList(DeptSch sch) {
		if (sch.getDname() == null)
			sch.setDname("");

		// 페이징 처리
		sch.setCount(dao.totDept(sch));
		if (sch.getPageSize() == 0)
			sch.setPageSize(5);
		sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));
		if (sch.getCurPage() > sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		if (sch.getCurPage() == 0)
			sch.setCurPage(1);
		sch.setEnd(sch.getCurPage() * sch.getPageSize());
		if (sch.getEnd() > sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);
		sch.setBlockSize(5);
		int blockNum = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());
		sch.setEndBlock(blockNum * sch.getBlockSize());
		if (sch.getEndBlock() > sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);
		return dao.deptList(sch);
	}

	public Dept getDept(@Param("deptno") int deptno) {
		return dao.getDept(deptno);
	}

	public String deptUpdate(Dept upt) {
		return dao.deptUpdate(upt) > 0 ? "수정성공" : "수정실패";
	}

	public String deptDelete(int deptno) {
		dao.empUpdateByDeptDelete(deptno);
		return dao.deptDelete(deptno) > 0 ? "삭제성공" : "삭제실패";
	}

	// 부서번호 중복 검사
	public int checkDupDeptno(int deptno) {
		return dao.checkDupDeptno(deptno);
	}

	// 사원번호 리스트 불러오기
	public List<Emp> empList(EmpSch sch) {
		if (sch.getEname() == null)
			sch.setEname("");

		// 페이징 처리
		sch.setCount(dao.totEmp(sch));
		if (sch.getPageSize() == 0)
			sch.setPageSize(5);
		sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));
		if (sch.getCurPage() > sch.getPageCount())
			sch.setCurPage(sch.getPageCount());
		if (sch.getCurPage() == 0)
			sch.setCurPage(1);
		sch.setEnd(sch.getCurPage() * sch.getPageSize());
		if (sch.getEnd() > sch.getCount()) {
			sch.setEnd(sch.getCount());
		}
		sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);
		sch.setBlockSize(5);
		int blockNum = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());
		sch.setEndBlock(blockNum * sch.getBlockSize());
		if (sch.getEndBlock() > sch.getPageCount()) {
			sch.setEndBlock(sch.getPageCount());
		}
		sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);
		return dao.empList(sch);
	}

	public Emp getEmp(@Param("empno") int empno) {
		return dao.getEmp(empno);
	}

	public String empUpdate(Emp upt) {
		return dao.empUpdate(upt) > 0 ? "수정성공" : "수정실패";
	}

	public String empDelete(int empno) {
		return dao.empDelete(empno) > 0 ? "삭제성공" : "삭제실패";
	}

	public List<String> getJobs() {
		return dao.getJobs();
	};
	
	public List<String> getAuths() {
		return dao.getAuths();
	};

}
