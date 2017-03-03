<%@page import="dao.ScheduleDAO"%>
<%@page import="bean.ProjectScheduleBean"%>
<%@page import="bean.UserScheduleBean"%>
<%@ page import="bean.UserBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	//    유저 정보를 세션에서 가져옴
	UserBean userBean = new UserBean();
	userBean = (UserBean) session.getAttribute("userBean");
	request.setAttribute("userBean", userBean);

	//유져 일정 리스트
	ScheduleDAO dao = ScheduleDAO.getInstance();
	 ArrayList<UserScheduleBean> userslist = new ArrayList<>();
	userslist.addAll(dao.do_search_userschedule(userBean.getEmail()));
	request.setAttribute("userslist", userslist); 


	//가입한 프로젝트 일정 여러개 가입했을텐데 어쩌니
	 ArrayList<ProjectScheduleBean> projectlist = new ArrayList<>();
	projectlist.addAll(dao.do_search_all_projectschedule(userBean.getEmail()));
	request.setAttribute("projectlist", projectlist);
	
	pageContext.forward("/view/nonPopup/mycalendar.jsp");
%>









