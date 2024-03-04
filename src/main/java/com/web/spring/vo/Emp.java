package com.web.spring.vo;

import java.util.Date;

public class Emp {
	private int cnt;
	private int empno;
	private String ename;
	private String job;
	private String password;
	private String tel;
	private String email;
	private Date hiredate;
	private String auth;
	private int deptno;
	private String dname;
	private double sal;
	private String div;

	public Emp() {
	}

	public Emp(int empno, String ename, String job, String password, String tel, String email, Date hiredate,
			String auth, int deptno, String dname, double sal) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.password = password;
		this.tel = tel;
		this.email = email;
		this.hiredate = hiredate;
		this.auth = auth;
		this.deptno = deptno;
		this.dname = dname;
		this.sal = sal;
	}

	public Emp(int empno, String ename, String job, String email, String password) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.email = email;
		this.password = password;
	}

	public Emp(int empno, String ename, String job, String password, String email, int deptno, String auth) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.password = password;
		this.email = email;
		this.deptno = deptno;
		this.auth = auth;
	}

	public Emp(String ename, String job, String password, String email, int deptno) {
		this.ename = ename;
		this.job = job;
		this.password = password;
		this.email = email;
		this.deptno = deptno;
	}

	public Emp(int empno, String ename, String job, String tel, String auth, int deptno) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.tel = tel;
		this.auth = auth;
		this.deptno = deptno;
	}

	public Emp(String auth, String ename, String job, int deptno, String tel, int empno) {
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.tel = tel;
		this.auth = auth;
		this.deptno = deptno;
	}

	public Emp(int empno, String email, String password) {
		this.empno = empno;
		this.email = email;
		this.password = password;
	}

	public Emp(int empno, String email) {
		this.empno = empno;
		this.email = email;
	}

	public Emp(String password, int empno) {
		this.empno = empno;
		this.password = password;
	}
	

	public Emp(String email) {
		this.email = email;
	}

	public int getEmpno() {
		return empno;
	}

	public void setEmpno(int empno) {
		this.empno = empno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}

	public double getSal() {
		return sal;
	}

	public void setSal(double sal) {
		this.sal = sal;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getDiv() {
		return div;
	}

	public void setDiv(String div) {
		this.div = div;
	}

}
