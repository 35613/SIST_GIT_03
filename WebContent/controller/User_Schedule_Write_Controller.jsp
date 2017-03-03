<%@page import="dao.ScheduleDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.UserScheduleBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
		UserBean userBean = new UserBean();
		userBean = (UserBean) session.getAttribute("userBean");
		request.setAttribute("userBean", userBean);

	UserScheduleBean bean = new UserScheduleBean();

	bean.setTitle(request.getParameter("title"));
	bean.setReason(request.getParameter("reason"));
	bean.setDodate(request.getParameter("dodate"));
	bean.setPublicrange(request.getParameter("publicrange"));
	bean.setEmail(userBean.getEmail());
	
	
	ScheduleDAO dao = ScheduleDAO.getInstance();
	if(dao.do_insert_userschedule(bean)){
		System.out.println("성공!");
		%>
		<script type="text/javascript">
			window.opener.location.reload();
			window.open('','_parent','');window.close();
		</script>
		<%
	}else {
		System.out.println("앙실패띠!");
//		response.sendRedirect("/controller/User_Schedule_Controller.jsp");
	}

	
%>