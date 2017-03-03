<%@page import="bean.InvitationBean"%>
<%@page import="java.util.ArrayList"%>
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
        body { padding-top: 70px; }
    </style>
</head>
<body>
<%
   
    String userImg = "/view/image/profile.jpg";
    ArrayList<InvitationBean> invitationlist = (ArrayList<InvitationBean>)request.getAttribute("invitationlist");
    
%>
<%--상단바--%>
<jsp:include page="/view/topmenu.jsp"></jsp:include>

<div class="container bs-docs-container">
    <div class="row">
        <div class="col-md-9" role="main">
            <div class="bs-docs-section">

                <%--셀렉트--%>
                <div align="right" style="margin-bottom: 10px">
                    <div class="btn-group" role="group" aria-label="...">
                        <button type="button" class="btn btn-default active" id="bu1" >받은 초대장</button>
                        <button type="button" class="btn btn-default" id="bu2" onclick="location.href='/controller/Application_Message_Controller.jsp'">받은 지원서</button>
                    </div>
                </div>

                <%--뉴스피드--%>

                <%

                    for (int i = 0; i < invitationlist.size(); i++) {
                %><a onclick="window.open('/controller/Invitaion_Info_Controller.jsp?seq=<%=invitationlist.get(i).getInvite_seq() %>', 'applicationPopup', 'width=550, height=600, toolbar=no, menubar=no, location=no, channelmode=no')">
                <div class="panel panel-info" style="margin-bottom: 30px">
                    <div class="panel-heading"><%=invitationlist.get(i).getProjectname() %>에서 당신을 초대합니다.</div>
                    <div class="panel-body"><h4>시간<%=invitationlist.get(i).getInvite_date() %> </h4></div>
                </div></a>
                <%
                    }
                %>

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
    flag = false;
    window.onload = function(){
        var b = document.getElementById(".panel panel-info");
        document.getElementById("#bu1").onclick = function(){
            if(flag == false){
                b.style.display = "block";
                flag = true;
            }
            else{
                b.style.display = "none";
                flag = false;
            }
        };
    }
</script>

</body>
</html>