package com.model;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface AnnoInter {
	
	@Select("select * from user_list where user_name = #{id};")
	public User_Dto User_Sign_In(String id);
	@Select("select * from normal_board order by n_no desc limit #{pageNo},3")
	public List<Normal_Board_Dto> Normal_Board_Vew_List(String pageNo);
	
	@Select("select n_no, n_title, n_writer, n_context from normal_board where n_no = #{no}")
	
	public Normal_Board_Dto Normal_Board_View_Select(String no);
	
	@Insert("insert into normal_board(n_title, n_writer, n_context) values (#{title},#{writer},#{context})")
	public boolean Normal_Board_Insert(Normal_Board_Bean bean);
	
	@Update("update normal_board set n_title=#{title}, n_writer = #{writer}, n_context=#{context} where n_no= #{no}")
	public boolean Normal_Board_Update(Normal_Board_Bean bean);
	
	@Delete("delete from normal_board where n_no = #{no}")
	public boolean Normal_Board_Delete(String no);
	
	@Select("select count(*) from normal_board")
	public String Normal_Board_Count();
	
	@Select("select * from normal_board where ${title} like '%${re}%'")
	public List<Normal_Board_Dto> Normal_Search_Title(@Param("title")String title,@Param("re") String re); // 검색 만드는중
	
	@Select("select * from normal_board where n_no = 1")
	public Normal_Board_Dto Normal_Search_no(String search);
	
	@Select("select count(user_name) from user_list where user_name = #{id}")
	public String SignUpIdCheck(String id);
	
	@Select("select count(user_email) from user_list where user_email = #{email}")
	public String SignUpEmailCheck(String email);
	
	@Insert("insert into user_list (user_name, user_password, user_email, user_sign_date) values (#{id},#{pwd},#{email},#{date})")
	public boolean signUpOk(@Param("id")String id,@Param("pwd")String pwd, @Param("email")String email, @Param("date")String date);
}
