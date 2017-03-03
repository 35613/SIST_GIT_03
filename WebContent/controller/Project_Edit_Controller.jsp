<%@page import="bean.UserBean"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@page import="bean.TagBean"%>
<%@page import="dao.TagDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ProjectBean"%>
<%@page import="dao.ProjectDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<%
	ProjectDAO pjdao = ProjectDAO.getInstance();
TagDAO tgdao = TagDAO.getInstance();

String command = request.getParameter("command");
String seq_str = (String)session.getAttribute("projectseq");
int seq = Integer.parseInt(seq_str);





if(command.equals("정보수정")){
		ProjectBean PJdto = pjdao.do_search(seq);
		ArrayList<String> usertaglist = tgdao.do_search_projecttag(seq);
		ArrayList<String> taglist = tgdao.do_search_tag();
		
		request.setAttribute("PJdto", PJdto);
		request.setAttribute("usertaglist", usertaglist);
		request.setAttribute("taglist", taglist);
		request.setAttribute("projectseq", seq);
		
		pageContext.forward("/view/nonPopup/projectedit.jsp");
		
}else if(command.equals("수정하기")){
		ProjectBean PJdto = new ProjectBean();
	
		PJdto.setProjectname(request.getParameter("PROJECTNAME"));
		PJdto.setLeader(request.getParameter("LEADER"));
		PJdto.setStartdate(request.getParameter("STARTDATE"));
		PJdto.setEnddate(request.getParameter("ENDDATE"));
		PJdto.setProgress(Integer.parseInt(request.getParameter("PROGRESS")));
		PJdto.setReadme(request.getParameter("README"));
		PJdto.setIsopen(request.getParameter("ISOPEN"));
		PJdto.setImage(request.getParameter("IMAGE"));
		/* PJdto.setProject_seq((Integer)session.getAttribute("PROJECT_SEQ")); */
		PJdto.setProject_seq(seq);
		
		ArrayList<TagBean> tagList = new ArrayList<TagBean>();
		String projecttag[] = request.getParameterValues("projecttag");
		boolean tagadd = true;
		if (projecttag != null) {
			for(int i = 0 ; i < projecttag.length; i++ ){
				TagBean tagBean = new TagBean();
				 tagBean.setProject_seq(seq);
				 tagBean.setTagname(projecttag[i]);
				 tagList.add(tagBean);
			    
			}
			tagadd = tgdao.do_update_project(seq, tagList);
		}
		boolean pjadd = pjdao.do_update(PJdto);
		
		
		if(pjadd&tagadd){
			System.out.println("asd2");
			response.sendRedirect("Project_Controller.jsp?command='이동'");
			
		}else{
			System.out.println("asd");
			response.sendRedirect("Project_Edit_Controller.jsp?command='정보수정'");
		}
		
		// 세션에 유저가 가입한 프로젝트 리스트 저장
	    UserDAO userDAO = UserDAO.getInstance();
	    UserBean userBean = new UserBean();
	    userBean = (UserBean)session.getAttribute("userBean");
	    
        ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
        userprojectlist = userDAO.do_search_userproject(userBean.getEmail());
        session.setAttribute("userprojectlist", userprojectlist);
		

	}
%>