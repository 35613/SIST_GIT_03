<%@page import="java.util.List"%>
<%@page import="bean.UserScheduleBean"%>
<%@page import="java.util.Calendar"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dao.ScheduleDAO"%>
<%@page import="dao.MembersDAO"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="bean.BoardBean"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.ProjectScheduleBean"%>
<%@page import="bean.ProjectBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%!
    boolean nvl(String msg) {
        return msg == null || msg.trim().equals("") ? true : false;
    }


    public String callist(int year, int month, int day) {
        String s = "";
        s += String.format("<a href='%s?year=%d&month=%d&day=%d'>", "callist.jsp", year, month, day);
        s += String.format("%2d", day);
        s += "</a>";
        return s;
    }

    public String showpen(int year, int month, int day, int projectseq) {
        String s = "";
        String image = "<img src='/view/image/pen.gif'>";
        s = String.format("<a onclick=\"window.open('/controller/Project_Schedule_Write_Controller.jsp?year=%d&month=%d&day=%d&projectseq=%d', 'writePopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')\">%s</a>", year, month, day, projectseq, image);
        return s;
    }






    public String two(String msg) { // 한자리를 두자리로 만들어 주는 함수
        return msg.trim().length() < 2 ? "0" + msg : msg.trim();
    }

//	// 제목이 15자이상이면 ...표시한다
//	public String dot3(String msg) {
//		String s = "";
//		if (msg.length() >= 15) {
//			s = msg.substring(0, 15);
//			s += "...";
//		} else {
//			s = msg.trim();
//		}
//		return s;
//	}

    public String makeTable(int year, int month, int day, List<ProjectScheduleBean> pslist) {
        String s = "";
        String dates = (year + "") + "-" + two(month + "") + "-" + two(day + "");
        System.out.println("dates = " + dates);
        s = "<table>";
        s += "<col width='98'/>";

        for (ProjectScheduleBean lcd : pslist) {
            if (lcd.getDodate().substring(0, 10).equals(dates)) {
                s += "<tr bgcolor='lightgray' class='project'>";
                s += "<td class='project'>";
                s += "<a onclick=\"window.open('/controller/Project_Schedule_Detail_Controller.jsp?pjseq=" + lcd.getPjschedule_seq() + "', 'pjschedulePopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')\">";
                s += "<font style='font-size:8px; color:black'>";
                s += lcd.getTitle();
                s += "</font>";
                s += "</a>";
                s += "</td>";
                s += "</tr>";

            }
        }
        s += "</table>";
        return s;
    }
%>
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
    <%
        request.setCharacterEncoding("UTF-8");
    %>

    <%
    	String root = "/upload/";
        ArrayList<UserBean> PUlist=(ArrayList<UserBean>)request.getAttribute("PUlist");

        ProjectBean pjdto = (ProjectBean)request.getAttribute("pjdto");
		String img = root + pjdto.getImage();
        System.out.println(pjdto.toString());
        ArrayList<ProjectBean> UPlist =(ArrayList<ProjectBean>)request.getAttribute("UPlist");

        ArrayList<ProjectScheduleBean> projectlist =(ArrayList<ProjectScheduleBean>)request.getAttribute("projectlist");

        ArrayList<BoardBean> boardlist1 =(ArrayList<BoardBean>)request.getAttribute("boardlist1");

        UserBean leader = (UserBean)session.getAttribute("userBean");

        UserBean userBean = new UserBean();
        userBean = (UserBean)session.getAttribute("userBean");
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DATE, 1);

        String syear = request.getParameter("year");
        String smonth = request.getParameter("month");

        int year = cal.get(Calendar.YEAR);
        if (!nvl(syear)) {
            year = Integer.parseInt(syear);
        }
        int month = cal.get(Calendar.MONTH) + 1;
        if (!nvl(smonth)) {
            month = Integer.parseInt(smonth);
        }

        if (month < 1) {
            month = 12;
            year--;
        }
        if (month > 12) {
            month = 1;
            year++;
        }

        cal.set(year, month - 1, 1);

//요일 1 ~ 7
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

        String sf = String.format("%d년 %d월", year, month);
        String sleft = String.format("mycalendar.jsp?year=%d&month=%d", year, month - 1);
        String sright = String.format("mycalendar.jsp?year=%d&month=%d", year, month + 1);

        String p = String.format("<a href='%s?year=%d&month=%d'><img src='/view/image/left.png'/></a>",
                "User_Schedule_Controller.jsp", year, month - 1);

        String n = String.format("<a href='%s?year=%d&month=%d'><img src='/view/image/right.png'/></a>",
                "User_Schedule_Controller.jsp", year, month + 1);
    %>
</head>
<body>

<%--상단바 부분--%>
<jsp:include page="/view/topmenu.jsp"></jsp:include>

<div class="container bs-docs-container">
    <div class="row">

        <div class="col-md-9" role="main">
            <div class="bs-docs-section">

                <div class="panel panel-default">

                    <div class="panel-heading form-inline" >
                      
                        <div>
	                        <% if (!img.equals("") && !img.equals("/upload/없음")) { %> <img src="<%=img%>" alt="" width="30" height="30" class="img-rounded"> <%--이미지 있을 시 이미지 사용--%>
	                        <% } else { %> <span class="glyphicon glyphicon-tasks" aria-hidden="true"></span> <% } %>                    <%--이미지 없을 시 아이콘 사용--%>
                            <h4><%=pjdto.getProjectname() %></h4>
                   		</div>
                        <div>
                            <button
                                    class="btn btn-primary btn-group-sm"
                                    style="width: 15%; height: 10%; float: right;"
                                    onclick="addmember(<%=pjdto.getProject_seq()%>)">멤버 추가
                            </button>
                        </div>
                        <div>
                            <button
                                    id='<%if (pjdto.getLeader().equals(userBean.getEmail()))out.print("show");%>'
                                    class="btn btn-primary btn-group-sm"
                                    style="width: 15%; height: 10%; float: right; display: none"
                                    onclick="location.href='/controller/Project_Edit_Controller.jsp?command=정보수정'" >정보수정
                            </button>
                        </div>
                    </div>
                    <br>
                    <div class="panel-body">
                        <div>
                            <h4><%=pjdto.getReadme() %></h4>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <%--진행바--%>
                        <h4>진행바</h4>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" aria-valuenow=<%=pjdto.getProgress() %>
                                    aria-valuemin="0" aria-valuemax="100" style="width: <%=pjdto.getProgress() %>%;">
                                <%=pjdto.getProgress() %>%
                            </div>
                        </div>
                    </div>
                </div>

                <%--캘린더 처리--%>

                <table border="1" style="border-color: gray;">
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />
                    <col width="100" />

                    <tr height="50">
                        <td colspan="7" align="center"><%=p%> <font color="red" style="font-size: 50px"> <%=String.format("%d년&nbsp;&nbsp;%d월", year, month)%>
                        </font> <%=n%>
                        </td>
                    </tr>

                    <tr class='date'>
                        <td>일</td>
                        <td>월</td>
                        <td>화</td>
                        <td>수</td>
                        <td>목</td>
                        <td>금</td>
                        <td>토</td>
                    </tr>

                    <tr height="100" align="left" valign="top">
                        <%
                            for (int i3 = 1; i3 < dayOfWeek; i3++) {
                        %>
                        <td>&nbsp;</td>
                        <%
                            }
                            int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

                            for (int i = 1; i <= lastDay; i++) {
                        %>
                        <td><%=i%>&nbsp;<%=showpen(year, month, i,pjdto.getProject_seq())%>
                            <%=makeTable(year, month, i, projectlist)%>
                        </td>
                        <%
                            if ((i + dayOfWeek - 1) % 7 == 0) {
                        %>
                    </tr>
                    <tr height="100" align="left" valign="top">
                        <%
                                }
                            }
                            for (int i = 0; i < (7 - (dayOfWeek + lastDay - 1) % 7) % 7; i++) {
                        %>
                        <td>&nbsp;</td>
                        <%
                            }
                        %>
                    </tr>
                </table>

                <div class="jumbotron">
                    <button onclick="window.open('/view/popup/projectboardwrite.jsp?projectseq=<%=pjdto.getProject_seq()%>&projectname=<%=pjdto.getProjectname() %>', 'boardwritePopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')">글쓰기</button>
                    <%--뉴스피드--%>
                    <%
                        for (int i = 0; i < boardlist1.size(); i++) {
                            String contents = boardlist1.get(i).getContentss();
                            String writernickname = boardlist1.get(i).getWriternickname();
                            String projectname = boardlist1.get(i).getProjectname();
                            String writer = boardlist1.get(i).getWriter();

                            int projectseq = boardlist1.get(i).getProject_seq();
                            int boardseq = boardlist1.get(i).getPost_seq();
                            if (contents.length() > 90) {
                                contents = contents.substring(0, 90) + "...";
                            }
                    %>
                    <div class="panel panel-info">
                        <div class="panel-heading"><a class="btn btn-link btn-md" onclick="window.open('/controller/User_Info_Controller.jsp?email=<%=writer%>', 'userInfo', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')"><%=writernickname%></a></div>
                        <div class="panel-body">
                            <a class="btn btn-link btn-md" onclick="clickcontents(<%=boardseq%>)"><%=contents%></a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>

            </div>
        </div>

        <%--오른쪽 네비게이션--%>
        <div class="col-md-3" role="complementary">
            <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">

                <%--프로젝트 가입한 유저 확인--%>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tr>
                            <th class="active" style="text-align: center">프로젝트 팀원</th>
                        </tr>
                        <%
                            for (int i = 0; i < PUlist.size(); i++) {
                                System.out.println(PUlist.get(i).getEmail());
                        %>
                        <tr>
                            <td style="text-align: center"><a class="btn btn-link btn-sm" onclick="window.open('/controller/User_Info_Controller.jsp?email=<%=PUlist.get(i).getEmail()%>', 'userInfoPopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')"><%=PUlist.get(i).getNickname()%></a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>

                <%--rightmenu --%>
                <jsp:include page="/view/rightmenu.jsp"></jsp:include>
            </nav>
        </div>
    </div>
</div>


<script type="text/javascript">
    $("#show").show();

    function addmember(projectseq) {
        var url = "/controller/Find_Member_Controller.jsp?command=allsearch&projectseq=" + projectseq;
        window.open(url, 'findPopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no');
    }

    function clickcontents(boardseq) {
        var url = "/controller/Board_Detail_Controller.jsp?boardseq=" + boardseq;
        window.open(url, 'contentPopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no');
    }

</script>

<script type="text/javascript">
    var pagenum = 2;
    $(document).ready(function () {
        $("#more").click(function () {

        });

    });



</script>
</body>
</html>