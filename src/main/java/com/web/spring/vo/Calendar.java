package com.web.spring.vo;

public class Calendar {
	private int calId;
	private long prjNo;
	private int empNo;
	private String title;
	private String start;
	private String end;
	private String content;
	private String backgroundColor;
	private String textColor;
	private boolean allDay;
	private String urlLink;
	
	public Calendar() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Calendar(int calId, long prjNo, int empNo, String title, String start, String end, String content,
			String backgroundColor, String textColor, boolean allDay, String urlLink) {
		super();
		this.calId = calId;
		this.prjNo = prjNo;
		this.empNo = empNo;
		this.title = title;
		this.start = start;
		this.end = end;
		this.content = content;
		this.backgroundColor = backgroundColor;
		this.textColor = textColor;
		this.allDay = allDay;
		this.urlLink = urlLink;
	}

	public int getCalId() {
		return calId;
	}
	public void setCalId(int calId) {
		this.calId = calId;
	}
	public long getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(long prjNo) {
		this.prjNo = prjNo;
	}
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
	public String getTextColor() {
		return textColor;
	}
	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}
	public boolean isAllDay() {
		return allDay;
	}
	public void setAllDay(boolean allDay) {
		this.allDay = allDay;
	}
	public String getUrlLink() {
		return urlLink;
	}
	public void setUrlLink(String urlLink) {
		this.urlLink = urlLink;
	}
}
