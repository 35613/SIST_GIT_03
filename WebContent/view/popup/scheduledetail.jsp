<%@page import="bean.UserCommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.UserScheduleBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인일정읽기</title>
<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width: 500px; height: 600px;">

	<%
		UserScheduleBean userScheduleBean = (UserScheduleBean) request.getAttribute("userScheduleBean");
		ArrayList<UserCommentBean> commentlist = (ArrayList<UserCommentBean>) request.getAttribute("commentlist");
		System.out.println(commentlist);

		// 데이터 넣어주는 부분
		String imgurl = "/view/image/profile.jpg";
	%>

	<div class="panel panel-default">
		
		<%--판넬 헤드 부분--%>
		<div class="panel-heading" style="text-align: center">개인스케쥴보기</div>

		<%--판넬 바디 부분--%>
		
		<div class="panel-body">
			<%--제목--%>
			<form action="/controller/User_Schedule_Detail_Controller.jsp" id="myform" name="myform">
			<input type="hidden" name="myseq" value="<%=userScheduleBean.getMyschedule_seq()%>">
			
			
			<div>
				<span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>제목
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body">
				<input type="text" name="title" size="50" placeholder="<%=userScheduleBean.getTitle()%>" >  
				</div>

			</div>

			<%--날짜--%>

			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">날짜</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body" style="text-align: right;">
				<input type="date" name="dodate" placeholder="<%=userScheduleBean.getDodate()%>" ></div>

			</div>

			<%--사유--%>
			<div>
				<span class="glyphicon glyphicon-ok" aria-hidden="true" ></span> <a
					class="panel-title" style="margin-left: 10px; margin-bottom: 5px">사유</a>
			</div>

			<div class="panel panel-default"
				style="margin-left: 40px; margin-bottom: 30px">
				<div class="panel-body">
				<input type="text" name="reason" size="50" placeholder="
				<%=userScheduleBean.getReason()%>" ></div>
			</div>
			</form>

	
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
					<div class="panel panel-default"><%=commentlist.get(i).getWriternickname()%>
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
					<form action="/controller/User_Schedule_Detail_Controller.jsp"
						method="post">
						<input type="hidden" name="myseq"
							value="<%=userScheduleBean.getMyschedule_seq()%>"> <input
							type="hidden" name="command" value="댓글쓰기">
						<textarea rows="-10" cols="50" name="comment" placeholder="댓글쓰기"></textarea>

						<div style="text-align: right;">
							<input type="submit" class="btn btn-default btn-xs"
								style="margin-bottom: 3px; margin-top: 3px" value="올리기">

						</div>
					</form>
				</div>
			</div>


			<div style="text-align: right;">
			
					<button onclick=button(0)>수정</button>
					<button onclick=button(1)>삭제</button>
					<button onclick=button(2)>닫기</button>
			
			</div>
		</div>
		
<script type="text/javascript">

function button(num) {
	if (num == 0) {
		$("#myform").append("<input type='hidden' name='command' value='update'>");
		//document.getElementById("myform").action="/controller/User_Schedule_Detail_Controller.jsp?command=update";
		document.myform.submit()
	} else if (num == 1) {
		$("#myform").append("<input type='hidden' name='command' value='delete'>");
		document.myform.submit()
	} else if (num == 2) {
		window.close();
	}
	
}


</script>
		

</body>
</html>