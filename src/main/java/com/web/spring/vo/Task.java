
package com.web.spring.vo;

import java.util.*;

public class Task {
	private int cnt;
	private long taskNo; //업무번호
	private long prjNo;  //프로젝트번호
	private String taskName; //업무이름
	private double taskPriority; //업무중요도
	private Date taskAcceptDate; //업무수주일
	private Date taskBegin; //업무시작일
	private Date taskEnd; //업무종료일
	private String taskStep; //업무진행단계
	private String taskAcceptDateStr;
	private String taskBeginDateStr; //beginString변환용 
	private String taskEndDateStr; //endString변환용 
	private int level;
	private double progress;
	private int sortorder;
	private long parent;
	
	public Task() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Task(int cnt, long taskNo, long prjNo, String taskName, double taskPriority, Date taskAcceptDate,
			Date taskBegin, Date taskEnd, String taskStep, String taskAcceptDateStr, String taskBeginDateStr,
			String taskEndDateStr, int level, double progress, int sortorder, long parent) {
		super();
		this.cnt = cnt;
		this.taskNo = taskNo;
		this.prjNo = prjNo;
		this.taskName = taskName;
		this.taskPriority = taskPriority;
		this.taskAcceptDate = taskAcceptDate;
		this.taskBegin = taskBegin;
		this.taskEnd = taskEnd;
		this.taskStep = taskStep;
		this.taskAcceptDateStr = taskAcceptDateStr;
		this.taskBeginDateStr = taskBeginDateStr;
		this.taskEndDateStr = taskEndDateStr;
		this.level = level;
		this.progress = progress;
		this.sortorder = sortorder;
		this.parent = parent;
	}


	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public long getTaskNo() {
		return taskNo;
	}
	public void setTaskNo(long taskNo) {
		this.taskNo = taskNo;
	}
	public String getTaskName() {
		return taskName;
	}
	public long getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(long prjNo) {
		this.prjNo = prjNo;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public double getTaskPriority() {
		return taskPriority;
	}
	public void setTaskPriority(double taskPriority) {
		this.taskPriority = taskPriority;
	}
	public Date getTaskAcceptDate() {
		return taskAcceptDate;
	}
	public void setTaskAcceptDate(Date taskAcceptDate) {
		this.taskAcceptDate = taskAcceptDate;
	}
	public Date getTaskBegin() {
		return taskBegin;
	}
	public void setTaskBegin(Date taskBegin) {
		this.taskBegin = taskBegin;
	}
	public Date getTaskEnd() {
		return taskEnd;
	}
	public void setTaskEnd(Date taskEnd) {
		this.taskEnd = taskEnd;
	}
	public String getTaskStep() {
		return taskStep;
	}
	public void setTaskStep(String taskStep) {
		this.taskStep = taskStep;
	}
	public String getTaskAcceptDateStr() {
		return taskAcceptDateStr;
	}
	public void setTaskAcceptDateStr(String taskAcceptDateStr) {
		this.taskAcceptDateStr = taskAcceptDateStr;
	}
	public String getTaskBeginDateStr() {
		return taskBeginDateStr;
	}
	public void setTaskBeginDateStr(String taskBeginDateStr) {
		this.taskBeginDateStr = taskBeginDateStr;
	}
	public String getTaskEndDateStr() {
		return taskEndDateStr;
	}
	public void setTaskEndDateStr(String taskEndDateStr) {
		this.taskEndDateStr = taskEndDateStr;
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
}
