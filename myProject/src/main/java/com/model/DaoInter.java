package com.model;

import java.util.List;


import org.springframework.dao.DataAccessException;

public interface DaoInter {
	User_Dto SignIn(String id)throws DataAccessException;
	String SignUpIdCheck(String id)throws DataAccessException;
	String SignUpEmailCheck(String email)throws DataAccessException;
	
	List<Normal_Board_Dto> NormalBoard(String pageNo)throws DataAccessException;
	int Normal_Search_No_Count(String n_no)throws DataAccessException;
	int Normal_Search_Title_Count(String title, String re)throws DataAccessException;
	List<Normal_Board_Dto> Normal_Search_No(String n_no) throws DataAccessException;
	List<Normal_Board_Dto> Normal_Search_Title(String title, String re, int no) throws DataAccessException;
	Normal_Board_Dto SelectNormalBoard(String no)throws DataAccessException;
	
	boolean NormalInsert(Normal_Board_Bean bean)throws DataAccessException;
	boolean NormalUpdate(Normal_Board_Bean bean)throws DataAccessException;
	boolean NormalDelete(String no)throws DataAccessException;
	
	String NormalCount()throws DataAccessException;	
	boolean SignUpOk(String id, String pwd, String email, String date)throws DataAccessException;
}
