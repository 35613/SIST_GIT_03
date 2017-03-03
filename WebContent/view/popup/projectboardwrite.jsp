<%@page import="bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>프로젝트글쓰기</title>
    <link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
    <link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width:500px; height:600px;">

<%
	UserBean userBean = new UserBean();
	userBean = (UserBean)session.getAttribute("userBean");
    // 데이터 넣어주는 부분
    String root = "/upload/";
    String userImg = root + userBean.getImage();
    System.out.println(userImg);
    String writer = userBean.getNickname();
    String seq = request.getParameter("projectseq");
    String projectname = request.getParameter("projectname");
%>

<div class="panel panel-default">
    <%--판넬 헤드 부분--%>
    <div class="panel-heading">
        <% if (!userImg.equals("") && !userImg.equals("/upload/없음")) { %> <img src="<%=userImg%>" alt="" width="30" height="30" class="img-rounded"> <%--이미지 있을 시 이미지 사용--%>
        <% } else { %> <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <% } %>                    <%--이미지 없을 시 아이콘 사용--%>
        <a href="#" style="margin-right: 25%"><%=writer%></a>
        
        <a href="#" class="panel-title"><%=projectname%></a>
    </div>
     
     <%--판넬 바디 부분--%>
     
    <div class="panel-body">
     <form action="/controller/Board_Write_Controller.jsp" method="post" enctype="multipart/form-data">
        <!-- //작성자 세션에서 가져옴 -->
        <input type="hidden" name="writer" value=<%=writer%>>
        <input type="hidden" name="projectseq" value=<%=request.getParameter("projectseq")%>>
        <!-- //제목 -->
      <!--   <div>
            <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">제목</a>
        </div>
        <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
            <div class="panel-body">
				<input type="text" size="53" name="title">
            </div>
        </div> -->
       <!--  //컨텐츠 -->
        
        <div>
            <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">내용</a>
        </div>
        <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
            <div class="panel-body">
            <textarea rows="10" cols="54" name="content"></textarea>
            </div>
        </div>

		 
		<!-- //파일 -->

        <div>
        	<span class="glyphicon glyphicon-paperclip" aria-hidden="true" ></span>
            <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">파일 업로드</a>
        </div>
        <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
            <div class="panel-body">
                <input type="file" name="uploadFile">
            </div>
        </div>

     
        <div style="text-align:right;">
        <input type="submit" value="올리기" > 
	   		</div>
	   	
	   		</form>
	   	</div>
	   </div>
     	

</body>
</html>