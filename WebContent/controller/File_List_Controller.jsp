<%@page import="bean.FileBean"%>
<%@page import="dao.FileDAO"%>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
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

    //    유저 정보를 세션에서 가져옴
    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");
    request.setAttribute("userBean", userBean);

    //   파일 리스트 가져오기
    FileDAO fileDAO = FileDAO.getInstance();
    ArrayList<FileBean> filelist = new ArrayList<>();
    int seq = Integer.parseInt(request.getParameter("project_Seq"));//프로젝트 디테일에서 set해줘야함
    
    for (int i = 0; i < pagenum; i++)
    filelist.addAll(fileDAO.do_search_file(seq));
    request.setAttribute("filelist", filelist);

    //    유저가 가입한 프로젝트 리스트를 세션에서 가져옴
    ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
    userprojectlist = (ArrayList<ProjectBean>)session.getAttribute("userprojectlist");

    pageContext.forward("/view/nonPopup/filelist.jsp");



%>