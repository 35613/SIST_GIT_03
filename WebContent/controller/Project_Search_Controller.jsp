<%@page import="bean.TagBean"%>
<%@ page import="bean.UserBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.TagDAO" %>
<%@ page import="bean.ProjectBean" %>
<%@ page import="dao.ProjectDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    UserBean userBean = (UserBean)session.getAttribute("userBean");
    System.out.println( userBean);

  //태그 전체불러오기
    TagDAO tagDAO = TagDAO.getInstance();
    ArrayList<String> taglist = new ArrayList<String>();
    taglist = tagDAO.do_search_tag();
    request.setAttribute("taglist", taglist);
	
    String command = request.getParameter("command");
   System.out.println( command);
    if(command.equals("전체")){
    	//전체 프로젝트 가져오기
        ProjectDAO projectDAO = ProjectDAO.getInstance();
        ArrayList<ProjectBean> projectlist = new ArrayList<ProjectBean>();
        projectlist = projectDAO.do_search_openproject(userBean.getEmail());
        request.setAttribute("projectlist", projectlist);

        pageContext.forward("/view/nonPopup/projectsearch.jsp");
    }else if(command.equals("이름")){
    	//이름으로 검색된 프로젝트만 가져오기
    	ProjectDAO projectDAO = ProjectDAO.getInstance();
    	String srch = request.getParameter("srch");
        ArrayList<ProjectBean> projectlist = projectDAO.do_search_name(srch, userBean.getEmail());
        request.setAttribute("projectlist", projectlist);
        pageContext.forward("/view/nonPopup/projectsearch.jsp");
        
    }else if(command.equals("태그")){
    	//태그로 검색된 프로젝트만 가져오기
		ArrayList<String> picktagList = new ArrayList<String>();
		String projecttag[] = request.getParameterValues("projecttag");

		for(int i = 0 ; i < projecttag.length; i++ ){
			picktagList.add(projecttag[i]);
		}
    	ProjectDAO projectDAO = ProjectDAO.getInstance();
        ArrayList<ProjectBean> projectlist = new ArrayList<ProjectBean>();
        projectlist = projectDAO.do_search_openproject_tag(picktagList, userBean.getEmail());
        request.setAttribute("projectlist", projectlist);
        
        pageContext.forward("/view/nonPopup/projectsearch.jsp");
    }
   

    
    
    
    

%>