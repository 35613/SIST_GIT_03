<%@page import="dao.MessageDAO"%>
<%@page import="dao.MembersDAO"%>
<%@page import="bean.ApplicationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%> 

<%
	String sendid = request.getParameter("sendemail");
	String sendimage = request.getParameter("sendimage");
	String email = request.getParameter("email");
	String contents = request.getParameter("contents");
	int projectseq = Integer.parseInt(request.getParameter("projectseq"));

	ApplicationBean applicationBean = new ApplicationBean();
	applicationBean.setProject_seq(projectseq);
	applicationBean.setContentss(contents);
	applicationBean.setEmail(email);
	applicationBean.setSendid(sendid);
	applicationBean.setSendimage(sendimage);

	MessageDAO messageDAO = MessageDAO.getInstance();
	messageDAO.do_upsert_application(applicationBean);


%>

<script>
    window.open('about:blank','_self').self.close();
//    window.open('about:blank','_parent').parent.close();
</script>