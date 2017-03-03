<%@page import="bean.InvitationBean"%>
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

    //    초대장 리스트
    MessageDAO messageDAO = MessageDAO.getInstance();

    ArrayList<InvitationBean> invitationlist = new ArrayList<>();
    invitationlist.addAll(messageDAO.do_search_invitation(userBean.getEmail()));

    request.setAttribute("invitationlist", invitationlist);    
      
    pageContext.forward("/view/nonPopup/invitationlist.jsp");

%>