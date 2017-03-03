<%@page import="bean.InvitationBean"%>
<%@page import="dao.MessageDAO"%>
<%@page import="dao.MembersDAO"%>
<%@page import="bean.ApplicationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%> 

<%
	
	String email = request.getParameter("inviter");
	int projectseq = Integer.parseInt(request.getParameter("project_seq"));
	
	InvitationBean invitationBean = new InvitationBean();
	invitationBean.setProject_seq(projectseq);
	invitationBean.setEmail(email);

	MessageDAO messageDAO = MessageDAO.getInstance();
	messageDAO.do_upsert_invitation(invitationBean);


%>

<script>
    window.open('about:blank','_self').self.close();
//    window.open('about:blank','_parent').parent.close();
</script>