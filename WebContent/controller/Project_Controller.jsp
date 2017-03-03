<%@page import="bean.BoardBean"%>
<%@page import="bean.ProjectScheduleBean"%>
<%@page import="bean.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BoardDAO"%>
<%@page import="dao.ScheduleDAO"%>
<%@page import="dao.MembersDAO"%>
<%@page import="bean.ProjectBean"%>
<%@page import="dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%

//유저 정보 얻어오기
ProjectDAO pjdao = ProjectDAO.getInstance();
MembersDAO Mdao = MembersDAO.getInstance();
ScheduleDAO SCdao = ScheduleDAO.getInstance();
BoardDAO BOdao = BoardDAO.getInstance();
System.out.println(request.getParameter("projectseq"));
System.out.println(request.getParameter("command"));

if(request.getParameter("command").equals("이동")){
	
	session.setAttribute("projectseq", request.getParameter("projectseq"));
}
String seq_str = (String)session.getAttribute("projectseq");
int seq = Integer.parseInt(seq_str);
	ArrayList<UserBean> PUlist = Mdao.do_search(seq);
	

	ProjectBean pjdto = pjdao.do_search(seq);
	UserBean dto = (UserBean)session.getAttribute("userBean");
	
	ArrayList<ProjectBean> UPlist = Mdao.do_search_joinproject(dto.getEmail());

	ArrayList<ProjectScheduleBean> projectlist = SCdao.do_search_projectschedule(seq);

	ArrayList<BoardBean> boardlist1 = pjdao.do_search_pjboard(seq,1);

	request.setAttribute("PUlist", PUlist);
	request.setAttribute("pjdto", pjdto);
	request.setAttribute("UPlist", UPlist);
	request.setAttribute("projectlist", projectlist);
	request.setAttribute("boardlist1", boardlist1);

	pageContext.forward("/view/nonPopup/projectdetail.jsp");

	
	
		
 %>