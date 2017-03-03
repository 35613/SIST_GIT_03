<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
<%@ page import="bean.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GROUPPL</title>
    <link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
    <link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/view/JS/bootstrap.min.js"></script>
    <style type="text/css">
        body { padding-top: 70px;
            /*background-color: #4fc0c4*/
        }
    </style>

</head>
<body>

<%
    ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
    userprojectlist = (ArrayList<ProjectBean>)session.getAttribute("userprojectlist");



    String pjname = request.getParameter("pjname");
    if (pjname == null)
        pjname = "프로젝트명";
    System.out.println("pjname = " + pjname);
%>

<%--상단바--%>
<jsp:include page="/view/topmenu.jsp"></jsp:include>

<%--컨텐츠--%>
<div class="container bs-docs-container">
    <div class="row">

        <%--왼쪽부분--%>
        <div class="col-md-9" role="main">
            <div class="bs-docs-section">
                <%--셀렉트--%>
                <div class="item" style="margin-bottom: 10px">
                    <select class="form-control" style="width: 20%" id="select" >
                        <option>프로젝트명</option>
                        <option <%if (pjname.equals("All")) {%> selected="selected"<%}%> >All</option>
                        <%
                            for (int i = 0; i < userprojectlist.size(); i++) {
                        %>
                                <option <%if (pjname.equals(userprojectlist.get(i).getProjectname())) {%> selected="selected"<%}%> ><%=userprojectlist.get(i).getProjectname()%></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <%--뉴스피드--%>
                <div id="board">

                </div>

                <%--페이징 버튼--%>
                <button type="button" class="btn btn-primary btn-lg btn-block" id="more" >더 보기</button>

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


<div id="dialogdiv"></div>

<script type="text/javascript">

    var page = 1;

    $(function() {

        $(document).ready(function () {
            loadboard();
        });

        function loadboard() {
            var url="/controller/Project_Board_Controller.jsp";
            var pjname = $("#select").val();
            console.log(pjname);
            if (pjname == "프로젝트명")
                pjname = "All";
            console.log(pjname);

            $.ajax({
                type:"POST",
                url:url,
                data:{
                    "page": page,
                    "projectname": pjname,
                },
                success:function(data){
//                    console.log("success\t"+data); 받은 데이터 확인용
                    var boarddata = $.parseJSON(data);
                    console.log("success\t"+boarddata);

                    if(boarddata.length != 0) {
                        for(var i = 0; i < boarddata.length;i++){
                            var writer = boarddata[i].writer;
                            var writernickname = boarddata[i].writernickname;
                            var project_seq = boarddata[i].project_seq;
                            var projectname = boarddata[i].projectname;
                            var post_seq = boarddata[i].post_seq;
                            var contentss = boarddata[i].contentss;
                            var writerimage = "/upload/" + boarddata[i].writerimage;
                            var userInfoUrl = "/controller/User_Info_Controller.jsp?email=" + writer;

                            var div = "<div class='panel panel-info'>" +
                                        "<div class='panel-heading'>" +
                                        " <img src='" + writerimage + "' onerror=\'this.onerror=null;this.src=\"\/view\/image\/user_default.png\";\' width='30' height='30'>" +
                                        "   <a class='btn btn-link btn-md' onclick=\"clickusername('" + writer + "')\">" + writernickname + "</a>" +
                                        " / <a class='btn btn-link btn-md' onclick='clickprojectname(" + project_seq + ")'>" + projectname + "</a>" +
                                        "</div> " +
                                        "<div class='panel-body'>" +
                                        "   <a class='btn btn-link btn-md' onclick='clickcontents(" + post_seq + ")'> " + contentss + "</a> " +
                                        "</div>" +
                                    "</div>"
                            console.log(div);
                            console.log("test="+boarddata[i].post_seq); // 데이터 잘 받는지 post_seq 확인

                            $('#board').append(div);

                        }
                    }
                    page++;
                },
                error:function(e){
                    alert(e.responseText);
                }
            });
        }

        $("#more").click(function () {
            loadboard();
        });

        $("#select").change(function () {
            location.href="/view/nonPopup/projectboard.jsp?pjname=" + $("#select").val();
        });


    });

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

    function clickusername(email) {
        var url = "/controller/User_Info_Controller.jsp?email=" + email;
        window.open(url, 'userInfoPopup', 'width=500, height=600, toolbar=no, menubar=no, location=no, channelmode=no');
    }

    function clickcontents(boardseq) {
        var url = "/controller/Board_Detail_Controller.jsp?boardseq=" + boardseq;
        window.open(url, 'boardPopup', 'width=500, height=600, toolbar=no, menubar=no, location=no, channelmode=no');
    }

</script>

</body>
</html>