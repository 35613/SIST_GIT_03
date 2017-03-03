<%@page import="bean.ProjectBean"%>
<%@page import="dao.MembersDAO"%>
<%@page import="bean.TagBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TagDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%


	//view가 받아야할 정보들을 다오의 메소드들을 이용해서 만들어서 보내준다.
	String email = request.getParameter("email");
//	String email = "TEST2@NAVER.COM";
	
	UserDAO userDAO = UserDAO.getInstance();
	
	UserBean userBean = new UserBean();
	userBean = userDAO.do_search_user(email);
	request.setAttribute("userBean", userBean);
	
	TagDAO tagDAO = TagDAO.getInstance();
	
	ArrayList<TagBean> taglist = new ArrayList<TagBean>();
	taglist = tagDAO.do_search(email);
	request.setAttribute("taglist", taglist);
	
	MembersDAO membersDAO = MembersDAO.getInstance();
	
	ArrayList<ProjectBean> projectlist = new ArrayList<ProjectBean>();
	projectlist = membersDAO.do_search_joinproject(email);
	request.setAttribute("projectlist", projectlist);

	pageContext.forward("/view/popup/profile.jsp");
%>
	
 
	
<!-- 	
dao 3개 부르고 userbean하나랑 list 두개를 profile,jsp view로 보내준다
setattribute로 보내준다
 -->

