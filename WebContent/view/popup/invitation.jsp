<%@page import="bean.TagBean"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.InvitationBean"%>
<%@page import="bean.ProjectBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>초대장</title>

	<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
	<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
	<link rel="stylesheet" href="/view/CSS/send.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/view/JS/bootstrap.min.js"></script>

</head>

<body style="width:500px; height:600px;">

<%
    request.setCharacterEncoding("UTF-8");
%>

<%
	String imgurl = "/view/image/profile.jpg";

	InvitationBean bean = (InvitationBean) request.getAttribute("bean");
	ProjectBean projectbean= (ProjectBean) request.getAttribute("projectbean");
    ArrayList<UserBean> memberlist = (ArrayList<UserBean>)request.getAttribute("memberlist");
    ArrayList<String> taglist = (ArrayList<String>)request.getAttribute("taglist");
    
	
	
%>
	
	<div class="panel panel-default">
		<%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center">초대장</div>
	
	
	  <%--판넬 바디 부분--%>
    <div class="panel-body">
		<%--프로젝트명--%>
		<div>
			<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
			<a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">프로젝트명</a>
		</div>
		<div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
			<%=bean.getProjectname() %>
			<div class="panel-body"></div>
		</div>

		<%--소개--%>
		<div>
			<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
			<a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">소개</a>
		</div>
		<div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
			<%=projectbean.getReadme() %>
			<div class="panel-body"></div>
		</div>

		<%--기간--%>
		<div>
			<span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span>
			 <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">기간</a>
		</div>
		<div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
			<%=projectbean.getStartdate() %> ~ <%=projectbean.getEnddate() %>
			<div class="panel-body"></div>
		</div>

		<%--개발환경--%>
		<div>
			<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
			<a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">개발환경</a>
		</div>
		<div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
			<% for(int i = 0; i<taglist.size(); i++) {%>
			<input type="button" value="<%=taglist.get(i) %>">
			<%} %>
			<div class="panel-body"></div>
		</div>

		<%--개발인원--%>
		<div>
			<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
			<a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">개발인원</a>
		</div>
		<div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
			<%=memberlist.size() %>명
			<div class="panel-body"></div>
		</div>

		<%--수락 / 거부--%>
		<div class="form-inline" style="text-align: center">
			<form action="/controller/Invitaion_Info_Controller.jsp">
				<input type="hidden" name="command" value="수락">
				<input type="hidden" name="seq" value="<%=bean.getInvite_seq()%>">
				<button type="submit" class="btn btn-success" style="width: 180px">수 락</button>
			</form>

			<form action="/controller/Invitaion_Info_Controller.jsp">
				<input type="hidden" name="command" value="거부">
				<input type="hidden" name="seq" value="<%=bean.getInvite_seq()%>">
				<button type="submit" class="btn btn-success" style="width: 180px">거 부</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>