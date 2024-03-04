
package com.web.spring.vo;

import java.util.*;

public class ProjectBasic {
	private int cnt;
	private long prjNo; //프로젝트번호
	private String prjName; //프로젝트이름
	private double prjPriority; //프로젝트중요도
	private Date prjAcceptDate; //프로젝트수주일
	private Date prjBegin; //프로젝트시작일
	private Date prjEnd; //프로젝트종료일
	private String prjStep; //프로젝트진행단계
	private String prjAcceptDateStr;
	private String beginDateStr; //beginString변환용 
	private String endDateStr; //endString변환용 
	private int level;
	private double progress;
	private int sortorder;
	private long parent;
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public long getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(long prjNo) {
		this.prjNo = prjNo;
	}
	public String getPrjName() {
		return prjName;
	}
	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}
	public double getPrjPriority() {
		return prjPriority;
	}
	public void setPrjPriority(double prjPriority) {
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
	public String getPrjAcceptDateStr() {
		return prjAcceptDateStr;
	}
	public void setPrjAcceptDateStr(String prjAcceptDateStr) {
		this.prjAcceptDateStr = prjAcceptDateStr;
	}
	public String getBeginDateStr() {
		return beginDateStr;
	}
	public void setBeginDateStr(String beginDateStr) {
		this.beginDateStr = beginDateStr;
	}
	public String getEndDateStr() {
		return endDateStr;
	}
	public void setEndDateStr(String endDateStr) {
		this.endDateStr = endDateStr;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public double getProgress() {
		return progress;
	}
	public void setProgress(double progress) {
		this.progress = progress;
	}
	public int getSortorder() {
		return sortorder;
	}
	public void setSortorder(int sortorder) {
		this.sortorder = sortorder;
	}
	public long getParent() {
		return parent;
	}
	public void setParent(long parent) {
		this.parent = parent;
	}
	public ProjectBasic(int cnt, long prjNo, String prjName, double prjPriority, Date prjAcceptDate, Date prjBegin,
			Date prjEnd, String prjStep, String prjAcceptDateStr, String beginDateStr, String endDateStr, int level,
			double progress, int sortorder, int parent) {
		super();
		this.cnt = cnt;
		this.prjNo = prjNo;
		this.prjName = prjName;
		this.prjPriority = prjPriority;
		this.prjAcceptDate = prjAcceptDate;
		this.prjBegin = prjBegin;
		this.prjEnd = prjEnd;
		this.prjStep = prjStep;
		this.prjAcceptDateStr = prjAcceptDateStr;
		this.beginDateStr = beginDateStr;
		this.endDateStr = endDateStr;
		this.level = level;
		this.progress = progress;
		this.sortorder = sortorder;
		this.parent = parent;
	}
	public ProjectBasic() {
		super();
	}
	
	

}
