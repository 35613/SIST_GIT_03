<%@page import="bean.UserBean"%>
<%@page import="bean.BoardCommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ProjectCommentBean"%>
<%@ page import="bean.BoardBean" %>
<%@ page import="dao.BoardDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%
	UserBean userBean = (UserBean)session.getAttribute("userBean");
    int boardseq = Integer.parseInt(request.getParameter("boardseq"));
	String comment =request.getParameter("comment");
    String command = request.getParameter("command");
    
    BoardDAO boardDAO = BoardDAO.getInstance();

    BoardBean boardBean = boardDAO.do_search(boardseq);
    if (command != null) {
		if (command.equals("댓글쓰기")) {
			BoardCommentBean boardCommentBean = new BoardCommentBean();
			boardCommentBean.setContentss(comment);
			boardCommentBean.setWriter(userBean.getEmail());
			boardCommentBean.setPost_seq(boardseq);
			
			boardDAO.do_insert_comment(boardCommentBean);	
		} else if (command.equals("삭제")) {
			boardDAO.do_delete(boardBean);
		}
    }

    
    ArrayList<BoardCommentBean> comentlist =  boardDAO.do_search_comment(boardseq);
    
    
    request.setAttribute("comentlist", comentlist);
    request.setAttribute("boardBean", boardBean);

    pageContext.forward("/view/popup/boarddetail.jsp");
%>