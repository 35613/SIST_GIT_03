<%@page import="dao.MembersDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="bean.TagBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TagDAO"%>
<%@page import="bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
 
<%

   	UserBean userBean = (UserBean)session.getAttribute("userBean");
    
    String command = request.getParameter("command");
    String pjseq = request.getParameter("projectseq");
    request.setAttribute("projectseq", pjseq);
    int projectseq = Integer.parseInt(pjseq);
    
    //초대 가능한 유저 불러오기
    if(command.equalsIgnoreCase("allsearch")){
    	UserDAO userDAO = UserDAO.getInstance();
     	ArrayList<UserBean> userlist = new ArrayList<UserBean>();


    	userlist = userDAO.do_search_user_all(projectseq);
     	
    	request.setAttribute("userlist", userlist);
    	pageContext.forward("/view/popup/findmember.jsp"); 
    	 
    }
    else if(command.equalsIgnoreCase("이름")){
    	String nickname = request.getParameter("srch");
    	UserDAO usDao = UserDAO.getInstance();
		ArrayList<UserBean> userlist = new ArrayList<UserBean>();

		userlist  = usDao.do_search_user_nickname(nickname, projectseq);

		request.setAttribute("userlist", userlist);
		pageContext.forward("/view/popup/findmember.jsp");

    }  else if(command.equalsIgnoreCase("태그")){
    	ArrayList<String> picktagList = new ArrayList<String>();
		String usertag[] = request.getParameterValues("usertag");

		for(int i = 0 ; i < usertag.length; i++ ){
			picktagList.add(usertag[i]);
		}

		UserDAO userDAO = UserDAO.getInstance();
     	ArrayList<UserBean> userlist = new ArrayList<UserBean>();
      	userlist = userDAO.do_search_openuser(picktagList, projectseq);

       	request.setAttribute("userlist", userlist);
       	pageContext.forward("/view/popup/findmember.jsp");
    }
%>