package com.model;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface AnnoInter {
	
	@Select("select * from normal_board order by n_no desc limit #{pageNo},3")
	public List<Normal_Board_Dto> Normal_Board_Vew_List(String pageNo);
	
	@Select("select n_no, n_title, n_writer, n_context from normal_board where n_no = #{no}")
	public Normal_Board_Dto Normal_Board_View_Select(String no);
	
	@Insert("insert into normal_board(n_title, n_writer, n_context) values (#{title},#{writer},#{context})")
	public boolean Normal_Board_Insert(Normal_Board_Bean bean);// 인서트 끝냄  .. 업데이트 및
	
	@Update("update normal_board set n_title=#{title}, n_writer = #{writer}, n_context=#{context} where n_no= #{no}")
	public boolean Normal_Board_Update(Normal_Board_Bean bean);
	
	@Delete("delete from normal_board where n_no = #{no}")
	public boolean Normal_Board_Delete(String no);
	
	@Select("select count(*) from normal_board")
	public String Normal_Board_Count();
	
	
}
