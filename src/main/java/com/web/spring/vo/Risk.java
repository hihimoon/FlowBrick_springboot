package com.web.spring.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Risk {
	private int cnt;
	private int riskNo;
	private long prjNo;
	private String prjName;
	private int empNo;
	private String ename;
	private String riskName;
	private String riskContent;
	private String dangerStep;
	private Date uploadDate;
	private String uploadDateStr;
	private Date completeDate;
	private String completeDateStr;
	private String state;
	private MultipartFile[] reports;
	private List<String> fnames;
	
	public Risk() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Risk(int cnt, int riskNo, long prjNo, String prjName, int empNo, String ename, String riskName,
			String riskContent, String dangerStep, Date uploadDate, String uploadDateStr, Date completeDate,
			String completeDateStr, String state) {
		super();
		this.cnt = cnt;
		this.riskNo = riskNo;
		this.prjNo = prjNo;
		this.prjName = prjName;
		this.empNo = empNo;
		this.ename = ename;
		this.riskName = riskName;
		this.riskContent = riskContent;
		this.dangerStep = dangerStep;
		this.uploadDate = uploadDate;
		this.uploadDateStr = uploadDateStr;
		this.completeDate = completeDate;
		this.completeDateStr = completeDateStr;
		this.state = state;
	}

	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getRiskNo() {
		return riskNo;
	}
	public void setRiskNo(int riskNo) {
		this.riskNo = riskNo;
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
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getRiskName() {
		return riskName;
	}
	public void setRiskName(String riskName) {
		this.riskName = riskName;
	}
	public String getRiskContent() {
		return riskContent;
	}
	public void setRiskContent(String riskContent) {
		this.riskContent = riskContent;
	}
	public String getDangerStep() {
		return dangerStep;
	}
	public void setDangerStep(String dangerStep) {
		this.dangerStep = dangerStep;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public Date getCompleteDate() {
		return completeDate;
	}
	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getUploadDateStr() {
		return uploadDateStr;
	}
	public void setUploadDateStr(String uploadDateStr) {
		this.uploadDateStr = uploadDateStr;
	}
	public String getCompleteDateStr() {
		return completeDateStr;
	}
	public void setCompleteDateStr(String completeDateStr) {
		this.completeDateStr = completeDateStr;
	}

	public MultipartFile[] getReports() {
		return reports;
	}

	public void setReports(MultipartFile[] reports) {
		this.reports = reports;
	}
	public List<String> getFnames() {
		return fnames;
	}
	public void setFnames(List<String> fnames) {
		this.fnames = fnames;
	}
}
