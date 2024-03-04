package com.web.spring.vo;

public class TaskSch {
	// 1. 검색
	private String taskName;
	private double taskPriority;
	private String taskStep;
	// 2. 페이징 1단계
	private int count;
	private int pageSize;
	private int pageCount;
	private int curPage;
	private int startNo;
	private int endNo;
	// 3. 페이징처리 2단계(페이징 블럭)
	private int blockSize;
	private int startBlock;
	private int endBlock;
	
	public TaskSch() {
		// TODO Auto-generated constructor stub
	}

	public TaskSch(String taskName, double taskPriority, String taskStep, int count, int pageSize, int pageCount,
			int curPage, int startNo, int endNo, int blockSize, int startBlock, int endBlock) {
		super();
		this.taskName = taskName;
		this.taskPriority = taskPriority;
		this.taskStep = taskStep;
		this.count = count;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.startNo = startNo;
		this.endNo = endNo;
		this.blockSize = blockSize;
		this.startBlock = startBlock;
		this.endBlock = endBlock;
	}
	
	public String getTaskName() {
		return taskName;
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
	public String getTaskStep() {
		return taskStep;
	}
	public void setTaskStep(String taskStep) {
		this.taskStep = taskStep;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
}
