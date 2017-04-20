package com.controller;


import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.model.DaoInter;
import com.model.Normal_Board_Bean;
import com.model.Normal_Board_Dto;

@org.springframework.stereotype.Controller
public class Controller {
	@Autowired
	private DaoInter daointer;
	
	@ResponseBody
	@RequestMapping(value="normal_count", method=RequestMethod.GET)
	public Map<String,String> Normal_Count(@RequestParam("pageNo") String pageNo){
		String count = daointer.NormalCount();
		
		int maxPageNum = 0;
		
		if(Integer.parseInt(count) != 0){ 
			Double ss = Math.ceil(Double.parseDouble(count)/3);  
			maxPageNum = ss.intValue();
		}else{
			maxPageNum = 0;
		}
		
		
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("maxPageNum", Integer.toString(maxPageNum));
		data.put("count", count);
		return data;
	}
	
	@ResponseBody
	@RequestMapping(value="normal", method=RequestMethod.GET)
	public Map<String, Object> head(@RequestParam("pageNo") String pageNo){
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> data = null;
		
		
		
	    String no = Integer.toString(((Integer.parseInt(pageNo)-1)* 3));
	    
		List<Normal_Board_Dto> boardList = daointer.NormalBoard(no);
		for(Normal_Board_Dto s : boardList){
			data = new HashMap<String, String>();
			data.put("n_writer", s.getN_writer());
			data.put("n_title", s.getN_title());
			data.put("n_context", s.getN_context());
			data.put("n_no", s.getN_no());
			
			dataList.add(data);
		}
		
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		jsonData.put("datas", dataList);
		
		return jsonData;
	}
	
	@RequestMapping(value="insertOk", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertOk(@RequestParam("writer") String writer
			,@RequestParam("title") String title
			,@RequestParam("context") String context
			){// title  context 받아야함 jquery
		Normal_Board_Bean bean = new Normal_Board_Bean();
		bean.setTitle(title);
		bean.setWriter(writer);
		bean.setContext(context);
		boolean af = daointer.NormalInsert(bean);
		System.out.println(af);
		Map<String, Object> stateData = new HashMap<String, Object>();
		String state = "1";
		stateData.put("state", state);
		
		return stateData;

	}
	
	@RequestMapping(value="selectNormal", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, String> selectNormal(@RequestParam("n_no") String no){
		Map<String, String> data = new HashMap<String, String>();
		Normal_Board_Dto dto = daointer.SelectNormalBoard(no);
		
		data.put("n_no", dto.getN_no());
		data.put("n_title", dto.getN_title());
		data.put("n_context", dto.getN_context());
		data.put("n_writer", dto.getN_writer());
			
//		Map<String, Object> jsonData = new HashMap<String, Object>();
//		jsonData.put("data", data);
		return data;
	}
	
	@RequestMapping(value="updateOk", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateOk(@RequestParam("n_no") String no,
			@RequestParam("title") String title,
			@RequestParam("writer") String writer,
			@RequestParam("context") String context
			){
		Normal_Board_Bean bean = new Normal_Board_Bean();
		bean.setNo(no);
		bean.setTitle(title);
		bean.setContext(context);
		bean.setWriter(writer);
		
		System.out.println(bean.getContext());
		
		boolean yn = daointer.NormalUpdate(bean);
		String state;
		if (yn) {
			state = "UpdateCheckOk";
		}else{
			state = "UpdateCheckNo";
		}
		Map<String, String> data = new HashMap<String, String>();
		data.put("state", state);
		return data;
	}
	
	@RequestMapping("deleteGo")
	@ResponseBody
	public Map<String, String> deleteGo(@RequestParam("n_no") String n_no){
		Map<String, String> data = new HashMap<String, String>();
		boolean yn = daointer.NormalDelete(n_no);
		String state;
		if (yn) {
			state = "DeleteOk";
		}else{
			state = "DeleteNo";
		}
		data.put("state", state);
		return data;
	}
	
	
	
}
