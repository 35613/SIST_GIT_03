<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
<%@ page import="bean.UserBean" %>
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
<%
    String result = (String)request.getAttribute("result");
%>

<body onload="leave_result(<%=result%>)">

<%
    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");

    ArrayList<ProjectBean> projectlist = new ArrayList<ProjectBean>();
    projectlist = (ArrayList<ProjectBean>)session.getAttribute("userprojectlist");
%>

<%--상단바--%>
<jsp:include page="/view/topmenu.jsp"></jsp:include>

<%--컨텐츠--%>
<div class="container bs-docs-container">
    <div class="row">
        <div class="col-md-9" role="main">

            <%--왼쪽부분--%>
            <div class="bs-docs-section">

                <%--페이지 이동 버튼--%>
                <div style="margin-bottom: 10px">
                    <a class="btn btn-default active" role="button">내 프로젝트</a>
                    <a class="btn btn-default" href="/controller/Project_Search_Controller.jsp?command=전체" role="button">프로젝트 찾기</a>
              		<a class="btn btn-default" onclick="window.open('/view/popup/projectcreate.jsp?email=<%=userBean.getEmail() %>', 'newprojectPopup', 'width=550, height=600, toolbar=no, menubar=no, location=no, channelmode=no')">새로만들기</a>
                </div>

                <%--프로젝트 목록--%>
                <%
                    for (int i = 0; i < projectlist.size(); i++) {
                    	String root = "/upload/";
                        String imgUrl = root + projectlist.get(i).getImage();
                        System.out.println("-------------------------------------------------------------" + imgUrl);
                        String projectname = projectlist.get(i).getProjectname();
                        String readme = projectlist.get(i).getReadme();
                        int progress = projectlist.get(i).getProgress();
                        int projectseq = projectlist.get(i).getProject_seq();
                %>
                        <div class="panel panel-default">
                            <div class="panel-heading form-inline">
                                    <% if (!imgUrl.equals("") && !imgUrl.equals("/upload/없음")) { %> <img src="<%=imgUrl%>" alt="" width="30" height="30" class="img-rounded"> <%--이미지 있을 시 이미지 사용--%>
                        			<% } else { %> <span class="glyphicon glyphicon-tasks" aria-hidden="true"></span> <% } %>                    <%--이미지 없을 시 아이콘 사용--%>
                                    <a style="font-size: 20px" onclick="clickprojectname(<%=projectseq%>)"> <%=projectname%> </a>
                                <%
                                    if (!projectlist.get(i).getLeader().equals(userBean.getEmail())) {
                                %>
                                    <a href="#" class="btn btn-default" onclick="leave(<%=projectseq%>)" role="button">탈퇴</a>
                                <%
                                    }
                                %>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <h4><%=readme%></h4>
                                </div>
                            </div>
                            <div class="panel-footer">
                                <%--진행바--%>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="<%=progress%>" aria-valuemin="0" aria-valuemax="100" style="width: <%=progress%>%; min-width: 2em;">
                                        <%=progress%>%
                                    </div>
                                </div>
                            </div>
                        </div>
                <%
                    }
                %>

                <%--페이징 버튼--%>
                <button type="button" class="btn btn-primary btn-lg btn-block">더 보기</button>

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
    function clickprojectname(projectseq){
        var form = $('<form></form>');
        form.attr('action', "/controller/Project_Controller.jsp");
        form.attr('method', 'post');
        form.appendTo('body');
        var pjseq = $("<input type='hidden' name='projectseq'>");
        pjseq.val(projectseq);

        var pjcom = $("<input type='hidden' name='command'>");
        pjcom.val('이동');

        form.append(pjseq);
        form.append(pjcom);
        form.submit();
    }

    function leave(projectseq) {
        var form = $('<form></form>');
        form.attr('action', "/controller/Project_Page_Controller.jsp");
        form.attr('method', 'post');
        form.appendTo('body');

        var pjseq = $("<input type='hidden' name='projectseq'>");
        pjseq.val(projectseq);

        var command = $("<input type='hidden' name='command'>");
        command.val('leave');

        form.append(pjseq);
        form.append(command);
        form.submit();
    }

    function leave_result(result) {
        if (result == "success")
            alert("탈퇴되었습니다.");
        else if (result == "fail")
            alert("탈퇴할 수 없습니다.");
    }
</script>

</body>
</html>