package com.web.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.spring.service.WebService_chatting;
import com.web.spring.service.WebService_emp;
import com.web.spring.vo.ChRoomInfo;
import com.web.spring.vo.ChattingRoom;
import com.web.spring.vo.Dept;
import com.web.spring.vo.DeptSch;
import com.web.spring.vo.Emp;
import com.web.spring.vo.EmpSch;
import com.web.spring.vo.InsertProjectRequest;

@Controller
public class WebController_chatting {

	/*
	 * @RequestMapping("chatting") public String ChatEmpList(Emp sch, Model d) {
	 * d.addAttribute("ChatEmpList", service.ChatEmpList(sch)); return "chatting"; }
	 * 
	 * 
	 * // http://localhost:2222/insertChatRoomJson
	 * 
	 * @PostMapping("insertChatRoomJson") public ResponseEntity<?>
	 * insertChatRoomJson(ChattingRoom ins) { return
	 * ResponseEntity.ok(service.insertChatRoom(ins)); }
	 * 
	 * 
	 * 
	 * // 채팅방 리스트 // http://localhost:2222/chatRoomListJson
	 * 
	 * @PostMapping("chatRoomListJson") public String chatRoomListJson(ChattingRoom
	 * sch,Model d) { d.addAttribute("chatRoomListJson", service.chatRoomList(sch));
	 * return "pageJsonReport"; }
	 * 
	 * 
	 * // 접속자 id
	 * 
	 * @GetMapping("getEmpnoByRoom") public String
	 * getEmpnoByRoom(@RequestParam("roomname")String roomname, Model d) {
	 * d.addAttribute("getEmpnoByRoom", service.getEmpnoByRoom(roomname)); return
	 * "pageJsonReport"; }
	 */
	
	
	
	/*
	 * @GetMapping("chatting") public String chatting() {
	 * 
	 * 
	 * return "a20_chatting"; }
	 * 
	 * // enterChRoom
	 * 
	 * @PostMapping("enterChRoom") public String enterChRoom(ChattingRoom croom,
	 * Model d) { d.addAttribute("result", service.insertChatRoom(croom));
	 * d.addAttribute("conIds", service.getUsersInChatRoom(croom.getChatuserid()));
	 * d.addAttribute("conRooms", service.chatRoomList());
	 * 
	 * return "pageJsonReport"; }
	 * 
	 * @GetMapping("conRooms") public String conRooms(Model d) {
	 * d.addAttribute("conRooms", service.chatRoomList());
	 * 
	 * return "pageJsonReport"; }
	 * 
	 * @GetMapping("conIds") public String conIds(@RequestParam("roomname") String
	 * roomname, Model d) { d.addAttribute("conIds",
	 * service.getEmpnoByRoom(roomname));
	 * 
	 * return "pageJsonReport"; }
	 * 
	 * @PostMapping("exitChRoom.do") public String delChatRoom(ChattingRoom croom,
	 * Model d) { d.addAttribute("result",
	 * service.delChatRoom(croom.getChatuserid())); return "pageJsonReport"; }
	 */
	
	
	@Value("${socketServer}")
	private String socketServer;
	
	// http://localhost:5050/chatting
	@GetMapping("chatting")
	public String chatting(Model d) {
		d.addAttribute("socketServer", socketServer);
		return "chatting";
	}
	
	@Autowired
	private WebService_chatting service;
	// enterChRoom
	@PostMapping("enterChRoom")
	public String enterChRoom(ChRoomInfo croom, Model d) {
		d.addAttribute("result", service.insChatRoom(croom));
		d.addAttribute("conIds", service.getChRoomIds(croom.getId()));
		d.addAttribute("conRooms", service.getChRooms());
		
		return "pageJsonReport";
	}
	@GetMapping("conRooms")
	public String conRooms(Model d) {
		d.addAttribute("conRooms", service.getChRooms());
		
		return "pageJsonReport";
	}	
	@GetMapping("conIds")
	public String conIds(@RequestParam("chroom") String chroom, Model d) {
		d.addAttribute("conIds", service.getIdsByRoom(chroom));
		
		return "pageJsonReport";
	}		
	@PostMapping("exitChRoom")	
	public String delChatRoom(ChRoomInfo croom, Model d) {
		d.addAttribute("result", service.delChatRoom(croom));
		return "pageJsonReport";
	}
	/*
	@GetMapping("ckIdDup")
	public String ckIdDup(@RequestParam("id") String id, Model d) {
		d.addAttribute("ckIdDup", service.getCurIds(id));
		
		return "pageJsonReport";
	}
	*/	
}