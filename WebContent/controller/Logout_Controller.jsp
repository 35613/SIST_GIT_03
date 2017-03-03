<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%
    session.invalidate();
    response.sendRedirect("/controller/First_Page_Controller.jsp");
%>
