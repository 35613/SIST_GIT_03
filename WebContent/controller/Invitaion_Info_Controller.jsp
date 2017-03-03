<%@page import="dao.ProjectDAO"%>
<%@page import="dao.MessageDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="dao.MembersDAO"%>
<%@page import="dao.TagDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.InvitationBean"%>
<%@page import="bean.ProjectBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	String command = request.getParameter("command");

	//invitelist에서  seq  받아옴
	int seq = Integer.parseInt(request.getParameter("seq"));

	//리스트에 담아
	MessageDAO dao = MessageDAO.getInstance();

	UserBean userBean = new UserBean();
	userBean = (UserBean) session.getAttribute("userBean");
	request.setAttribute("userBean", userBean);


	InvitationBean invitationBean = dao.do_search_detail_invitation(seq);

	if (command != null) {
		if (command.equals("수락")) {
			InvitationBean bean = new InvitationBean();
			bean.setInvite_seq(seq);
			dao.do_update_invitation(bean);

			MembersDAO memdao = MembersDAO.getInstance();
			memdao.do_insert_member(bean.getProject_seq(), bean.getEmail());


			ProjectDAO pjdao = ProjectDAO.getInstance();
			ProjectBean projectBean = new ProjectBean();
			projectBean = pjdao.do_search(invitationBean.getProject_seq());

			ArrayList<ProjectBean> userprojectlist = new ArrayList<>();
			userprojectlist = (ArrayList<ProjectBean>)session.getAttribute("userprojectlist");
			userprojectlist.add(projectBean);
			session.setAttribute("userprojectlist", userprojectlist);

		} else if (command.equals("거부")) {
			//이름으로 검색된 프로젝트만 가져오기
			InvitationBean bean = new InvitationBean();
			bean.setInvite_seq(seq);
			dao.do_update_invitation(bean);

		}

		%>

		<script type="text/javascript">
			window.opener.location.reload();
			window.open('','_parent','');window.close();
		</script>

		<%

	} else {

		//프로젝트 내용
		int projectseq = invitationBean.getProject_seq();
		ProjectDAO projectdao = ProjectDAO.getInstance();
		ProjectBean projectbean = projectdao.do_search(projectseq);

		//개발인원
		MembersDAO memberdao = MembersDAO.getInstance();
		ArrayList<UserBean> memberlist = memberdao.do_search(projectseq);

		//유져 태그
		TagDAO tagdao = TagDAO.getInstance();
		ArrayList<String> taglist = tagdao.do_search_projecttag(projectseq);

		//보내주장
		request.setAttribute("bean", invitationBean);
		request.setAttribute("projectbean", projectbean);
		request.setAttribute("memberlist", memberlist);
		request.setAttribute("taglist", taglist);

		pageContext.forward("/view/popup/invitation.jsp");
	}
	
%>

			
