package com.web.spring.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class RiskFile {
	private int fileNo;
	private int riskNo;
	private String fname;
	private String path;
	private Date regdte;
	private Date uptdte;
	private String etc;
	public RiskFile(){
		
	}
	
	public RiskFile(String fname, String path, String etc) {
		this.fname = fname;
		this.path = path;
		this.etc = etc;
	}
	
	public RiskFile(int riskNo, String fname, String path, String etc) {
		super();
		this.riskNo = riskNo;
		this.fname = fname;
		this.path = path;
		this.etc = etc;
	}

	public RiskFile(int fileNo, int riskNo, String fname, String path, Date regdte, Date uptdte, String etc) {
		super();
		this.fileNo = fileNo;
		this.riskNo = riskNo;
		this.fname = fname;
		this.path = path;
		this.regdte = regdte;
		this.uptdte = uptdte;
		this.etc = etc;
	}

	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public int getRiskNo() {
		return riskNo;
	}
	public void setRiskNo(int riskNo) {
		this.riskNo = riskNo;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getRegdte() {
		return regdte;
	}
	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}
	public Date getUptdte() {
		return uptdte;
	}
	public void setUptdte(Date uptdte) {
		this.uptdte = uptdte;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
}
