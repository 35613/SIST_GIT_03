<%@page import="bean.UserCommentBean"%>
<%@page import="dao.ScheduleDAO"%>
<%@page import="bean.UserScheduleBean"%>
<%@ page import="bean.UserBean"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%	
	UserBean userBean = (UserBean) session.getAttribute("userBean");
	int seq = Integer.parseInt(request.getParameter("myseq"));
	
	String comment = request.getParameter("comment");
	String command = request.getParameter("command");
	
	ScheduleDAO dao = ScheduleDAO.getInstance();

	/* 
	if (command != null) {
		if (command.equals("댓글쓰기")) {
			UserCommentBean userCommentBean = new UserCommentBean();
			userCommentBean.setContentss(comment);
			userCommentBean.setWriter(userBean.getEmail());
			userCommentBean.setSchedule_seq(seq); 
			userCommentBean.setWriternickname(userBean.getNickname());
			userCommentBean.setWriterimage(userBean.getImage());
			

			dao.do_insert_usercomment(userCommentBean);
		}
	} */

	// 버튼 수정 삭제
	UserScheduleBean uscBean = dao.do_search_user_detail(seq);
	
	if (command != null) {
		if (command.equals("update")) {
			UserScheduleBean bean = new UserScheduleBean();
			bean.setMyschedule_seq(seq);
			bean.setDodate(request.getParameter("dodate"));
			bean.setTitle(request.getParameter("title"));
			bean.setReason(request.getParameter("reason"));
			dao.do_update_userschedule(bean);
			%>
			<script type="text/javascript">
				window.opener.location.reload();
				window.open('','_parent','');window.close();
			</script>
			<%
			
		} else if (command.equals("delete")) {
			UserScheduleBean bean = new UserScheduleBean();
			bean.setMyschedule_seq(seq);
			bean.setDodate(request.getParameter("dodate"));
			bean.setTitle(request.getParameter("title"));
			bean.setReason(request.getParameter("reason"));
			dao.do_delete_userschedule(bean);

			%>
			<script type="text/javascript">
				window.opener.location.reload();
				window.open('','_parent','');window.close();
			</script>
			<%
		
		} else if (command.equals("댓글쓰기")) {
			UserCommentBean userCommentBean = new UserCommentBean();
			userCommentBean.setContentss(comment);
			userCommentBean.setWriter(userBean.getEmail());
			userCommentBean.setSchedule_seq(seq); 
			userCommentBean.setWriternickname(userBean.getNickname());
			userCommentBean.setWriterimage(userBean.getImage());
			
			dao.do_insert_usercomment(userCommentBean);

			UserScheduleBean userScheduleBean = new UserScheduleBean();
			userScheduleBean = dao.do_search_user_detail(seq);

			//댓글들 리스트 읽어오는 부분
			ArrayList<UserCommentBean> commentlist = new ArrayList<UserCommentBean>();
			commentlist = dao.do_search_usercomment(seq);


			request.setAttribute("commentlist", commentlist);
			request.setAttribute("userScheduleBean", userScheduleBean);

			pageContext.forward("/view/popup/scheduledetail.jsp");
		}
	} else {
		UserScheduleBean userScheduleBean = new UserScheduleBean();
		userScheduleBean = dao.do_search_user_detail(seq);

		//댓글들 리스트 읽어오는 부분
		ArrayList<UserCommentBean> commentlist = new ArrayList<UserCommentBean>();
		commentlist = dao.do_search_usercomment(seq);


		request.setAttribute("commentlist", commentlist);
		request.setAttribute("userScheduleBean", userScheduleBean);

		pageContext.forward("/view/popup/scheduledetail.jsp");
	}
	
%>









