<%@page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bean.TagBean"%>
<%@ page import="bean.ProjectBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GROUPPL</title>
	<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
	<link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="/view/JS/bootstrap.min.js"></script>
<style type="text/css">
body {
	padding-top: 70px;
}
</style>
</head>
<body>
	<%
		ArrayList<String> usertaglist = (ArrayList<String>)request.getAttribute("usertaglist");
		ArrayList<String> taglist = (ArrayList<String>)request.getAttribute("taglist");

		ProjectBean PJdto = (ProjectBean)request.getAttribute("PJdto");
				
	%>

	<%--상단바--%>
	<jsp:include page="../topmenu.jsp"></jsp:include>

	<%--컨텐츠--%>
	<div class="container bs-docs-container">
		<div class="row">

			<%--왼쪽부분--%>
			<div class="col-md-9" role="main">
				<div class="bs-docs-section">


					<div class="jumbotron">
						<h2 align="left">프로젝트 정보수정</h2>
						<hr>
						
						<form class="form-horizontal" id="myform">
							<input type="hidden" name="command" value="수정하기">
							<div class="form-group">
							
								<label class="col-sm-2 control-label">프로젝트명</label>
								<div class="col-sm-10">
									<input type="text" name="PROJECTNAME"  value="<%=PJdto.getProjectname()%>">
								</div>
							</div>
							<div class="form-group">
								<div class="panel panel-default">
									<div class="panel-heading">
										태그
									</div>
									<div class="panel-body">
										<table>
											<tr>
												<td>
													<%
														for (int i = 0; i < taglist.size(); i++) {
													 %>

													<% if(usertaglist == null ) {%>
														<input type="checkbox" name="projecttag" value="<%=taglist.get(i)%>"><%=taglist.get(i)%>
													<% } else {%>
														<input type="checkbox" name="projecttag" value="<%=taglist.get(i)%>"
															<%
																for (int j = 0; j < usertaglist.size(); j++) {
																	if(usertaglist.get(j).equalsIgnoreCase(taglist.get(i)))out.print("checked");
																}
															%>
															><%=taglist.get(i)%>
													<%} %>
													<%
														}
													%>
												</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">시작날짜</label>
								<div class="col-sm-10">
									<input type="date"
										value="<%=PJdto.getStartdate()%>" name="STARTDATE">
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">종료날짜</label>
								<div class="col-sm-10">
									<input type="date"
										value="<%=PJdto.getEnddate()%>" name="ENDDATE">
								</div>
							</div>



							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">진행도</label>
								<div class="col-sm-10">
									<input type="number" max="100" min="0" step="5"
										value=<%=PJdto.getProgress()%> name="PROGRESS">
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">프로젝트장</label>
								<div class="col-sm-10">
									<input type="text"
										value="<%=PJdto.getLeader()%>" name="LEADER" readonly="readonly">
								</div>
							</div>

							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">소개</label>
								<div class="col-sm-10">

									<textarea rows="10" cols="60" placeholder="소개" name="README"><%=PJdto.getReadme()%></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">가입여부</label>
								<div class="col-sm-10">
									<input type="radio" name="ISOPEN" value="Y" <%if(PJdto.getIsopen().equalsIgnoreCase("Y"))out.print("checked");%>  >가입가능
									<input type="radio" name="ISOPEN" value="N" <%if(PJdto.getIsopen().equalsIgnoreCase("N"))out.print("checked");%>  >가입불가
								</div>
							</div>
							
							
							
							<div align="center" >
								<button onclick="button(0)">저장</button> 
								<button onclick="button(1)">돌아가기</button> 
							</div>
						</form>
					</div>
				</div>
			</div>

			<%--오른쪽 부분--%>
			<div class="col-md-3" role="complementary">
				<nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">
					<jsp:include page="/view/rightmenu.jsp"></jsp:include>
				</nav>
			</div>


		</div>
	</div>


<script type="text/javascript">
function button(num) {
	if(num==0){
		 document.getElementById("myform").action="/controller/Project_Edit_Controller.jsp";
		
	}else if(num==1){
		document.getElementById("myform").action="/controller/Project_Controller.jsp?command=이동";
	}
	document.myform.submit();
}

</script>


</body>
</html>