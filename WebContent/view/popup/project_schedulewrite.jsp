<%@page import="bean.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<title>프로젝트일정쓰기</title>
<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width: 500px; height: 600px;">
<%! 
	public String two(String msg) { // 한자리를 두자리로 만들어 주는 함수
	return msg.trim().length()<2?"0"+msg:msg.trim();
} 
%>
<%
    request.setCharacterEncoding("UTF-8");
%>
	
	
	<%
		// 데이터 넣어주는 부분
	String imgurl = "../image/profile.jpg";
	String year = two((String)request.getAttribute("year"));
	String month = two((String)request.getAttribute("month"));
	String day = two((String)request.getAttribute("day"));
	int seq = Integer.parseInt(request.getParameter("projectseq"));
	
	ArrayList<UserBean> userlist = (ArrayList<UserBean>)request.getAttribute("userlist");
	
		
		
	%>

	<div class="panel panel-default">
		<%--판넬 헤드 부분--%>
		<%--그룹장이 스케쥴작성 --%>
		<div class="panel-heading" style="text-align: center">프로젝트일정등록</div>

		<form action="/controller/Project_Schedule_Write_Controller.jsp">
		<input type="hidden" name="command" value="save">
		<input type="hidden" name="projectseq" value=" <%=seq %>">
			<div class="panel-body">

				<%--제목--%>
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
						<input type="date"  name="dodate" value="<%=year%>-<%=month %>-<%=day %>"><br>
					</div>
				</div>

				<%--수행자--%>
				<div class="form-group">
					<span class="glyphicon glyphicon-user" aria-hidden="true" ></span> <label
						for="exampleInputplayer">수행자</label> 
				<%--셀렉트--%>
                <div class="item" style="margin-bottom: 10px">
                    <select class="form-control" style="width: 20%" name="doperson" >
                        <option>그룹원</option>
                       <   <%
                            for (int i = 0; i < userlist.size(); i++) {
                        %>
                                <option value="<%=userlist.get(i).getEmail()%>"><%=userlist.get(i).getNickname()%></option>
                        <%
                            }
                        %>  
                    </select>
                </div>
				</div>

				<div style="text-align: right;">
					<input type="submit" value="등록">
					 &nbsp;&nbsp;&nbsp;
					 <input type="button" value="취소" onclick="window.close()">
				</div>
			</div>
		</form>

	</div>
</body>

</html>