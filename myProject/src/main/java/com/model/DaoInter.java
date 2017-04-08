package com.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface DaoInter {
	List<Normal_Board_Dto> NormalBoard()throws DataAccessException;
	Normal_Board_Dto SelectNormalBoard(String no)throws DataAccessException;
	
	boolean NormalInsert(Normal_Board_Bean bean)throws DataAccessException;
	boolean NormalUpdate(Normal_Board_Bean bean)throws DataAccessException;
	boolean NormalDelete(String no)throws DataAccessException;
	
	
}