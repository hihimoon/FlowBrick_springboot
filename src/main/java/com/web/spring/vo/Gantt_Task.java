package com.web.spring.vo;



public class Gantt_Task {

	private long id;
	private String start_date;
	private String end_date;
	private String text;
	private double progress;
	private long parent;
	private int priority;
	private String step;

	public void showAll() {
		System.out.println("\n");
		System.out.println("id : "+this.id);
		System.out.println("start_date : "+this.start_date);
		System.out.println("end_date : "+this.end_date);
		System.out.println("text : "+this.text);
		System.out.println("progress : "+this.progress);
		System.out.println("parent : "+this.parent);
		System.out.println("priority : "+this.priority);
		System.out.println("step : "+this.step);
		System.out.println("\n");
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public double getProgress() {
		return progress;
	}
	public void setProgress(double progress) {
		this.progress = progress;
	}
	public long getParent() {
		return parent;
	}
	public void setParent(long parent) {
		this.parent = parent;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}

	public Gantt_Task(long id, String start_date, String end_date, String text, double progress, long parent,
			int priority, String step) {
		super();
		this.id = id;
		this.start_date = start_date;
		this.end_date = end_date;
		this.text = text;
		this.progress = progress;
		this.parent = parent;
		this.priority = priority;
		this.step = step;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}

	public Gantt_Task() {
		super();
	}
	
	

	

}
