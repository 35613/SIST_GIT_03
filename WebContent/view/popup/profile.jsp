<%@page import="bean.ProjectBean"%>
<%@page import="bean.TagBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>멤버정보보기</title>

	<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
	<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="/view/JS/bootstrap.min.js"></script>

</head>

<body>

	<%
		UserBean userBean = new UserBean();
		userBean = (UserBean) request.getAttribute("userBean");

		ArrayList<TagBean> taglist = new ArrayList<TagBean>();
		taglist = (ArrayList<TagBean>) request.getAttribute("taglist");

		ArrayList<ProjectBean> projectlist = new ArrayList<ProjectBean>();
		projectlist = (ArrayList<ProjectBean>) request.getAttribute("projectlist");

		//아이콘 넣을이미지
		String imgurl = "/upload/" + userBean.getImage();
	%>

	<div class="panel panel-default">
		<%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center">개인프로필</div>


		<div class="panel-body">

			<%--이름--%>
			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">이름</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=userBean.getUsername() %></div>
			</div>
			
			<%--닉네임--%>
			<div>
				<span class="glyphicon glyphicon-user" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">닉네임</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=userBean.getNickname() %></div>
			</div>

			<%--이메일--%>
			<div>
				<span class="glyphicon glyphicon-envelope" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">이메일</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=userBean.getEmail() %></div>
			</div>

			<%--홈페이지--%>
			<div>
				<span class="glyphicon glyphicon-home" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">홈페이지</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=userBean.getWeb() %></div>
			</div>

			<%--특기--%>

			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">기술</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body">
				<%
                	for (int i = 0; i < taglist.size(); i++) {
                %>
                		<button type="button" class="btn btn-default btn-xs" style="margin-bottom: 3px; margin-top: 3px"><%=taglist.get(i).getTagname()%></button>
                <%
                	}
                %>
				</div>
			</div>

			<%--과거경력--%>

			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">과거경력</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body">
				<% 
					for (int i=0; i< projectlist.size(); i++){
				%>
						<a class="btn btn-link"><%= projectlist.get(i).getProjectname() %></a>
				<% 
					}
				%>
				</div>
			</div>
			<%--<div style="text-align: center">--%>
				<%--<button type="button" class="btn btn-success" id="btnConfirm">확인</button>--%>
			<%--</div>--%>
		</div>
	</div>


	<script type="text/javascript">
//		$('#btnConfirm').click(function () {
//            $("#dialogdiv").load("/controller/User_Info_Controller.jsp?email=TEST2@NAVER.COM").dialog("close");
//           console.log($("#dialogdiv")[0]);
//        });
	</script>
</body>
</html>