<%@page import="bean.UserBean"%>
<%@page import="dao.ScheduleDAO"%>
<%@page import="bean.ProjectScheduleBean"%>
<%@page import="bean.UserScheduleBean"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bean.ProjectBean"%>
<%@ page import="bean.BoardBean"%>
<%@ page import="java.util.*, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>


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

	public String showpen(int year, int month, int day) {
		String s = "";
		String url = "/view/popup/schedulewrite.jsp";
		String image = "<img src='/view/image/pen.gif'>";
		s = String.format("<a onclick=\"window.open('/view/popup/schedulewrite.jsp?year=%d&month=%d&day=%d', 'writePopup', 'width=500, height=600, toolbar=no, menubar=no, location=no, channelmode=no')\">%s</a>", year, month, day, image);
		return s;
	}
	
	

	
	

	public String two(String msg) { // 한자리를 두자리로 만들어 주는 함수
		return msg.trim().length() < 2 ? "0" + msg : msg.trim();
	}

	// 제목이 15자이상이면 ...표시한다
	/* public String dot3(String msg) {
		String s = "";
		if (msg.length() >= 15) {
			s = msg.substring(0, 15);
			s += "...";
		} else {
			s = msg.trim();
		}
		return s;
	} */

	public String makeTable(int year, int month, int day, List<UserScheduleBean> uslist,
			List<ProjectScheduleBean> pslist) {
		String s = "";
		String dates = (year + "") + "-" + two(month + "") + "-" + two(day + "");
		System.out.println("dates = " + dates);
		s = "<table>";
		s += "<col width='98'/>";

		for (UserScheduleBean lcd : uslist) {
			System.out.println("lcd.getDodate().substring(0, 10) = " + lcd.getDodate().substring(0, 10));
			if (lcd.getDodate().substring(0, 10).equals(dates)) {
				s += "<tr bgcolor='pink' class='bg-success'>";
				s += "<td class='user'>";
				s += "<a onclick=\"window.open('/controller/User_Schedule_Detail_Controller.jsp?myseq=" + lcd.getMyschedule_seq() + "', 'myschedulePopup', 'width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no')\">";
				s += "<font style='font-size:8px; color:green'>";
				s += lcd.getTitle();
				s += "</font>";
				s += "</a>";
				s += "</td>";
				s += "</tr>";
			}
		}
		for (ProjectScheduleBean lcd : pslist) {
			if (lcd.getDodate().substring(0, 10).equals(dates)) {
				s += "<tr bgcolor='lightgray' class='bg-danger'>";
				s += "<td class='project'>";
				s += "<a onclick=\"window.open('/controller/Project_Schedule_Detail_Controller.jsp?pjseq=" + lcd.getPjschedule_seq() + "', 'pjschedulePopup', 'width=550, height=600, toolbar=no, menubar=no, location=no, channelmode=no')\">";
				s += "<font style='font-size:8px; color:red'>";
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/view/JS/bootstrap.min.js"></script>
<style type="text/css">
body {
	padding-top: 70px;
}
</style>
</head>
<body>


	<%
	UserScheduleBean ubean;
	ProjectScheduleBean pbean;
	ArrayList<UserScheduleBean> userlist = (ArrayList<UserScheduleBean>) request.getAttribute("userslist");
	ArrayList<ProjectScheduleBean> projectlist = (ArrayList<ProjectScheduleBean>) request.getAttribute("projectlist");


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


	<%--상단바--%>
	<jsp:include page="/view/topmenu.jsp"></jsp:include>

	<%--컨텐츠--%>
	<div class="container bs-docs-container">
		<div class="row">

			<%--왼쪽부분--%>
			<div class="col-md-9" role="main">
				<div class="bs-docs-section">

					
					<%--라디오버튼--%>
					<div class="t1">
					
						<input type="radio"  name="radio" id="all" style="margin-right: 3px" checked="checked">ALL 
						<input type="radio"  name="radio" id="my" style="margin-right: 3px">MY
						<input type="radio"  name="radio" id="project" style="margin-left: 10px; margin-right: 3px">PROJECT
			
					<%--캘린더 처리--%>
					<script type="text/javascript">
						$(document).ready(function() {
							$(".user").show();
							$(".project").show();

							$("#all").click(function(){
								$(".user").show();
								$(".project").show();
							});

							$("#my").click(function() {
								$(".project").hide();
								$(".user").show();
							});

							$("#project").click(function() {
								$(".project").show();
								$(".user").hide();
							});

					
						}); 
					</script>

						<table border="1" style="border-color: gray;" >
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />
							<col width="100" />


							<tr height="50" class="bg-info" >
								<td colspan="7" align="center"><%=p%> <font color="gray"
									style="font-size: 50px"> <%=String.format("%d년&nbsp;&nbsp;%d월", year, month)%>
								</font> <%=n%>
								</td>
							</tr>
							<tr class='date' >
								<td style="text-align: center;">일</td>
								<td style="text-align: center;">월</td>
								<td style="text-align: center;">화</td>
								<td style="text-align: center;">수</td>
								<td style="text-align: center;">목</td>
								<td style="text-align: center;">금</td>
								<td style="text-align: center;">토</td>
							</tr>

							<tr height="150" align="left" valign="top">
								<%
									for (int i3 = 1; i3 < dayOfWeek; i3++) {
								%>
								<td>&nbsp;</td>
								<%
									}
									int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

									for (int i = 1; i <= lastDay; i++) {
								%>

								<td>
								<%=i%>&nbsp;<%=showpen(year, month, i)%>
									<%=makeTable(year, month, i, userlist, projectlist)%></td>
								<%
									if ((i + dayOfWeek - 1) % 7 == 0) {
								%>
							</tr>
							<tr height="150" align="left" valign="top">
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