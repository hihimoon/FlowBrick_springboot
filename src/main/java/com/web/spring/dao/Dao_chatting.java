package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.spring.vo.DeptSch;
import com.web.spring.vo.ChRoomInfo;
import com.web.spring.vo.ChattingRoom;
import com.web.spring.vo.Dept;
import com.web.spring.vo.Emp;
import com.web.spring.vo.EmpInfo;
import com.web.spring.vo.EmpSch;

@Mapper
public interface Dao_chatting {

	/*
	 * // 채팅 사원 리스트 List<Emp> chatEmpList(Emp sch);
	 * 
	 * // 채팅방 생성 int insertChatRoom(ChattingRoom ins);
	 * 
	 * 
	 * // 채팅방 리스트 출력 List<String> chatRoomList(ChattingRoom sch);
	 * 
	 * List<String> chatRoomList();
	 * 
	 * // 접속자 id 리스트 출력 List<String> getEmpnoByRoom(String roomname);
	 * 
	 * // 특정 사용자가 속한 채팅방의 모든 사용자 리스트 출력 List<String> getUsersInChatRoom(String
	 * chatuserid);
	 * 
	 * // 채팅방 나가기 int delChatRoom(String chatuserid);
	 */

	/*
	 * @Insert("INSERT INTO chroominfo values(#{chRoom},#{id})") int
	 * insChatRoom(ChRoomInfo ins);
	 * 
	 * @Delete("Delete from chroominfo where  id=#{id}") int
	 * delChatRoom(@Param("id") String delId);
	 * 
	 * @Select("	SELECT DISTINCT chroom\r\n" + "	FROM CHROOMINFO") List<String>
	 * getChRooms();
	 * 
	 * @Select("	SELECT id\r\n" + "	FROM CHROOMINFO\r\n" +
	 * "	WHERE chroom = (\r\n" + "		SELECT chroom\r\n" +
	 * "		FROM CHROOMINFO\r\n" + "		WHERE id=#{id}	\r\n" + "	)")
	 * List<String> getChRoomIds(@Param("id") String id);
	 * 
	 * @Select("	SELECT id\r\n" + "	FROM CHROOMINFO\r\n" +
	 * "	WHERE chroom = #{chroom} \r\n") List<String>
	 * getIdsByRoom(@Param("chroom") String chroom);
	 */
}
