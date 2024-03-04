package com.web.spring.vo;

public class HumanResource {
	
	private String tel;
	private long prjNo;
	private int deptno;
	private int empno;
	private int sal;
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public long getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(long prjNo) {
		this.prjNo = prjNo;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public int getSal() {
		return sal;
	}
	public void setSal(int sal) {
		this.sal = sal;
	}
	public HumanResource(String tel, long prjNo, int deptno, int empno, int sal) {
		super();
		this.tel = tel;
		this.prjNo = prjNo;
		this.deptno = deptno;
		this.empno = empno;
		this.sal = sal;
	}
	public HumanResource() {
		super();
	}
	
	
	

}
