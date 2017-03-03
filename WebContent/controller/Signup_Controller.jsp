<%@ page import="dao.UserDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%

	
    String email = request.getParameter("email");
// 닉네임
	int num = email.indexOf('@');
	String nickname = email.substring(0, num);

    String username = request.getParameter("username");
    String password = request.getParameter("password");

//  userBean 생성 
    UserDAO userDAO = UserDAO.getInstance();
    UserBean userBean = new UserBean();
    userBean.setEmail(email);
    userBean.setPw(password);
    userBean.setNickname(nickname);
    userBean.setUsername(username);
    
    System.out.print(userBean.toString());
    
    
    boolean successFail = userDAO.do_insert_user(userBean);
    
    


    if (successFail) {  // 회원가입 완료
    	
    	System.out.print("회원가입완료");
  
        response.sendRedirect("First_Page_Controller.jsp");

    }
    else {              // 회원가입 실패
      	
    	System.out.print("회원가입실패");
     	String errmsg = "loginfail";
        response.sendRedirect("/view/nonPopup/signup.jsp?errmsg=" + errmsg);
        
    }
    

%>

