<%@page import="bean.ApplicationBean"%>
<%@page import="bean.InvitationBean"%>
<%@page import="dao.MessageDAO"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.ProjectBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%
    String email = request.getParameter("email");
    String pw = request.getParameter("pw");

//    유저 정보 얻어오기
    UserDAO userDAO = UserDAO.getInstance();
    UserBean userBean = new UserBean();
    userBean = userDAO.do_search_userinfo(email, pw);


    if (userBean.getEmail() == null) {  // 로그인 실패시
        String errmsg = "이메일과 비밀번호를 확인해 주세요.";
        request.setAttribute("errmsg", errmsg);
        pageContext.forward("/view/nonPopup/login.jsp");

    }
    else {                              // 로그인 성공시
        // 세션에 유저 빈 저장
        session.setAttribute("userBean", userBean);

        // 세션에 유저가 가입한 프로젝트 리스트 저장
        ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
        userprojectlist = userDAO.do_search_userproject(userBean.getEmail());
        session.setAttribute("userprojectlist", userprojectlist);
        
        // 세션에 유저 초대장 지원서 리스트 저장
//        MessageDAO messageDAO = MessageDAO.getInstance();
//        ArrayList<InvitationBean> invitationlist = new ArrayList<>();
//        invitationlist = messageDAO.do_search_invitation(userBean.getEmail());
//        int isize = 0;
//        if (invitationlist != null) {
//        	isize = invitationlist.size();
//        }
//        Integer invitationsize = isize;
//        session.setAttribute("invitationsize", invitationsize);
//
//        ArrayList<ApplicationBean> applicationlist = new ArrayList<>();
//        applicationlist = messageDAO.do_search_application(userBean.getEmail());
//        int asize = 0;
//        if (applicationlist != null) {
//        	asize = applicationlist.size();
//        }
//        Integer applicationsize = asize;
//        session.setAttribute("applicationsize", applicationsize);
        
//        response.sendRedirect("Project_Board_Controller.jsp");
        response.sendRedirect("/view/nonPopup/projectboard.jsp");


    }

%>MessageDAO messageDAO = MessageDAO.getInstance();