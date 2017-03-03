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

	<style type="text/css">
	.center {
		margin: auto;
		width: 60%;
		border: 3px solid #4cc007;
		padding: 10px;
	}
	</style>


</head> 


<body>
	<%
		String userImg = "../image/profile.jpg";
	%>
		<%
		String errmsg = request.getParameter("errmsg");
	 	if (errmsg != null) {
			if (errmsg.equals("loginfail"))
				errmsg = "이메일과 이름,비밀번호를 확인해 주세요.";
		} 
	%>


<%--상단바--%>
<jsp:include page="/view/topmenu.jsp"></jsp:include>


<%--컨텐츠--%>
	<div class="container bs-docs-container">
		<div class="row">
			<div class="col-md-9" role="main">
				<div class="bs-docs-section">

					<div class="panel panel-default">
						<div class="panel-body">
							<h1>GROUPPL 그룹 간 프로젝트와 일정을 관리하는 프로그램입니다.</h1>
						</div>
					</div>
				</div> 
			</div>

<%--오른쪽 부분--%>
			<div class="col-md-3" role="complementary">

				<div class="bs-docs-section">
					<form action="../../controller/Signup_Controller.jsp" method="post">
						<div class="form-group">
							<label for="exampleInputEmail1">이메일 주소</label>
							<div class="form-inline">
								<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" style="width: 65%">
								<button type="button" class="btn btn-success" id="checkbtn">중복체크</button>
							</div>
						</div>	
						<div class="form-group">
							<label for="exampleInputName">이름</label>
							<input type="text" class="form-control" id="name" name="username" placeholder="이름">
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">암호</label>  
							<input type="password" class="form-control" id="password"  name="password" placeholder="암호">
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
						
						<button type="submit"  class="btn btn-success btn-block" style="margin-bottom: 10px">입력</button>
						<button type="button" onclick="cancle()"  class="btn btn-success btn-block" style="margin-bottom: 10px">취소</button>
					</form>
				</div>
			</div>
		</div>
	</div>

<%--중복체크--%>

<script type="text/javascript">
$(function(){
	$("#checkbtn").click(function(){
		$.ajax({
			type:"post",
			url:"/controller/Signup_Overlapcheck.jsp",	//이동할 컨트롤 페이지	
			data:{
				"email":$('#email').val() 
			},
			success:function(data){		
				 if($.trim(data) == "YES"){
					alert($('#email').val() + '사용 가능 아이디입니다.');
				}else{
					alert($('#email').val() + '사용 불가 아이디입니다.');
				} 
			}
		});
		
	});	
});
</script>

<script type="text/javascript">
	function cancle() {
        location.href = "/controller/First_Page_Controller.jsp";
    }
</script>



</body>
</html>