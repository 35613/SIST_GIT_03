<%@page import="bean.UserBean"%>
<%@page import="bean.UserScheduleBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>개인일정쓰기</title>
    <link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
    <link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width:500px; height:600px;">
<%! 
	public String two(String msg) { // 한자리를 두자리로 만들어 주는 함수
	return msg.trim().length() < 2 ? "0" + msg : msg.trim();
} 
%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%
    // 데이터 넣어주는 부분
    String imgurl = "/view/image/profile.jpg";

UserBean userBean = new UserBean();
userBean = (UserBean)session.getAttribute("userBean");
	
	String year = two(request.getParameter("year"));
	String month = two(request.getParameter("month"));
	String day = two(request.getParameter("day"));
	
%>

<div class="panel panel-default">
		<%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center">개인스케쥴만들기</div>
		
     
     <%--판넬 바디 부분--%>
    <div class="panel-body">
        <%--제목--%>
        	<form action="/controller/User_Schedule_Write_Controller.jsp">
        	<input type="hidden" name="command" value="만들기">
				<div class="form-group">
					<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <label
						for="exampleInputEmail1">제목</label> <input type="text"
						class="form-control" id="exampleInputname" placeholder="제목을 입력하세요"
						name="title">
				</div>
				
				

       	<%--내용--%>
				<div class="form-group">
					<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <label
						for="exampleInputcontents">내용</label>
					<textarea rows="10" cols="64" placeholder="내용을입력하세요" name="reason"></textarea>
				</div>


       <%--날짜--%>
				<div class="form-group">
					<span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> <label
						for="exampleInputdate">날짜</label>
					<div class="panel-body" style="text-align: right;">
						<input type="date" min="2017-02-18" max="2025-01-31" name="dodate" value="<%=year%>-<%=month %>-<%=day %>"><br>
					</div>
				</div>
       
       <%--공개 여부 --%>
        <div class="form-group">
        <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <label
						for="exampleInputdate">공개여부</label>
        <div>
        <input type="radio" name="publicrange" value="전체공개" <%if(userBean.getPublicrange().equalsIgnoreCase("전체공개"))out.print("checked"); %> >전체공개
 		<input type="radio" name="publicrange" value="비공개" <%if(userBean.getPublicrange().equalsIgnoreCase("비공개"))out.print("checked"); %> > 비공개
 		<input type="radio" name="publicrange" value="그룹공개"<%if(userBean.getPublicrange().equalsIgnoreCase("그룹공개"))out.print("checked"); %> >그룹공개			
        </div>  
        <div style="text-align:right;">
        <input type="submit" value="만들기" >  &nbsp;&nbsp;&nbsp;
        <input type="button" value="취소" onclick="window.close()">
	   		</div>
	   		
	   	</div>
	   	 </form>
	   	</div>
	 </div>
</body>
</html>