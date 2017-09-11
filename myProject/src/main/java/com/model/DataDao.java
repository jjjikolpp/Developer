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
	public List<Normal_Board_Dto> Search(String searchValue1, String searchValue2) throws DataAccessException {
		// TODO Auto-generated method stub
		return annointer.Normal_Search_Title(searchValue1, searchValue2);
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

	@Override
	public List<Normal_Board_Dto> NormalSearch(String title, String re) throws DataAccessException {
		List<Normal_Board_Dto> list = annointer.Normal_Search_Title(title, re);
		return list;
	}

}
