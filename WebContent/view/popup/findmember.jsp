<%@page import="dao.TagDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버구하기</title>
	<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
	<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/view/JS/bootstrap.min.js"></script>
	
<body style="width: 500px; height: 600px;">

	<%
		request.setCharacterEncoding("UTF-8");
	%>

	<%
		ArrayList<UserBean> userlist = new ArrayList<UserBean>();
		UserBean userBean = new UserBean();

		int projectseq = Integer.parseInt((String)request.getAttribute("projectseq"));
	
		userlist = (ArrayList<UserBean>)request.getAttribute("userlist");
		userBean = (UserBean)session.getAttribute("userBean");
	
		ArrayList<String> taglist = new ArrayList<String>();
		TagDAO tagDAO = TagDAO.getInstance();
  		taglist = tagDAO.do_search_tag();
  		
	%>

	<%--검색준비--%>
	<!-- 전체보기 버튼 클릭 시 파인드컨트롤로 이동 -->
	<div class="btn-group" role="group" aria-label="..."
		style="margin-bottom: 10px">
		<button type="button" class="btn btn-default" id="allsearch"
			name="searchbutton" value="<%=projectseq%>">전체보기</button>
		<button type="button" class="btn btn-default" id="namesearch"
			name="searchbutton">닉네임으로 검색</button>
		<button type="button" class="btn btn-default" id="tagsearch"
			name="searchbutton">태그명으로 검색</button>
	</div>

	<%--검색패널--%>
	<!-- 닉네임으로 검색 -->
	<form action="/controller/Find_Member_Controller.jsp">
		<input type="hidden" name="command" value="이름">
		<input type="hidden" name="projectseq" value="<%=projectseq%>">
		<div class="panel panel-default" id="namepanel" hidden="hidden">
			<div class="panel-body">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search for..." name="srch">
					<span class="input-group-btn" >
						<button class="btn btn-default" type="submit">검색</button>
					</span>
				</div>
			</div>
		</div>
	</form>
	
	<%--태그패널--%>
	<form action="/controller/Find_Member_Controller.jsp">
		<input type="hidden" name="command" value="태그">
		<input type="hidden" name="projectseq" value="<%=projectseq%>">
		<div class="panel panel-default" id="tagpanel" hidden="hidden">
			<div class="panel-body">
				<%
					for (int i = 0; i < taglist.size(); i++) {
				%>
						<input name="usertag" type="checkbox"
							style="margin-bottom: 3px; margin-top: 3px" value="<%=taglist.get(i)%>"><%=taglist.get(i)%>
				<%
					}
				%>
				<button class="btn btn-info" type="submit" style="float: right;">검색하기</button>
			</div>
		</div>
	</form>
	
	<!-- userlist가 null이면 유저정보 안 띄움 -->
	
	<% if(userlist != null ){ 
	
	
		for(int i = 0 ; i < userlist.size(); i++ ){
		
			System.out.println("userlist:" + userlist.get(i).getEmail());
		}
	%>

	<%--검색 유저의 목록--%>
	<%
		for (int i = 0; i < userlist.size(); i++) {
			String imgUrl = userlist.get(i).getImage();
			String nickname = userlist.get(i).getNickname();
	%>

			<%--유저이미지 --%>
			<div class="panel panel-default">
				<div class="form-inline">
					<div id="dialog-form" title="초대하기">
					<%--초대버튼--%>
						<form action="/controller/Invitation_Add_Controller.jsp" method="post" id="frm" class="form-inline" style="text-align: center;">
							<input type="hidden" name="inviter" value="<%=userlist.get(i).getEmail()%>">
							<input type="hidden" name="project_seq" value="<%=projectseq%>">
							<span class="glyphicon glyphicon-user" aria-hidden="true" ></span>
							<a onclick="window.open('/controller/User_Info_Controller.jsp?email=<%=userlist.get(i).getEmail() %>', 'USERPOP', 'width=500 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')"><%=nickname%></a>
							<input type="submit" value="초대하기" onclick="invite()" class="btn btn-success">
						</form>
					</div>
				</div>
			</div>
	<%
		}
	}
	%>
	
	<%--<!-- 닉네임으로 검색 버튼 클릭 -->--%>
	<%--<%  if(userBean != null ){ %>--%>

	<%--&lt;%&ndash;검색 유저의 목록&ndash;%&gt;--%>
	<%--<%--%>
	<%----%>
			<%--String imgUrl = userBean.getImage();--%>
			<%--String email = userBean.getEmail();--%>
			<%--String nickname = userBean.getNickname();--%>
	<%--%>--%>


	<%--<div class="panel panel-default">--%>
		<%--<div>--%>
			<%--&lt;%&ndash;유저이미지 &ndash;%&gt;--%>
			<%--<img src="<%=imgUrl%>" alt="" width="30" height="30">--%>
		<%--</div>--%>
		<%--<div>--%>
			<%--<a href="#"><%=nickname%></a>--%>
		<%--</div>--%>
			<%--<form action="Invitaion_Add_Controller.jsp" method="post">--%>
				<%--<input type="hidden" name="inviter" value="<%=userBean.getEmail()%>">--%>
				<%--<input type="submit" value="초대하기" class="btn btn-success btn-block">--%>
			<%--</form>--%>
		<%--</div>--%>
	<%--</div>--%>


	<%--<%--%>
		<%--}--%>
	<%--%>--%>

<script type="text/javascript">

 function invite(){
		alert("초대가 완료되었습니다.");
}
</script>

<!-- 전체보기 버튼 클릭시 이동 -->
 <script type="text/javascript">
$(function(){
	$("#allsearch").click(function(){
	   var form = $('<form></form>');
		form.attr('action', "/controller/Find_Member_Controller.jsp");
		form.attr('method', 'post');
		form.appendTo('body');
		var memcom = $("<input type='hidden' name='command'>");
		memcom.val('allsearch');
        var pjseq = $("<input type='hidden' name='projectseq'>");
        pjseq.val($(this).val());
		form.append(memcom);
		form.append(pjseq);
		form.submit();
	});	
});
</script> 

<script type="text/javascript">
	$(document).ready(function() {
		$("#allsearch").click(function() {
			$("#tagpanel").hide();
			$("#namepanel").hide();
		});
		$("#namesearch").click(function() {
			$("#tagpanel").hide();
			$("#namepanel").show();
		});
		$("#tagsearch").click(function() {
			$("#namepanel").hide();
			$("#tagpanel").show();
		});
	});
</script>

</body>
</html>