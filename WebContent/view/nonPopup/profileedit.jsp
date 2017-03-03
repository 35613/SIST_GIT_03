<%@page import="dao.TagDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.TagBean"%>
<%@page import="bean.UserBean"%>
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
#tdsize{
	width: 10%;
	text-align: center;
}
</style> 

</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		UserBean userbean = new UserBean();
		userbean = (UserBean)session.getAttribute("userBean");
		

	    TagDAO tagDAO = TagDAO.getInstance();
	    ArrayList<TagBean> usertaglist = new ArrayList<TagBean>();
	    		
	    usertaglist = tagDAO.do_search(userbean.getEmail());
	    
	  	ArrayList<String> taglist = new ArrayList<String>();
	  	taglist = tagDAO.do_search_tag();
	  	String userimg = "/upload/" + userbean.getImage();
	  	
	%>
	
<%--상단바--%>	
<jsp:include page="/view/topmenu.jsp"></jsp:include>

<%--컨텐츠--%>
	<div class="container bs-docs-container">
		<div class="row">

			<div class="col-md-9" role="main">
				<div class="bs-docs-section">

					<div class="table-responsive">
						<form action="/controller/Profile_Controller.jsp" method="post" enctype="multipart/form-data">
							<table class="table table table-bordered">
				
								<tr>
									<td id="tdsize">이메일</td>
									<td><input type="text" name="email" size="30" readonly="readonly" value="<%=userbean.getEmail()%>" ></td>
								</tr>
								<tr>
									<td id="tdsize">패스워드</td>
									<td><input type="password" name="password" size="30"  value="<%=userbean.getPw()%>" ></td>
								</tr>
								<tr>
									<td id="tdsize">닉네임</td>
									<td><input type="text" name="nickname" size="30"  value="<%=userbean.getNickname()%>" ></td>
								</tr>
								<tr>
									<td id="tdsize">이름</td>
									<td><input type="text" name="username" size="30"  value="<%=userbean.getUsername()%>" ></td>
								</tr>
								<tr>
									<td id="tdsize">전화번호</td>
									<td><input type="text" name="phone" size="30"  value="<%=userbean.getPhone()%>" ></td>
								</tr>
								<tr>
									<td id="tdsize">기술</td>
									<td>
									<%
                                		for (int i = 0; i < taglist.size(); i++) {
			                        %>

			                            	<% if(usertaglist == null ) {%>
			                            		<input type="checkbox" name="usertag" value="<%=taglist.get(i)%>"><%=taglist.get(i)%>
			                            	<% } else {%>
												<input type="checkbox" name="usertag" value="<%=taglist.get(i)%>"
													<%
														for (int j = 0; j < usertaglist.size(); j++) {
															if(usertaglist.get(j).getTagname().equalsIgnoreCase(taglist.get(i)))out.print("checked");
														}
													%>
													><%=taglist.get(i)%>  
											<%} %>
			                        <%
			                            }
			                        %>
		
 								    </td> 
								</tr>
								<tr>
									<td id="tdsize">주소</td>
									<td><input type="text" name="address" size="30" value="<%=userbean.getAddress()%>" ></td>
								</tr>
								<tr>
									<td id="tdsize">홈페이지</td>
									<td><input type="text" name="web" size="30"  value="<%=userbean.getWeb()%>" ></td>
								</tr>
								 <tr>
									<td id="tdsize">공개여부</td>	
									<td>			
										 <input type="radio" name="publicrange" value="전체공개" <%if(userbean.getPublicrange().equalsIgnoreCase("전체공개"))out.print("checked");%>  >전체공개
 										 <input type="radio" name="publicrange" value="비공개" <%if(userbean.getPublicrange().equalsIgnoreCase("비공개"))out.print("checked");%> >비공개
 										 <input type="radio" name="publicrange" value="그룹공개" <%if(userbean.getPublicrange().equalsIgnoreCase("그룹공개"))out.print("checked");%> >그룹공개										 
									</td>
								</tr>
								<tr>
									<td id="tdsize">초대여부</td>	
									<td>
										 <input type="radio" name="invite" value="Y" <%if(userbean.getInvite().equalsIgnoreCase("Y"))out.print("checked");%>  >공개
 										 <input type="radio" name="invite" value="N" <%if(userbean.getInvite().equalsIgnoreCase("N"))out.print("checked");%> >비공개
									</td>	
								</tr>
								<tr>
									<td id="tdsize">프로필사진</td>	
									<td>
										  <input type="file" name="uploadFile" id="uploadFile"  >
									</td>	
								</tr>
							</table>

							<input type="submit" value="정보수정"> &nbsp;&nbsp;&nbsp; 
							<input type="button" value="취소" onclick="location.href='/view/nonPopup/projectboard.jsp'">
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
			
</body>
</html>