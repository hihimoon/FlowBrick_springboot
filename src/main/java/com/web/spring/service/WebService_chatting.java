package com.web.spring.service;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.web.spring.dao.ChatDao;
import com.web.spring.dao.Dao_chatting;
import com.web.spring.dao.Dao_emp;
import com.web.spring.vo.ChRoomInfo;
import com.web.spring.vo.ChattingRoom;
import com.web.spring.vo.Dept;
import com.web.spring.vo.DeptSch;
import com.web.spring.vo.Emp;
import com.web.spring.vo.EmpInfo;
import com.web.spring.vo.EmpSch;
import com.web.spring.vo.ProjectTeam;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMessage.RecipientType;

@Service
public class WebService_chatting {
	@Autowired(required = false)
	private ChatDao dao;

	/*
	 * public List<Emp> ChatEmpList(Emp sch) { // 초기 화면에 null일 때, ""으로 keyword
	 * 검색되기.. if (sch.getEname() == null) sch.setEname(""); return
	 * dao.chatEmpList(sch); }
	 * 
	 * // 채팅방 생성 public String insertChatRoom(ChattingRoom ins) { return
	 * dao.insertChatRoom(ins) > 0 ? "생성성공" : "생성실패"; }
	 * 
	 * 
	 * // 채팅방 리스트 출력 public List<String> chatRoomList(ChattingRoom sch) { if
	 * (sch.getRoomname() == null) sch.setRoomname(null); return
	 * dao.chatRoomList(sch); }
	 * 
	 * public List<String> chatRoomList(){ return dao.chatRoomList(); }
	 * 
	 * 
	 * // 채팅방 접속자 id 리스트 출력 public List<String> getEmpnoByRoom(String roomname) {
	 * return dao.getEmpnoByRoom(roomname); }
	 * 
	 * 
	 * 
	 * // 특정 사용자가 속한 채팅방의 모든 사용자 리스트 출력 public List<String>
	 * getUsersInChatRoom(String chatuserid) { return
	 * dao.getUsersInChatRoom(chatuserid); }
	 * 
	 * //채팅방 나가기 public String delChatRoom(String chatuserid) { return
	 * dao.delChatRoom(chatuserid) > 0 ? "퇴장성공" : "퇴장실패"; }
	 */

	public String insChatRoom(ChRoomInfo ins) {
		return dao.insChatRoom(ins)>0?"입장성공":"입장실패";
	}
	
	public String delChatRoom(ChRoomInfo del) {
		return dao.delChatRoom(del)>0?"퇴장성공":"퇴장실패";
	}

	public List<String> getChRooms(){
		return dao.getChRooms();
	}
	public List<String> getChRoomIds(String id){
		return dao.getChRoomIds(id);
	}	
	public List<String> getIdsByRoom(String chroom){
		return dao.getIdsByRoom(chroom);
	}		
	

}
