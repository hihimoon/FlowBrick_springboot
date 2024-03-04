package com.web.spring.vo;

public class MaterialResourceSch {
	
	
	private int materialresourceno; //물적자원번호
	private long prjNo; //프로젝트번호
	private String prjname; //프로젝트이름
	private String materialresourcename; //자원이름
	// 2. 페이징처리1단계
	private int count;//전체 데이터 건수
	private int pageSize; // 한페이지에 보여줄 데이터 건수
	private int pageCount; // 총페이지수
	private int curPage; // 클릭한 현재 페이지 번호
	private int start; // 현재 시작번호
	private int end; //현재 마지막번호

		// 3. 페이징처리2단계(페이징블럭)
	private int blockSize; // 한번에 보여줄 block의 크기
	private int startBlock; // block시작번호
	private int endBlock; // block마지막번호
	public int getMaterialresourceno() {
		return materialresourceno;
	}
	public void setMaterialresourceno(int materialresourceno) {
		this.materialresourceno = materialresourceno;
	}
	public long getPrjNo() {
		return prjNo;
	}
	public void setPrjNo(long prjNo) {
		this.prjNo = prjNo;
	}
	public String getPrjname() {
		return prjname;
	}
	public void setPrjname(String prjname) {
		this.prjname = prjname;
	}
	public String getMaterialresourcename() {
		return materialresourcename;
	}
	public void setMaterialresourcename(String materialresourcename) {
		this.materialresourcename = materialresourcename;
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
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
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
	public MaterialResourceSch() {
		super();
	}
	public MaterialResourceSch(int materialresourceno, long prjNo, String prjname, String materialresourcename,
			int count, int pageSize, int pageCount, int curPage, int start, int end, int blockSize, int startBlock,
			int endBlock) {
		super();
		this.materialresourceno = materialresourceno;
		this.prjNo = prjNo;
		this.prjname = prjname;
		this.materialresourcename = materialresourcename;
		this.count = count;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.start = start;
		this.end = end;
		this.blockSize = blockSize;
		this.startBlock = startBlock;
		this.endBlock = endBlock;
	}
	
	
	
	
	
}
