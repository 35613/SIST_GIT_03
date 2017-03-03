<%@page import="java.util.ArrayList"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.MembersDAO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.ProjectScheduleBean"%>
<%@page import="dao.ScheduleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>


<%
	UserBean userBean = (UserBean) session.getAttribute("userBean");
	ScheduleDAO dao = ScheduleDAO.getInstance();
	ProjectScheduleBean bean = new ProjectScheduleBean();
	 String reason = request.getParameter("reason");
	String command = request.getParameter("command");
	int seq = Integer.parseInt(request.getParameter("projectseq").trim());
	

	if (command != null) {

		if (command.equals("save")) {
			bean.setTitle(request.getParameter("title"));
			bean.setReason(request.getParameter("reason"));
			bean.setDodate(request.getParameter("dodate"));
			bean.setDoperson(request.getParameter("doperson"));
			bean.setWriter(userBean.getEmail());
			bean.setProject_seq(seq);
			dao.do_insert_projectschedule(bean);

			
			%>
			<script type="text/javascript">
				window.opener.location.reload();
				window.open('','_parent','');window.close();
			</script>
			<%

		}
	} else { 

		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");

		MembersDAO memdao = MembersDAO.getInstance();
		ArrayList<UserBean> userlist = memdao.do_search(seq);

		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("day", day);
		request.setAttribute("project_seq", bean.getProject_seq());
		request.setAttribute("userlist", userlist);

		pageContext.forward("/view/popup/project_schedulewrite.jsp");
	} 

%>


