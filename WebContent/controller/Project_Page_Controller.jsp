<%@ page import="bean.ProjectBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="dao.MembersDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    UserBean userBean = new UserBean();
    userBean = (UserBean)session.getAttribute("userBean");

    // 탈퇴버튼 클릭시
    String command = request.getParameter("command");
    if (command != null) {
        if (command.equals("leave")) {
            int projectseq = Integer.parseInt(request.getParameter("projectseq"));
            MembersDAO membersDAO = MembersDAO.getInstance();
            if (membersDAO.do_delete_member(projectseq, userBean.getEmail())) {
                request.setAttribute("result", "success");

                UserDAO userDAO = UserDAO.getInstance();
                ArrayList<ProjectBean> projectlist = new ArrayList<ProjectBean>();
                projectlist = userDAO.do_search_userproject(userBean.getEmail());

                session.setAttribute("userprojectlist", projectlist);
            }
            else {
                request.setAttribute("result", "fail");
            }
        }
    }

   ;
    pageContext.forward("/view/nonPopup/projectpage.jsp");
    
    
    
    
%>