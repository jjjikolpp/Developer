package com.model;

import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface Normal_Board_AnnoInter {
	
	@Select("select * from normal_board order by n_no desc limit 0,5")
	public List<Normal_Board_Dto> Normal_Board_Vew_List();
	
	@Select("select * from normal_board where n_no = 3")
	public List<Normal_Board_Bean> Normal_Board_View_Select();
}
