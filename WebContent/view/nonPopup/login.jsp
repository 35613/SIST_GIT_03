<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 
<head>
	<meta charset="UTF-8">
	<title>GROUPPL</title>
	<link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
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
		request.setCharacterEncoding("UTF-8");
	%>
	<%
		String errmsg = (String)request.getAttribute("errmsg");
	%>

	<%--상단바--%>
	<jsp:include page="/view/topmenu.jsp"></jsp:include>

	<%--컨텐츠--%>
	<div class="container bs-docs-container">
		<div class="row">

			<%--왼쪽부분--%>
			<div class="col-md-9" role="main">
				<img alt="" src="/view/image/main.jpg" width="100%" height="645px";>
			<!-- style="background-image:url(/view/image/main1.jpg);height:350px;width:100%;" -->
			<!-- 	<div class="bs-docs-section">

					<div class="panel panel-default">
						<div class="panel-body">
							<h1>GROUPPL 그룹 간 프로젝트와 일정을 관리하는 프로그램입니다.</h1>
						</div>
					</div>
				</div> -->
				
			</div>

			<%--오른쪽 부분--%>
			<div class="col-md-3" role="complementary">

				<div class="bs-docs-section">
					<form action="/controller/Login_Controller.jsp" method="post">
						<div class="form-group">
							<label for="email">이메일 주소</label>
							<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
						</div>
						<div class="form-group">
							<label for="password">암호</label>
							<input type="password" class="form-control" id="password" name="pw" placeholder="암호">
						</div>
						<%
							if (errmsg != null) {
						%>
							<div class="alert alert-danger" role="alert">
								<%=errmsg%>
							</div>
						<%
							}
						%>
						<button type="submit" class="btn btn-success btn-block" style="margin-bottom: 10px">로그인</button>
						<button type="button" class="btn btn-success btn-block" style="margin-bottom: 10px" onclick="signup()">회원가입</button>
					</form>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	function signup() {
        location.href = "/view/nonPopup/signup.jsp";
    }
</script>
	
	
</body>
</html>