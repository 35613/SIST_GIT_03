<%@page import="java.util.ArrayList"%>
<%@page import="bean.ProjectCommentBean"%>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.ScheduleDAO" %>
<%@ page import="bean.ProjectScheduleBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

    
<%
    request.setCharacterEncoding("UTF-8");
%>

<%
	UserBean userBean =(UserBean) session.getAttribute("userBean");
    int seq = Integer.parseInt(request.getParameter("pjseq"));
    String comment = request.getParameter("comment");
	String command = request.getParameter("command");
    ScheduleDAO dao = ScheduleDAO.getInstance();

    if (command != null) {
		if (command.equals("댓글쓰기")) {
			ProjectCommentBean projectCommentBean = new ProjectCommentBean();
			projectCommentBean.setSchedule_seq(seq);
			projectCommentBean.setWriter(userBean.getEmail());
			projectCommentBean.setContentss(comment);
			
			dao.do_insert_projectcomment(projectCommentBean);

		}
	}

    ArrayList<ProjectCommentBean> commentlist = dao.do_search_projectcomment(seq);
    ProjectScheduleBean projectScheduleBean = dao.do_search_project_detail(seq);
    
    request.setAttribute("projectScheduleBean", projectScheduleBean);
    request.setAttribute("commentlist", commentlist);

    pageContext.forward("/view/popup/project_scheduledetail.jsp");



%>