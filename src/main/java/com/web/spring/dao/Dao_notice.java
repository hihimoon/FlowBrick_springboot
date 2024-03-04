package com.web.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.spring.vo.Notice;
import com.web.spring.vo.NoticeFile;
import com.web.spring.vo.NoticeSch;

@Mapper
public interface Dao_notice {
	
	// 리스트 가져오기
	int totNotice(NoticeSch sch);
	
	List<Notice> noticeList(NoticeSch sch);
	
	// 등록
	int insertNotice(Notice ins);
	
	@Insert("INSERT INTO noticefile values(notice_seq.currval,\r\n"
			+ "#{fname},#{path},sysdate,sysdate,#{etc})")
	int insertNoticeFile(NoticeFile ins);

	// 상세보기
	@Select("select * from notice where no=#{no}")
	Notice getNotice(@Param("no") int no);
	
	@Select("SELECT fname FROM noticefile WHERE NO = #{no}")
	List<String> getNoticeFile(int no);

	@Select("SELECT * FROM noticefile WHERE NO = #{no}")
	List<NoticeFile> getNoticeFiles(int no);
	
	// 조회수증가
	@Update("update notice set readcnt = readcnt+1 where no=#{no}")
	void readCntUptNotice(@Param("no") int no);
	
	// 수정 처리
	int updateNotice(Notice upt);
	
	// 파일 수정처리
	@Insert("INSERT INTO noticefile values(#{no},\r\n"
			+ "#{fname},#{path},sysdate,sysdate,#{etc})")
	int UpdateNoticeFile(NoticeFile upt);

	// 파일만 삭제 처리
	@Delete("DELETE FROM NOTICEFILE WHERE NO = #{no} AND FNAME = #{fname}")
	int deleteFile(NoticeFile del);
	
	// 삭제 처리
	@Delete("DELETE FROM notice WHERE NO = #{no}")
	int deleteNotice(@Param("no") int no);
	
	int deleteNoticeFile(@Param("no") int no);
}
