package com.web.spring.vo;

import java.util.List;

public class DeptPaging {
	private DeptSch sch;
	private List<Dept> dlist;
	public DeptPaging() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DeptPaging(DeptSch sch, List<Dept> dlist) {
		super();
		this.sch = sch;
		this.dlist = dlist;
	}
	public DeptSch getSch() {
		return sch;
	}
	public void setSch(DeptSch sch) {
		this.sch = sch;
	}
	public List<Dept> getDlist() {
		return dlist;
	}
	public void setDlist(List<Dept> dlist) {
		this.dlist = dlist;
	}
	
}
