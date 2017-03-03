<%@page import="dao.ProjectDAO"%>
<%@ page import="bean.UserBean"%>
<%@ page import="bean.ProjectBean"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.MembersDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%

	int seq = Integer.parseInt(request.getParameter("projectseq"));

	//    유저 정보를 세션에서 가져옴
	UserBean userBean = new UserBean();
	userBean = (UserBean) session.getAttribute("userBean");
	request.setAttribute("userBean", userBean);

	// 프로젝트 정보 가져오기
	ProjectDAO dao = ProjectDAO.getInstance();
	ProjectBean bean = dao.do_search(seq); // 누를때 보내줘야함
	request.setAttribute("bean",bean);

	MembersDAO membersDAO = MembersDAO.getInstance();
	ArrayList<UserBean> userlist = membersDAO.do_search(seq);
	request.setAttribute("userlist", userlist);
	
	pageContext.forward("/view/popup/projectintro.jsp");
%>









