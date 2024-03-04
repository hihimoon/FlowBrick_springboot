package com.web.spring.vo;

import java.util.Date;

public class Wizet_PrjList {
	private int prjNo;
	private String prjName;
	private int prjPriority;
	private Date prjAcceptDate; //프로젝트수주일
	private Date prjBegin; //프로젝트시작일
	private Date prjEnd; //프로젝트종료일
	private String prjStep;
	private String teamName;
	private long diff; // 종료일-오늘날짜 저장변수
	private int risk;
	
	
	public Wizet_PrjList() {
		super();
	}

	public Wizet_PrjList(int prjNo, String prjName, int prjPriority, Date prjAcceptDate, Date prjBegin, Date prjEnd,
			String prjStep, String teamName, long diff, int risk) {
		super();
		this.prjNo = prjNo;
		this.prjName = prjName;
		this.prjPriority = prjPriority;
		this.prjAcceptDate = prjAcceptDate;
		this.prjBegin = prjBegin;
		this.prjEnd = prjEnd;
		this.prjStep = prjStep;
		this.teamName = teamName;
		this.diff = diff;
		this.risk = risk;
	}

	public int getPrjNo() {
		return prjNo;
	}

	public void setPrjNo(int prjNo) {
		this.prjNo = prjNo;
	}

	public String getPrjName() {
		return prjName;
	}

	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}

	public int getPrjPriority() {
		return prjPriority;
	}

	public void setPrjPriority(int prjPriority) {
		this.prjPriority = prjPriority;
	}

	public Date getPrjAcceptDate() {
		return prjAcceptDate;
	}

	public void setPrjAcceptDate(Date prjAcceptDate) {
		this.prjAcceptDate = prjAcceptDate;
	}

	public Date getPrjBegin() {
		return prjBegin;
	}

	public void setPrjBegin(Date prjBegin) {
		this.prjBegin = prjBegin;
	}

	public Date getPrjEnd() {
		return prjEnd;
	}

	public void setPrjEnd(Date prjEnd) {
		this.prjEnd = prjEnd;
	}

	public String getPrjStep() {
		return prjStep;
	}

	public void setPrjStep(String prjStep) {
		this.prjStep = prjStep;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public long getDiff() {
		return diff;
	}

	public void setDiff(long diff) {
		this.diff = diff;
	}

	public int getRisk() {
		return risk;
	}

	public void setRisk(int risk) {
		this.risk = risk;
	}
}
