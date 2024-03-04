package com.web.spring.vo;

public class ChattingRoom {
	private String roomname; // 채팅방 이름
	private String chatuserid; // 접속자 사원번호

	public ChattingRoom() {

	}

	public ChattingRoom(String roomname, String chatuserid) {
		this.roomname = roomname;
		this.chatuserid = chatuserid;
	}

	public ChattingRoom(String roomname) {
		this.roomname = roomname;
	}

	public String getRoomname() {
		return roomname;
	}

	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}

	public String getChatuserid() {
		return chatuserid;
	}

	public void setChatuserid(String chatuserid) {
		this.chatuserid = chatuserid;
	}

	

}
