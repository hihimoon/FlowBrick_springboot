package com.web.spring.vo;

public class Gantt_Links {
	private long id;
	private long source;
	private long target;
	private String type;

	
	
	public void showAll() {
		System.out.println("\n");
		System.out.println("id : "+this.id);
		System.out.println("source : "+this.source);
		System.out.println("target : "+this.target);
		System.out.println("type : "+this.type);
		System.out.println("\n");
	}
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getSource() {
		return source;
	}
	public void setSource(long source) {
		this.source = source;
	}
	public long getTarget() {
		return target;
	}
	public void setTarget(long target) {
		this.target = target;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Gantt_Links(long id, long source, long target, String type) {
		super();
		this.id = id;
		this.source = source;
		this.target = target;
		this.type = type;
	}
	public Gantt_Links() {
		super();
	}
	
	
	
	
	
}
