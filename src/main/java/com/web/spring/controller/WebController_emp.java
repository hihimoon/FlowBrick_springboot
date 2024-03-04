package com.web.spring.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.web.spring.service.WebService_emp;
import com.web.spring.vo.Dept;
import com.web.spring.vo.DeptPaging;
import com.web.spring.vo.DeptSch;
import com.web.spring.vo.Emp;
import com.web.spring.vo.EmpInfo;
import com.web.spring.vo.EmpPaging;
import com.web.spring.vo.EmpSch;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class WebController_emp {
	@Autowired(required = false)
	private WebService_emp service;

	// 다국어 처리 : 컨테이너에 선언한 지역 언어선택 객체 호출
	@Autowired(required = false)
	private SessionLocaleResolver localeResolver;

	// http://211.63.89.67:2222/login.do
	// http://localhost:2222/login.do
	@GetMapping("login.do")
	public String loginFrm() {
		return "login";
	}

	// 로그인
	@PostMapping("login.do")
	public String login(Emp emp, HttpSession session) {
		Emp empResult = service.login(emp);
		if (empResult != null) {
			session.setAttribute("empResult", empResult);
		}
		return "login";
	}

	// 로그인 다국어 처리
	@RequestMapping("multiLang")
	public String multiLang(@RequestParam(value = "lang", defaultValue = "ko") String lang, HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("선택한 언어:" + lang);
		// 화면에 지역에 따른 언어선택을 전송 처리..
		Locale locale = new Locale(lang);
		localeResolver.setLocale(request, response, locale);

		return "login";
	}

	// 로그아웃
	@GetMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login.do";
	}

	@GetMapping("forgotEmpno")
	public String forgotFrm() {
		return "forgotEmpno";
	}

	// 사원번호찾기
	@PostMapping("forgotEmpno")
	public String forgot(@RequestParam("email") String email, Model d) {
		// 1. 사원번호 찾기
		String forgotEmpnoResult = service.forgotEmpno(email);
		d.addAttribute("msg", forgotEmpnoResult);
		// 2. 사원번호찾기가 성공했을 경우에만 이메일 발송
		String div = "schEmpno";
		if ("사원번호찾기 성공".equals(forgotEmpnoResult)) {
			d.addAttribute("emailMsg", service.sendMail(email, div));
		}
		return "forgotEmpno";
	}

	@GetMapping("forgotPwd")
	public String forgotPwdFrm() {
		return "forgotPwd";
	}

	// 비밀번호 찾기

	@PostMapping("forgotPwd")
	public String forgotPwd(Emp emp, Model d) { //
		// 1. 계정 찾기
		String forgotPwdResult = service.forgotPwd(emp);
		d.addAttribute("msg", forgotPwdResult);

		// 2. 계정찾기가 성공했을 경우에만 임시비밀번호 발급 및 이메일발송
		if ("비밀번호찾기 성공".equals(forgotPwdResult)) {
			String password = service.getTempPassword();
			emp.setPassword(password); 
			// 생성된 임시 비밀번호를 emp 객체의 password에 설정
			// 임시비밀번호 업데이트
			service.updateTempPw(emp);
			String div = "schPwd";
			d.addAttribute("emailMsg", service.sendMail(emp.getEmail(), div));
		}

		return "forgotPwd";
	}

	@GetMapping("signUp.do")
	public String signUpFrm() {
		return "signUp";
	}

	@PostMapping("signUp.do")
	public String signUp(Emp emp, Model d) {
		// 1. 회원 등록
		String signUpResult = service.signUp(emp);
		d.addAttribute("msg", signUpResult);
		// 2. 회원 등록이 성공했을 경우에만 이메일 발송
		String div = "reg";
		if ("등록성공".equals(signUpResult)) {
			d.addAttribute("emailMsg", service.sendMail(emp.getEmail(), div));
		}

		return "signUp";
	}

	@GetMapping("mypage.do")
	public String mypageFrm(HttpSession session, Model d) {
		Emp emp = (Emp) session.getAttribute("empResult");
		if (emp != null) {
			int empno = emp.getEmpno();
			// 회원정보 조회
			EmpInfo empInfo = service.getEmpInfo(empno);
			d.addAttribute("empInfo", empInfo);
		}
		return "mypage";
	}

	@PostMapping("mypage.do")
	public String updateEmpInfo(HttpSession session, Emp upt, Model d) {
		d.addAttribute("msg", service.updateEmpInfo(upt));
		// 다시 세션에서 로그인한 사용자 정보를 가져와 회원정보 조회
		Emp emp = (Emp) session.getAttribute("empResult");
		int empno = emp.getEmpno();
		d.addAttribute("empInfo", service.getEmpInfo(empno));
		return "mypage";
	}

	// 비밀번호 변경 폼
	@GetMapping("passwordChanges.do")
	public String passwordChangesFrm() {
		return "password_changes";
	}
	
	// 비밀번호 변경
	@PostMapping("passwordChanges.do")
	public String passwordChanges(Emp emp,Model d, HttpSession session) {
		d.addAttribute("msg", service.updatePwd(emp));
		Emp newEmpResult=service.getEmp(emp.getEmpno());
		session.setAttribute("empResult", newEmpResult);
		return "password_changes";
	}

	// 부서등록 페이지
	@GetMapping("deptReg.do")
	public String deptRegFrm() {
		return "deptReg";
	}

	// 부서등록
	@PostMapping("deptReg.do")
	public String deptReg(Dept ins, Model d) {
		d.addAttribute("msg", service.insertDept(ins));
		return "deptReg";
	}

	// 부서목룍
	@GetMapping("deptList.do")
	public String deptListFrm() {
		return "deptList";
	}

	// http://localhost:2222/deptListJson
	@PostMapping("deptListJson")
	public ResponseEntity<?> deptListJson(DeptSch sch) {
		return ResponseEntity.ok(new DeptPaging(sch, service.deptList(sch)));
	}

	// http://localhost:2222/deptDetail?deptno=10000
	@GetMapping("deptDetail")
	public String deptDetail(@RequestParam("deptno") int deptno, Model d) {
		d.addAttribute("dept", service.getDept(deptno));
		return "dept_detail";
	}

	@PostMapping("deptUpdate")
	public String deptUpdate(Dept upt, Model d) {
		d.addAttribute("proc", "upt");
		d.addAttribute("msg", service.deptUpdate(upt));
		d.addAttribute("dept", service.getDept(upt.getDeptno()));
		return "dept_detail";
	}

	@GetMapping("deptDelete")
	public String deptDelete(@RequestParam("deptno") int deptno, Model d) {
		d.addAttribute("proc", "del");
		d.addAttribute("msg", service.deptDelete(deptno));
		return "dept_detail";
	}

	// http://localhost:2222/checkDupDetpnoJson
	@GetMapping("checkDupDetpnoJson")
	public ResponseEntity<?> checkDupDetpnoJson(@RequestParam("deptno") int deptno) {
		return ResponseEntity.ok(service.checkDupDeptno(deptno));
	}

	// 사원목록
	@GetMapping("empList.do")
	public String empListFrm() {
		return "empList";
	}

	// http://localhost:2222/empListJson
	@PostMapping("empListJson")
	public ResponseEntity<?> empListJson(EmpSch sch) {
		return ResponseEntity.ok(new EmpPaging(sch, service.empList(sch)));
	}

	// http://localhost:2222/deptDetail?deptno=10000
	@GetMapping("empDetail")
	public String empDetail(@RequestParam("empno") int empno, Model d) {
		d.addAttribute("emp", service.getEmp(empno));
		return "emp_detail";
	}

	@PostMapping("empUpdate")
	public String empUpdate(Emp upt, Model d) {
		d.addAttribute("proc", "upt");
		d.addAttribute("msg", service.empUpdate(upt));
		d.addAttribute("emp", service.getEmp(upt.getEmpno()));
		return "emp_detail";
	}

	@GetMapping("empDelete")
	public String empDelete(@RequestParam("empno") int empno, Model d) {
		d.addAttribute("proc", "del");
		d.addAttribute("msg", service.empDelete(empno));
		return "emp_detail";
	}

	@ModelAttribute("dlist")
	public List<Dept> deptList() {
		return service.deptList(new DeptSch());
	}

	@ModelAttribute("jobs") // job, mgrInfos
	public List<String> getJobs() {
		return service.getJobs();
	}
	
	@ModelAttribute("auths") // job, mgrInfos
	public List<String> getAuths() {
		return service.getAuths();
	}

}
