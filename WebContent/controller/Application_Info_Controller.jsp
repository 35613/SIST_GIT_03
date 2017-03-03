<%@page import="dao.MessageDAO"%>
<%@page import="dao.MembersDAO"%>
<%@page import="bean.ApplicationBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%> 

<%
String command = request.getParameter("command");
MessageDAO dao = MessageDAO.getInstance();
int seq = Integer.parseInt(request.getParameter("seq"));
ApplicationBean appuserbean = dao.do_search_detail_application(seq);

if (command != null) {
	if (command.equals("수락")) {
		ApplicationBean bean = new ApplicationBean();
		bean.setAppl_seq(seq);
		dao.do_update_application(bean);

		MembersDAO memdao = MembersDAO.getInstance();
		memdao.do_insert_member(appuserbean.getProject_seq(), appuserbean.getSendid());


		
	} else if (command.equals("거부")) {
		//이름으로 검색된 프로젝트만 가져오기
		ApplicationBean bean = new ApplicationBean();
		bean.setAppl_seq(seq);
		dao.do_update_application(bean);

	}


%>

<script type="text/javascript">
    window.opener.location.reload();
    window.open('','_parent','');window.close();
</script>

<%
} else {
	//view가 받아야할 정보들을 다오의 메소드들을 이용해서 만들어서 보내준다.
	request.setAttribute("appuserbean", appuserbean);

	pageContext.forward("/view/popup/application.jsp");
}
%>