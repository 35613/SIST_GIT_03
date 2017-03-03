<%@ page import="com.google.gson.Gson" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
<%@ page import="bean.BoardBean" %>
<%@ page import="dao.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
%>

<%
    //    페이징
    int pagenum = 1;
    if (request.getParameter("page") != null)
        pagenum = Integer.parseInt(request.getParameter("page"));

    // 검색조건인 프로젝트 이름을 가져옴
    String projectname = request.getParameter("projectname");

    //    유저 정보를 세션에서 가져옴
    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");

    request.setAttribute("userBean", userBean);

    //    게시글 리스트
    BoardDAO boardDAO = BoardDAO.getInstance();
    ArrayList<BoardBean> boardlist = new ArrayList<>();

    boardlist = boardDAO.do_search_boardlist(userBean.getEmail(), pagenum);


    if (projectname != null && !projectname.equals("All")) {
        int i = boardlist.size() - 1;
        while (i >= 0) {
            if (boardlist.get(i).getProjectname().equals(projectname)) {
            } else {
                boardlist.remove(boardlist.get(i));
            }
            i--;
        }
    }

    Gson gson = new Gson();
    System.out.println(gson.toJson(boardlist));
    out.println(gson.toJson(boardlist));

//    request.setAttribute("boardlist", boardlist);
//    pageContext.forward("/view/nonPopup/projectboard.jsp");

%>





<%--<%--%>
    <%--for (int i = 0; i < boardlist.size(); i++) {--%>
        <%--String contents = boardlist.get(i).getContentss();--%>
        <%--String writernickname = boardlist.get(i).getWriternickname();--%>
        <%--String pname = boardlist.get(i).getProjectname();--%>
        <%--String writer = boardlist.get(i).getWriter();--%>
        <%--int projectseq = boardlist.get(i).getProject_seq();--%>
        <%--int boardseq = boardlist.get(i).getPost_seq();--%>
        <%--if (contents.length() > 90) {--%>
            <%--contents = contents.substring(0, 90) + "...";--%>
        <%--}--%>
<%--%>--%>

        <%--<div class="panel panel-info">--%>
            <%--<div class="panel-heading"><a class="btn btn-link btn-md" onclick="clickusername('<%=writer%>', <%=i%>)" id="board<%=i%>"><%=writernickname%></a> / <a class="btn btn-link btn-md" onclick="clickprojectname(<%=projectseq%>)"><%=pname%></a></div>--%>
            <%--<div class="panel-body">--%>
                <%--<a class="btn btn-link btn-md" onclick="clickcontents(<%=boardseq%>)"><%=contents%></a>--%>
            <%--</div>--%>
        <%--</div>--%>
<%--<%--%>


    <%--}--%>
<%--%>--%>
