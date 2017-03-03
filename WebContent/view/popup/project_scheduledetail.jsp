<%@page import="bean.ProjectCommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="bean.ProjectScheduleBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>프로젝트일정읽기</title>
    <link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
    <link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width:500px; height:600px;">
 

<%
    // ProjectScheduleBean 가져옴
    ProjectScheduleBean projectScheduleBean = (ProjectScheduleBean)request.getAttribute("projectScheduleBean");

	ArrayList<ProjectCommentBean> commentlist = (ArrayList<ProjectCommentBean>) request.getAttribute("commentlist");
	System.out.println(commentlist);


    // 데이터 넣어주는 부분
    String imgurl = "/view/image/profile.jpg";
    String writer = "이인재";
    String projectname = "프로젝트1";
    String commentwriter = "마성익";
    String commentwriterimg = "/view/image/profile.jpg";

%>
<div class="panel panel-default">
    <%--판넬 헤드 부분--%>
   <%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center">프로젝트스케쥴보기</div>
     
     <%--판넬 바디 부분--%>
    <div class="panel-body">
       <%--제목--%>
			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">제목</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=projectScheduleBean.getTitle()%></div>

			</div>

         <%--내용--%>
			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">내용</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=projectScheduleBean.getReason()%></div>

			</div>
		<%--날짜--%>

			<div>
				<span class="glyphicon glyphicon-calendar" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">날짜</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=projectScheduleBean.getDodate()%></div>

			</div>

        <%--수행자--%>

			<div>
				<span class="glyphicon glyphicon-user" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">수행자</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=projectScheduleBean.getDoperson()%></div>

			</div>
          <%--진행도--%>

			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">진행도</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body"><%=projectScheduleBean.getProgress()%></div>

			</div>
			
			<%--버튼 --%>
                <div style="text-align:right">
	   				<!-- <button type="submit" class="btn btn-success btn-block" 
	   				style="margin-bottom: 10px; ">수행하기</button> -->
	   			</div>
	   			
	   		<%--반복문 돌릴 구간--%>
				<%--댓글읽기--%>
				<div>
					<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
						class="panel-title" style="margin-left: 10px; margin-bottom: 5px">댓글읽기</a>
				</div>
				<div class="panel panel-default" width="50" height="30"
					style="margin-left: 40px; margin-bottom: 30px">
					<%
						for (int i = 0; i < commentlist.size(); i++) {
					%>
					<div class="panel panel-default"><%=commentlist.get(i).getWriter()%>
						:
						<%=commentlist.get(i).getContentss()%>
					</div>

					<%
						}
					%>

				</div>

			</div>
			<%--댓글쓰기 부분--%>
			<div >
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">댓글쓰기</a>
			</div>
			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body">
					<form action="/controller/Project_Schedule_Detail_Controller.jsp"
						method="post">
						<input type="hidden" name="pjseq" value="<%=projectScheduleBean.getPjschedule_seq()%>"> <input
							type="hidden" name="command" value="댓글쓰기">
						<textarea rows="-10" cols="50" name="comment" ></textarea>

						<div style="text-align: right;">
							<input type="submit" class="btn btn-default btn-xs"
								style="margin-bottom: 3px; margin-top: 3px" value="올리기">
	
						</div>
					</form>
					<div style="text-align: center">
					<input type="button" value="닫기" onClick="window.close()">
					</div>
				</div>
			</div>
	   			
	   			
	   			
	   			
	   			
            </div>
        
       

     	


</body>
</html>