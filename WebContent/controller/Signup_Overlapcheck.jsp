<%@ page import="dao.UserDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	
	System.out.println("email = " + email);
	
	UserDAO userDAO = UserDAO.getInstance();

	
	boolean flag = userDAO.do_search_id(email);
	
	System.out.println("flag = " + flag);
	
	if(flag){
		out.print("NO");	//이미 아이디 존재 함.
	}else{
		out.print("YES");
	}

%>