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
	public List<Normal_Board_Dto> NormalBoard() throws DataAccessException {
		return annointer.Normal_Board_Vew_List();
	}
	
	@Override
	public boolean NormalInsert(Normal_Board_Bean bean) throws DataAccessException {
		boolean okCheck = annointer.Normal_Board_Insert(bean);
		return okCheck;
	}
	@Override
	public Normal_Board_Dto SelectNormalBoard(String no) throws DataAccessException {
		Normal_Board_Dto bean = (Normal_Board_Dto) annointer.Normal_Board_View_Select(no);
		System.out.println("dao 작동");
		System.out.println("Context는  "+bean.getN_context());
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
}