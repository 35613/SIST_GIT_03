<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
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
    request.setCharacterEncoding("UTF-8");
%>

<%

    ArrayList<String> taglist = new ArrayList<String>();
    taglist = (ArrayList<String>)request.getAttribute("taglist");

    ArrayList<ProjectBean> projectlist = new ArrayList<>();
    projectlist = (ArrayList<ProjectBean>)request.getAttribute("projectlist");

%>

<%--상단바--%>
<jsp:include page="/view/topmenu.jsp"></jsp:include>

<%--컨텐츠--%>
<div class="container bs-docs-container">
    <div class="row">

        <%--왼쪽부분--%>
        <div class="col-md-9" role="main">
            <div class="bs-docs-section">
					
						
						<%--페이지 이동 버튼--%>
						<div style="margin-bottom: 10px">
							<a class="btn btn-default"
								href="/controller/Project_Page_Controller.jsp" role="button">내	프로젝트</a>
							<a class="btn btn-default active" role="button">프로젝트 찾기</a>
						</div>

						<%--검색준비--%>
						<form action="/controller/Project_Search_Controller.jsp">
						<input type="hidden" name="page" value="1">
						<input type="hidden" name="command" value="전체">
						<div class="btn-group" role="group" aria-label="..."
							style="margin-bottom: 10px">
							<button type="submit" class="btn btn-default" id="allsearch"
								name="searchbutton">전체보기</button>
							<button type="button" class="btn btn-default" id="namesearch"
								name="searchbutton">프로젝트명으로 검색</button>
							<button type="button" class="btn btn-default" id="tagsearch"
								name="searchbutton">태그명으로 검색</button>
						</div>
						</form>

						<%--검색패널--%>
						<form action="/controller/Project_Search_Controller.jsp?command=이름">
						<input type="hidden" name="command" value="이름">
						<input type="hidden" name="page" value="1">
						<div class="panel panel-default" id="namepanel" hidden="hidden">
							<div class="panel-body">
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Search for..." name="srch"> <span
										class="input-group-btn" >

										<button class="btn btn-default" type="submit">검색</button>
									</span>
								</div>
							</div>
						</div>
						</form>

						<%--태그패널--%>
						<form action="/controller/Project_Search_Controller.jsp?command=태그">
							<input type="hidden" name="page" value="1">
							<input type="hidden" name="command" value="태그">
							<div class="panel panel-default" id="tagpanel" hidden="hidden">
								<div class="panel-body">
									<%
										for (int i = 0; i < taglist.size(); i++) {
									%>
											<input name="projecttag" type="checkbox"
												style="margin-bottom: 3px; margin-top: 3px" value="<%=taglist.get(i)%>"><%=taglist.get(i)%>
									<%
										}
									%>
									<button type="submit" style="float: right;">검색하기</button>
								</div>
							</div>
						</form>

						<%--프로젝트 목록--%>
                <%
                	for (int i = 0; i < projectlist.size(); i++) {
                		String root = "/upload/";
                		String imgUrl = root + projectlist.get(i).getImage();
                		String projectname = projectlist.get(i).getProjectname();
                		String readme = projectlist.get(i).getReadme();
                		int progress = projectlist.get(i).getProgress();
                		int projectseq = projectlist.get(i).getProject_seq();
                %>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <img src="<%=imgUrl%>" alt="" width="30" height="30">
                        <a style="font-size: 20px" class="btn btn-link btn-md" onclick="clickprojectname(<%=projectseq%>, <%=i%>)" id="project<%=i%>"><%=projectname%></a>
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

        <div id="dialogdiv"></div>

    </div>
</div>

<script type="text/javascript">

    $(document).ready(function(){
        $("#allsearch").click(function(){
            $("#tagpanel").hide();
            $("#namepanel").hide();
        });
        $("#namesearch").click(function(){
            $("#tagpanel").hide();
            $("#namepanel").show();
        });
        $("#tagsearch").click(function(){
            $("#namepanel").hide();
            $("#tagpanel").show();
        });
    });

    function clickprojectname(projectseq, i){
        var url = "/controller/Project_Intro_Controller.jsp?projectseq=" + projectseq;
        window.open(url, "pjIntroPopup", "width=550 , height=600, toolbar=no, menubar=no, location=no, channelmode=no");
    }
    
</script>

</body>
</html>