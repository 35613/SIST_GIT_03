<%@page import="bean.ApplicationBean"%>
<%@page import="dao.MessageDAO"%>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
%>

<%

    //    유저 정보를 세션에서 가져옴
    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");
    request.setAttribute("userBean", userBean);

    //    지원서 리스트
    MessageDAO messageDAO = MessageDAO.getInstance();
    ArrayList<ApplicationBean> applicationlist = new ArrayList<>();
    applicationlist.addAll(messageDAO.do_search_application(userBean.getEmail()));

    request.setAttribute("applicationlist", applicationlist);
    
    pageContext.forward("/view/nonPopup/applicationlist.jsp");



%>