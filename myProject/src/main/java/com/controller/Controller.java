package com.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.model.DaoInter;
import com.model.Normal_Board_Bean;
import com.model.Normal_Board_Dto;
import com.model.User_Dto;

@org.springframework.stereotype.Controller
public class Controller {
	@Autowired
	private DaoInter daointer;

	@ResponseBody
	@RequestMapping(value = "normal_count", method = RequestMethod.GET)
	public Map<String, String> Normal_Count(@RequestParam("pageNo") String pageNo) {
		String count = daointer.NormalCount();

		int maxPageNum = 0;

		if (Integer.parseInt(count) != 0) {
			Double ss = Math.ceil(Double.parseDouble(count) / 3);
			maxPageNum = ss.intValue();
		} else {
			maxPageNum = 0;
		}

		Map<String, String> data = new HashMap<String, String>();
		data.put("maxPageNum", Integer.toString(maxPageNum));
		data.put("count", count);
		return data;
	}

	@ResponseBody
	@RequestMapping(value = "normal", method = RequestMethod.GET)
	public Map<String, Object> head(@RequestParam("pageNo") String pageNo) {
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		Map<String, String> data = null;

		String count = daointer.NormalCount();
		String no = Integer.toString(((Integer.parseInt(pageNo) - 1) * 3));

		List<Normal_Board_Dto> boardList = daointer.NormalBoard(no);

		for (Normal_Board_Dto s : boardList) {

			data = new HashMap<String, String>();
			data.put("n_writer", s.getN_writer());
			data.put("n_title", s.getN_title());
			data.put("n_context", s.getN_context());
			data.put("n_no", s.getN_no());

			dataList.add(data);
		}

		dataList.get(0).put("n_count", count);

		int maxPageNum = 0;

		if (Integer.parseInt(count) != 0) {
			Double ss = Math.ceil(Double.parseDouble(count) / 3);
			maxPageNum = ss.intValue();
		} else {
			maxPageNum = 0;
		}
		
		dataList.get(0).put("maxPageNum", Integer.toString(maxPageNum));

		Map<String, Object> jsonData = new HashMap<String, Object>();
		jsonData.put("datas", dataList);

		return jsonData;
	}

	@RequestMapping(value = "insertOk", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertOk(@RequestParam("writer") String writer, @RequestParam("title") String title,
			@RequestParam("context") String context) {
														
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

	@RequestMapping(value = "selectNormal", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> selectNormal(@RequestParam("n_no") String no) {
		Map<String, String> data = new HashMap<String, String>();
		Normal_Board_Dto dto = daointer.SelectNormalBoard(no);

		data.put("n_no", dto.getN_no());
		data.put("n_title", dto.getN_title());
		data.put("n_context", dto.getN_context());
		data.put("n_writer", dto.getN_writer());

		// Map<String, Object> jsonData = new HashMap<String, Object>();
		// jsonData.put("data", data);
		return data;
	}

	@RequestMapping(value = "updateOk", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateOk(@RequestParam("n_no") String no, @RequestParam("title") String title,
			@RequestParam("writer") String writer, @RequestParam("context") String context) {
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
		} else {
			state = "UpdateCheckNo";
		}
		Map<String, String> data = new HashMap<String, String>();
		data.put("state", state);
		return data;
	}

	@RequestMapping("deleteGo")
	@ResponseBody
	public Map<String, String> deleteGo(@RequestParam("n_no") String n_no) {
		Map<String, String> data = new HashMap<String, String>();
		boolean yn = daointer.NormalDelete(n_no);
		String state;
		if (yn) {
			state = "DeleteOk";
		} else {
			state = "DeleteNo";
		}
		data.put("state", state);
		return data;
	}
	
	@RequestMapping("searchGo")
	@ResponseBody
	public Map<String, Object> searchTest(){
		System.out.println("search Test : ");
		List<Normal_Board_Dto> list = daointer.NormalSearch("n_title", "안");
		System.out.println(" 됬낭? " + list.size());
		System.out.println(list.get(0).getN_context());
		// 검색 목록이랑  //  검색값 받고 넘기기 작업
		return null;
	}
	
	@RequestMapping("search")
	@ResponseBody
	public Map<String, Object> search(@RequestParam("searchValue1") String searchValue1,
			@RequestParam("searchValue2") String searchValue2){
		System.out.println(searchValue1);
		System.out.println(searchValue2);
		List<Normal_Board_Dto> list = daointer.Search(searchValue1, searchValue2);
		
		System.out.println("search Test : " + list.size());
		return null;
	}
	
	
	public void sessionTest(){
		System.out.println("aaa");
		HttpSession session = null;
		session.setAttribute("id", "hi");
		System.out.println("bbb");
		String hi = (String) session.getAttribute("id");
		System.out.println(hi);
		System.out.println("ccc");
	}
	
	@RequestMapping("sessionTest")
	protected void doGet(HttpServletRequest requset, HttpServletResponse response) throws ServletException,IOException{
		HttpSession session = requset.getSession();
		session.setAttribute("id", "userName");
		System.out.println(session.getAttribute("id"));
	}

	@RequestMapping("signUpCheck")
	@ResponseBody
	public Map<String, Object> signUpIdCheck(@RequestParam("id")String id,
			@RequestParam("email")String email){
		Map<String, Object> state = new HashMap<String, Object>();
		System.out.println("signUpCheck 확인");
		String idCheck = "";
		String emailCheck = "";
		
		String aa = daointer.SignUpIdCheck(id);
		System.out.println(aa);
		if(Integer.parseInt(aa) == 0){
			idCheck = "SignUpIdCheckOk";
		}else{
			idCheck = "SignUpIdCheckNo";
		}
		
		aa = daointer.SignUpEmailCheck(email);
		System.out.println(aa);
		if (Integer.parseInt(aa) == 0) {
			System.out.println("okok");
			emailCheck = "SignUpEmailCheckOk";
		}else{
			System.out.println("nono");
			emailCheck = "SignUpEmailCheckNo";
		}
		state.put("idCheck", idCheck);
		state.put("emailCheck", emailCheck);
		System.out.println("작업중");
		return state; // 작업중
	}
	
	@RequestMapping("signUpOk")
	@ResponseBody
	public Map<String, String> signUpOk(@RequestParam("id")String id, @RequestParam("pwd")String pwd, @RequestParam("email") String email){
		Calendar cal = Calendar.getInstance();
		System.out.println(cal.get(Calendar.YEAR));
		System.out.println(cal.get(Calendar.MONTH)+1);
		System.out.println(cal.get(Calendar.DAY_OF_MONTH));
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = Integer.toString(cal.get(Calendar.MONTH)+1);
		String day = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
		String hour = Integer.toString(cal.get(Calendar.HOUR));
		String min = Integer.toString(cal.get(Calendar.MINUTE));
		String sec = Integer.toString(cal.get(Calendar.SECOND));
		String date = year + "-" + month + "-" + day + "/" + hour + ":" + min + ":" + sec;
		System.out.println(date);
		
		boolean a = daointer.SignUpOk(id, pwd, email, date);
		String dd = null;
		if (a) {
			dd = "signUpOk";
		}else{
			dd = "signUpNo";
		}
		Map<String, String> data = new HashMap<String, String>();
		data.put("state", dd);
		return data;
	}
	
	@RequestMapping("SignIn")
	@ResponseBody
	public Map<String, String> signIn(@RequestParam("id")String id, @RequestParam("pwd")String pwd,
			HttpSession session){
		boolean ddd = session.isNew();
		System.out.println(ddd);
		//User_Dto dto = daointer.SignIn(id);
		String state = null;
		String dd = daointer.SignUpIdCheck(id);
		if (Integer.parseInt(dd) == 1) {
			User_Dto dto = daointer.SignIn(id);
			String pwdc= dto.getUser_password();
			System.out.println("pwdc : " + pwdc + "//" + "pwd : " + pwd );
			if (pwdc.equals(pwd)) {
				state = "sign up ok";
				session.setAttribute("id", id);
			}else{
				System.out.println("pwdc : " + pwdc + "//" + "pwd : " + pwd );
				state = "pwd invalid";
			}
		}else{
			state = "id invalid";
		}
		Map<String, String> data = new HashMap<String, String>();
		data.put("state", state);
		return data;
	}
	
	@RequestMapping("loginCheck")
	@ResponseBody
	public Map<String, String> LoginCheck(HttpSession session){
		Map<String, String> data = new HashMap<String, String>();
		Object ad = session.getAttribute("id");
		String adc = (String)ad;
		System.out.println(adc + " :ccccc");
		if (adc == null || adc == "") {
			data.put("state", "logout");
			System.out.println("logout");
		}else{
			data.put("state", "login");
			System.out.println("login");
		}
		System.out.println("fffff");
		return data;
	}
	
	@RequestMapping(value = "/logOut.do", method = RequestMethod.GET)
	public ModelAndView LogOut(HttpSession session){
		System.out.println("logOut err???");
		session.notifyAll();
		ModelAndView view = new ModelAndView();
		view.setViewName("../../demo");
		//view.setViewName("signUpView");
		return view;
	}
}
