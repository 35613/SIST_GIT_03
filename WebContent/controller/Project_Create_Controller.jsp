<%@page import="bean.ProjectBean"%>
<%@page import="dao.ProjectDAO"%>
<%@ page import="dao.MembersDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%
	UserBean userBean = new UserBean();
	userBean = (UserBean)session.getAttribute("userBean");

	ProjectDAO pjdao = ProjectDAO.getInstance();
	ProjectBean dto = new ProjectBean();


	dto.setProjectname(request.getParameter("title"));
	dto.setStartdate(request.getParameter("startdate"));
	dto.setEnddate(request.getParameter("enddate"));
	dto.setReadme(request.getParameter("readme"));
	dto.setLeader(request.getParameter("leader"));

boolean success =  pjdao.do_insert(dto);

if(success){
	System.out.println("성공");
	//어디로 갈지 링크 찍어주면끝
	MembersDAO membersDAO = MembersDAO.getInstance();
	int seq = membersDAO.do_search_projectseq();
	membersDAO.do_insert_member(seq, userBean.getEmail());

	ProjectBean projectBean = new ProjectBean();
	projectBean = pjdao.do_search(seq);

	ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
	userprojectlist = (ArrayList<ProjectBean>)session.getAttribute("userprojectlist");
	userprojectlist.add(projectBean);
	session.setAttribute("userprojectlist", userprojectlist);

	response.sendRedirect("/controller/Project_Page_Controller.jsp");
}else{
	System.out.println("실패");
	response.sendRedirect("/view/popup/projectcreate.jsp") ;
}




%>