<%@ page import="bean.UserBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트만들기</title>
<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width: 500px; height: 600px;">

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	UserBean userBean = new UserBean();
	userBean = (UserBean)session.getAttribute("userBean");

	String imgurl = "/view/image/profile.jpg";
%>

	<div class="panel panel-default">
		<div class="panel panel-default">
			<%--판넬 헤드 부분--%>
			<div class="panel-heading" style="text-align: center">프로젝트 생성</div>

			<%--판넬 바디 부분--%>

			<div class="panel-body">
				<form action="/controller/Project_Create_Controller.jsp">
					<input type="hidden" name="leader" value="<%=userBean.getEmail()%>">
					<div>
						<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
							class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Projectname</a>
					</div>
					<div class="panel panel-default"
						style="margin-left: 40px; margin-bottom: 30px">
						<div class="panel-body">
							<input type="text" name="title" size="50" placeholder="프로젝트명">
						</div>
					</div>

					<div>
						<span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> <a
							class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Startdate</a>
					</div>
					<div class="panel panel-default"
						style="margin-left: 40px; margin-bottom: 30px">
						<div class="panel-body" style="text-align: right;">
							<input type="date" min="2017-02-18" max="2025-01-31" name="startdate"><br>
						</div>
					</div>

					<div>
						<span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> <a
							class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Enddate</a>
					</div>
					<div class="panel panel-default"
						style="margin-left: 40px; margin-bottom: 30px">
						<div class="panel-body" style="text-align: right;">
							<input type="date" min="2017-02-18" max="2025-01-31" name="enddate"><br>
						</div>
					</div>

					<div>
						<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
							class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Projectintroduce</a>
					</div>
					<div class="panel panel-default"
						style="margin-left: 40px; margin-bottom: 30px">
						<div class="panel-body">
							<textarea rows="10" cols="50" name="readme"
								placeholder="소개를 작성해 보세요"></textarea>
						</div>
					</div>

					<div align="center">
						<button type="submit">저장하기</button>
						<button type="button" onclick="location.href='/controller/Project_Page_Controller.jsp'">돌아가기</button>
					</div>

				</form>

			</div>

		</div>
	</div>

</body>
</html>