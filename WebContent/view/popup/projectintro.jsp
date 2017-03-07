<%@page import="bean.ProjectBean"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.UserBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로젝트간단정보</title>
    <link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
    <link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/view/JS/bootstrap.min.js"></script>
</head>
<body style="width:500px; height:600px;">

<%
    request.setCharacterEncoding("UTF-8");
%>

<%
    UserBean userBean = (UserBean)session.getAttribute("userBean");

 	ProjectBean bean = (ProjectBean)request.getAttribute("bean");

    ArrayList<UserBean> userlist = (ArrayList<UserBean>)request.getAttribute("userlist");
    
    String root = "/upload/";
    String imgurl = root + bean.getImage();
    String projectname = "프로젝트1";
    
%>

    <div class="panel panel-default">
        <%--판넬 헤드 부분--%>
        <div class="panel-heading">
            <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
            <a href="#" style="margin-right: 40%"><%=bean.getLeader()%></a>
            <a href="#" class="panel-title"><%=bean.getProjectname()%></a>
        </div>

         <%--판넬 바디 부분--%>

        <div class="panel-body">
            <div>
                <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
                <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Projectimage</a>
            </div>
            <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
                <div class="panel-body">
                    <h4>프로젝트이미지입니다.</h4>
                </div>
            </div>

            <div>
                <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
                <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Projectname</a>
            </div>
            <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
                <div class="panel-body">
                    <h4>프로젝트명:<%=bean.getProjectname() %></h4>
                </div>
            </div>

            <div>
                <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
                <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Progress</a>
            </div>
            <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
                <div class="panel-body">
                    <h4>진행도:<%=bean.getProgress() %></h4>
                </div>
            </div>

            <div>
                <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
                <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Projectintroduce</a>
            </div>
            <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
                <div class="panel-body">
                 	   <h4>프로젝트소개:<%=bean.getReadme() %></h4>
                </div>
            </div>

            <div>
                <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
                <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Startdate</a>
            </div>

            <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
                <div class="panel-body">
                    	 <h4>시작날짜:<%=bean.getStartdate() %></h4>
                </div>
            </div>

            <div>
                <span class="glyphicon glyphicon-ok" aria-hidden="true" ></span>
                <a class="panel-title" style="margin-left: 10px; margin-bottom: 5px">Enddate</a>
            </div>
            <div class="panel panel-default" style="margin-left: 40px; margin-bottom: 30px">
                <div class="panel-body">
                 	  	 <h4>종료날짜:<%=bean.getEnddate() %></h4>
                </div>
            </div>

            <div style="text-align:right;">
                <input class="btn btn-default" type="button" value="멤버보기" id="showmembers" >
                <input class="btn btn-default" type="button" value="지원하기" id="applyto">
                <input class="btn btn-default" type="button" value="닫기" onclick="javascript:window.open('','_parent','');window.close();">
            </div>
        </div>

        <div id="dialogdiv" title="소속 멤버">
            <table class="table">
                <%
                    for (int i = 0; i < userlist.size(); i++) {
                        String img = userlist.get(i).getImage();
                %>
                <tr>
                    <td><img src="<%=img%>" alt=""></td>
                    <td><a class="btn btn-link btn-sm" onclick="clickusername(<%=userlist.get(i).getEmail()%>)"><%=userlist.get(i).getNickname()%></a></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>

        <div id="dialog-form" title="지원하기">
            <p class="validateTips">지원하면서 하고 싶은 말을 적어주세요.</p>

            <form action="/controller/Application_Add_Controller.jsp" method="post" id="frm">
                <fieldset>
                    <input type="hidden" name="sendemail" value="<%=userBean.getEmail()%>">
                    <input type="hidden" name="sendimage" value="<%=userBean.getImage()%>">
                    <input type="hidden" name="email" value="<%=bean.getLeader()%>">
                    <input type="hidden" name="projectseq" value="<%=bean.getProject_seq()%>">
                    <input type="text" name="contents" id="contents" placeholder="한마디" class="text ui-widget-content ui-corner-all">

                    <!-- Allow form submission with keyboard without duplicating the dialog button -->
                    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
                </fieldset>
            </form>
        </div>


    </div>


<script type="text/javascript">
    $( function() {
        $( "#dialogdiv" ).dialog({
            autoOpen: false,
            modal:true
        });

        $( "#dialog-form" ).dialog({
            autoOpen: false,
            height: 400,
            width: 350,
            modal: true,
            buttons: {
                "지원하기": function () {
                    $("#frm").submit();
                    $( "#dialog-form" ).dialog( "close" );
                    alert("지원이 완료되었습니다.");
                },
                Cancel: function() {
                    $( "#dialog-form" ).dialog( "close" );
                }
            }
        });

        $( "#showmembers" ).on( "click", function() {
            $( "#dialogdiv" ).dialog( "open" );
        });

        $( "#applyto" ).on( "click", function() {
            $( "#dialog-form" ).dialog( "open" );
        });
    } );


    function clickusername(email) {
        var url = "/controller/User_Info_Controller.jsp?email=" + email;
        window.open(url, 'userpop', 'width=500 , height=600, toolbar=no, menubar=no, location=no, channelmode=no');
    }

</script>

</body>
</html>