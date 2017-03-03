<%@page import="bean.InvitationBean"%>
<%@page import="bean.ApplicationBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MessageDAO"%>
<%@ page import="bean.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!Doctype html>
<html>
<head>
    <title>Title</title>
    <style>
        /*.navbar-fixed-top {*/
        /*background-color: #4fc0c4*/
        /*}*/
    </style>
</head>
<body>

<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);
    if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>

<%
    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");


    String nickname = "";
    String userImg = "";
    String root = "/upload/";
    int applicationsize = 0;
    int invitationsize = 0;

    if (userBean != null) {
    	nickname = userBean.getNickname();
        MessageDAO messageDAO = MessageDAO.getInstance();
        invitationsize = messageDAO.do_search_invitation(userBean.getEmail()).size();
        applicationsize = messageDAO.do_search_application(userBean.getEmail()).size();
        userImg = root + userBean.getImage();
        System.out.println(userImg);
    }

%>

<%--상단바--%>
<nav class="navbar navbar-default navbar-fixed-top ">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <img src="/view/image/logo/logo.png" alt="" width="150" height="50" class="btn" <% if (userBean != null) { %> onclick="location.href='/view/nonPopup/projectboard.jsp'" <% } %> >

        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <%
                    // 로그인 했을 때만 projects page, 일정페이지 보여줌
                    if (userBean != null) {
                %>
                <li style="font-size: 20px; "><a href="/controller/Project_Page_Controller.jsp">Projects</a></li>
                <li style="font-size: 20px;"><a href="/controller/User_Schedule_Controller.jsp" >Schedule</a></li>
                <%
                    }
                %>
                <li style="font-size: 20px;"><a href="/view/nonPopup/about.jsp">About</a></li>
            </ul>
            <%
                // 로그인 했을 때만 드롭다운 보여줌
                if (userBean != null) {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                        <% if (!userImg.equals("") && !userImg.equals("/upload/없음")) { %> <img src="<%=userImg%>" alt="" width="30" height="30" class="img-rounded"> <%--이미지 있을 시 이미지 사용--%>
                        <% } else { %> <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <% } %>                    <%--이미지 없을 시 아이콘 사용--%>
                        <%=nickname%>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="/controller/Invitation_Message_Controller.jsp">초대가 <strong><%=invitationsize%></strong>건 있습니다.</a></li>
                        <li><a href="/controller/Application_Message_Controller.jsp">지원이 <strong><%=applicationsize%></strong>건 있습니다.</a></li>
                        <li class="divider"></li>
                        <li><a href="/view/nonPopup/profileedit.jsp">회원정보 수정</a></li>
                        <li><a href="/controller/Logout_Controller.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </div>
</nav>

</body>
</html>
