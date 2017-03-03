<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
<%@ page import="bean.ProjectScheduleBean" %>
<%@ page import="bean.UserScheduleBean" %>
<%@ page import="dao.ScheduleDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    Calendar calendar = Calendar.getInstance();
    String date = calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1) + "-" + calendar.get(Calendar.DATE);

    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");

    ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
    userprojectlist = (ArrayList<ProjectBean>)session.getAttribute("userprojectlist");

    ScheduleDAO scheduleDAO = ScheduleDAO.getInstance();

    ArrayList<ProjectScheduleBean> pjschedulelist = new ArrayList<>();
    pjschedulelist = scheduleDAO.do_search_todayproject(userBean.getEmail(),date);
    ArrayList<UserScheduleBean> userschedulelist = new ArrayList<>();
    userschedulelist = scheduleDAO.do_search_todayuser(userBean.getEmail(),date);



%>

<%--오른쪽 네비게이션--%>
        <%--오늘일정 확인--%>
        <div class="table-responsive">
            <table class="table table-bordered">
                <tr>
                    <th class="info" colspan="2" style="text-align: center"><a class="btn btn-link btn-sm" onclick="location.href = '/controller/User_Schedule_Controller.jsp'">오늘의 일정을 확인하세요</a></th>
                </tr>

                <%
                    if (pjschedulelist != null && userschedulelist != null) {
                        for (int i = 0; i < pjschedulelist.size(); i++) {
                %>
                            <tr>
                                <td><a class="btn btn-link btn-sm" onclick="right_project_name(<%=pjschedulelist.get(i).getProject_seq()%>)"><%=pjschedulelist.get(i).getProjectname()%></a></td>
                                <td><a class="btn btn-link btn-sm" onclick="right_project_schedule_title(<%=pjschedulelist.get(i).getPjschedule_seq()%>)"><%=pjschedulelist.get(i).getTitle()%></a></td>
                            </tr>
                <%
                        }
                %>
                <%
                        for (int i = 0; i < userschedulelist.size(); i++) {
                %>
                            <tr>
                                <td><a class="btn btn-link btn-sm" onclick="location.href = '/controller/User_Schedule_Controller.jsp'">개인</a></td>
                                <td><a class="btn btn-link btn-sm" onclick="right_user_schedule_title(<%=userschedulelist.get(i).getMyschedule_seq()%>)"><%=userschedulelist.get(i).getTitle()%></a></td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td height="40"></td>
                            <td height="40"></td>
                        </tr>
                <%
                    }
                %>
            </table>
        </div>

        <%--가입한 프로젝트 확인--%>
        <div class="table-responsive">
            <table class="table table-bordered">
                <tr>
                    <th class="info" style="text-align: center"><a class="btn btn-link btn-sm" onclick="location.href = '/controller/Project_Page_Controller.jsp'">프로젝트 그룹</a></th>
                </tr>
                <%
                    for (int i = 0; i < userprojectlist.size(); i++) {
                %>
                <tr>
                    <td style="text-align: center"><a class="btn btn-link btn-sm" onclick="right_project_name(<%=userprojectlist.get(i).getProject_seq()%>)"><%=userprojectlist.get(i).getProjectname()%></a></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>

<script type="text/javascript">
    function right_project_name(projectseq){
        var form = $('<form></form>');
        form.attr('action', "/controller/Project_Controller.jsp");
        form.attr('method', 'post');
        form.appendTo('body');
        var pjseq = $("<input type='hidden' name='projectseq'>");
        pjseq.val(projectseq);
        form.append(pjseq);
        var pjcom = $("<input type='hidden' name='command'>");
        pjcom.val('이동');
        form.append(pjcom);
        form.submit();
    }

    function right_project_schedule_title(scheduleseq) {
        var url = "/controller/Project_Schedule_Detail_Controller.jsp?pjseq=" + scheduleseq;
        window.open(url, "pjPopup", "width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no");
    }

    function right_user_schedule_title(scheduleseq) {
        var url = "/controller/User_Schedule_Detail_Controller.jsp?myseq=" + scheduleseq;
        window.open(url, "myPopup", "width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no");
    }

</script>
</body>
</html>
