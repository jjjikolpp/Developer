package com.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class DataDao implements DaoInter {
	@Autowired
	private AnnoInter annointer;

	@Override
	public User_Dto SignIn(String id) throws DataAccessException {
		return annointer.User_Sign_In(id);
	}
	
	@Override
	public boolean SignUpOk(String id, String pwd, String email, String date) throws DataAccessException {
		return annointer.signUpOk(id, pwd, email, date);
	}

	@Override
	public String SignUpIdCheck(String id) throws DataAccessException {
		return annointer.SignUpIdCheck(id);
	}

	@Override
	public String SignUpEmailCheck(String email) throws DataAccessException {
		return annointer.SignUpEmailCheck(email);
	}

	@Override
	public List<Normal_Board_Dto> NormalBoard(String pageNo) throws DataAccessException {
		System.out.println(pageNo + " page No 는");
		return annointer.Normal_Board_Vew_List(pageNo);
	}
	
	@Override
	public int Normal_Search_No_Count(String n_no) throws DataAccessException {
		return annointer.Normal_Search_no_Count(n_no);
	}

	@Override
	public List<Normal_Board_Dto> Normal_Search_No(String n_no) throws DataAccessException {
		return annointer.Normal_Search_no(n_no);
	}
	
	@Override
	public int Normal_Search_Title_Count(String title, String re) throws DataAccessException {
		return annointer.Normal_Search_Title_Count(title, re);
	}
	
	@Override
	public List<Normal_Board_Dto> Normal_Search_Title(String title, String re , int no) throws DataAccessException {
		System.out.println(title + " : " + re);
		return annointer.Normal_Search_Title(title, re, no);
	}

	@Override
	public boolean NormalInsert(Normal_Board_Bean bean) throws DataAccessException {
		boolean okCheck = annointer.Normal_Board_Insert(bean);
		return okCheck;
	}

	@Override
	public Normal_Board_Dto SelectNormalBoard(String no) throws DataAccessException {
		Normal_Board_Dto bean = (Normal_Board_Dto) annointer.Normal_Board_View_Select(no);
		return bean;
	}

	@Override
	public boolean NormalUpdate(Normal_Board_Bean bean) throws DataAccessException {
		return annointer.Normal_Board_Update(bean);
	}

	@Override
	public boolean NormalDelete(String no) throws DataAccessException {

		return annointer.Normal_Board_Delete(no);
	}

	@Override
	public String NormalCount() throws DataAccessException {
		String count = annointer.Normal_Board_Count();
		return count;
	}

}
