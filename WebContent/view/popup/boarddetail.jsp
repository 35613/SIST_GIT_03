<%@page import="bean.FileBean"%>
<%@page import="dao.FileDAO"%>
<%@page import="bean.BoardCommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width: 500px; height: 600px;">


	<%
		 // 데이터 넣어주는 부분
		String imgurl = "/view/image/profile.jpg";
	/*String writer = "이인재";
		String projectname = "프로젝트1";
		String commentwriter = "마성익";
		String commentwriterimg = "/view/image/profile.jpg"; */
		
		FileDAO filedao = FileDAO.getInstance();
		
		
		BoardBean boardBean= (BoardBean)request.getAttribute("boardBean");
		ArrayList<BoardCommentBean> comentlist  = (ArrayList<BoardCommentBean>)request.getAttribute("comentlist");
		
		int seq = boardBean.getPost_seq();
		FileBean filebean = filedao.do_search_file(seq);
	%>


	<div class="panel panel-default">
		<%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center">프로젝트글보기  <%=boardBean.getWriter() %></div>

		<%--판넬 바디 부분--%>
		<div class="panel-body">

			<%--내용--%>
			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">내용</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px"><%=boardBean.getContentss() %>
				<br>
				<img src="/upload/<%=filebean.getStored_file_name()%>" width="50%" height="50%" id=<%if(filebean.getOriginal_file_name()!=null)out.print("img");%> style="display:none;" hidden="hidden">
				<div class="panel-body"></div>
			</div>


			<%--첨부파일 부분--%>
			<div>
				<span class="glyphicon glyphicon-paperclip" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">첨부파일</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body">
					<div class="form-group">
					<a href="filedown.jsp?postseq=<%=seq %>" id=<%if(filebean.getOriginal_file_name()!=null)out.print("down");%> style="display:none;" hidden="hidden"><%=filebean.getOriginal_file_name()%></a>
						<%--파일을 다운받는 부분이 들어가야함--%>
						
					</div>
				</div>
			</div>

			

			<%--반복문 돌릴 구간--%>
			<%--댓글읽기--%>
			<div>
				<span class="glyphicon glyphicon-pushpin" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">댓글읽기</a>
			</div>
			<div class="panel panel-default" width="50" height="30"
				style="margin-left: 40px; margin-bottom: 30px">
				
				<% for(int i = 0; i<comentlist.size(); i++){ %>
				<p class="bg-info" style="background-color: "><%=comentlist.get(i).getWriternickname() %> :  <%=comentlist.get(i).getContentss() %>
				</p>
				
				<%} %>
				
				<div class="panel-body"></div>
			</div>
		</div>
			<%--댓글쓰기 부분--%>
		<div>
			<span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span> <a
				class="panel-title" style="margin-left: 10px; margin-bottom: 5px">댓글쓰기</a>
		</div>
		
		<div class="panel-body">
			<form action="/controller/Board_Detail_Controller.jsp" method="post">
				<input type="hidden" name="boardseq" value="<%=boardBean.getPost_seq()%>">
				<input type="hidden" name="command" value="댓글쓰기">
				<textarea style="margin-left: 40px;" rows="-10" cols="39" name="comment" placeholder="댓글쓰기"></textarea>
				<div style="text-align: right;">
					<input type="submit" class="btn btn-default btn-xs" style="margin-bottom: 3px; margin-top: 3px"  value="올리기">
				</div>
			</form>
		</div>
		
	</div>
<script type="text/javascript">
	$("#down").show()
	$("#img").show();



</script>

</body>
</html>