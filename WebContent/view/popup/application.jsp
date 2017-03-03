<%@page import="dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ApplicationBean"%>
<%@page import="bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
	<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width: 500px; height: 600px;">

	<%
		// 데이터 받는부분
		UserBean userBean = new UserBean();
		userBean = (UserBean)request.getAttribute("userBean"); 

		ApplicationBean applicationBean = (ApplicationBean)request.getAttribute("appuserbean");
		
		String sendemail = applicationBean.getSendid();
		
		String root = "/upload/";
	    String imgurl = root + applicationBean.getSendimage();
		
	%>


	<div class="panel panel-default">
		<%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center"><h4><b>지원서보기</b></h4></div>

		<%--판넬 바디 부분--%>
		<div class="panel-body">

		<%--유저 닉네임부분 --%>
		
			<table>
			<col width="0"><col width="100">
			<tr><td>
			<div>
				<% if (!imgurl.equals("") && !imgurl.equals("/upload/없음")) { %> <img src="<%=imgurl%>" alt="" width="30" height="30" class="img-rounded"> <%--이미지 있을 시 이미지 사용--%>
                <% } else { %> <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <% } %>                    <%--이미지 없을 시 아이콘 사용--%>
				<%-- <a	class="panel-title" style="margin-left: 200px; margin-bottom: 5px" href=""><%= userBean.getNickname()%></a>--%>
				<button type="button" class="btn btn-link" style="margin-left: 20px"
					onclick="clickemail(<%=applicationBean.getEmail()%>)"></button>
			</div>
			</td>
			<td align="left">
			<div class="panel panel-default"
						style=" margin-bottom: 30px" >
						<div class="panel-body" style="width: 330px"><%=applicationBean.getSendid() %></div>
					</div>
			</td>
			</tr>
			</table>
			<div>
					<a class="panel-title" style="margin-left: 10px; margin-bottom: 5px"></a>
			</div>
			<div class="panel panel-default"
						style=" margin-bottom: 30px" >
						<div class="panel-body"><%=applicationBean.getProjectname() %></div>
					</div>
			

				<div class="panel panel-default"
						style=" margin-bottom: 30px" >
						<div class="panel-body"><%=applicationBean.getApply_date() %></div>
					</div>
			<%--메시지--%>

			<div class="panel panel-primary" style="margin-top: 50px">
				<div class="panel-body"><%=applicationBean.getContentss() %></div>

			</div>

			<div class="form-inline" style="text-align: center">
				<form action="/controller/Application_Info_Controller.jsp">
					<input type="hidden" name="command" value="수락">
					<input type="hidden" name="seq" value="<%=applicationBean.getAppl_seq()%>">
					<button type="submit" class="btn btn-success" style="width: 150px">수 락</button>
				</form>
				
				<form action="/controller/Application_Info_Controller.jsp">
					<input type="hidden" name="command" value="거부" >
					<input type="hidden" name="seq" value="<%=applicationBean.getAppl_seq()%>">
					<button type="submit" class="btn btn-success" style="width: 150px;margin-top: 5px">거 부</button>
				</form>
			</div>


		</div>

	</div>

	<script type="text/javascript">
	function clickemail(email) {
		location.href = "/controller/profileController.JSP?email=" + email;
	}

	function close(command) {
        window.open('','_parent','');window.close();
    }
</script>


</body>
</html>