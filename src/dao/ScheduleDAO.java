package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.BoardBean;
import bean.BoardCommentBean;
import bean.ProjectCommentBean;
import bean.ProjectScheduleBean;
import bean.UserBean;
import bean.UserCommentBean;
import bean.UserScheduleBean;

public class ScheduleDAO extends SuperDAO implements DAO {

   private static ScheduleDAO dao;

   private ScheduleDAO() {
      super.init();
   }

   public static ScheduleDAO getInstance() {
      if (dao == null) {
         dao = new ScheduleDAO();
      }
      return dao;
   }

   /**
    * 오늘 개인 일정 받아오는 메소드   ////////////////////////////// 테스트 필요
    *
    * @author seongki
    * @return scheduleList
    */
   public ArrayList<UserScheduleBean> do_search_todayuser(String email, String today) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT * " +
                " FROM MYSCHEDULE " +
                " WHERE EMAIL = ? AND ISDELETED = 'N' AND DODATE = ? ";

        ArrayList<UserScheduleBean> scheduleList = new ArrayList<UserScheduleBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_schedule");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            psmt.setString(2, today);
            log("3/6 Success do_search_schedule");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_schedule");

            while (rs.next()) {
                UserScheduleBean bean = new UserScheduleBean();
                bean.setMyschedule_seq(rs.getInt(1));
                bean.setDodate(rs.getString(2));
                bean.setReason(rs.getString(3));
                bean.setPublicrange(rs.getString(4));
                bean.setProgress(rs.getInt(5));
                bean.setTitle(rs.getString(6));
                bean.setIsdeleted(rs.getString(7));
                bean.setEmail(rs.getString(8));

                scheduleList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_schedule", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_schedule");

        return scheduleList;

   }
   

   /**
     * 오늘 프로젝트 일정 받아오는 메소드   ////////////////////////////// 테스트 필요
     *
     * @author seongki
     * @return scheduleList
     */
    public ArrayList<ProjectScheduleBean> do_search_todayproject(String email, String today) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT A.*, B.PROJECTNAME " +
                " FROM PROJECTSCHEDULE A " +
                " INNER JOIN PROJECTS B " +
                " ON (A.PROJECT_SEQ = B.PROJECT_SEQ) " +
                " WHERE DOPERSON = ? AND ISDELETED = 'N' AND DODATE = ? ";

        ArrayList<ProjectScheduleBean> scheduleList = new ArrayList<ProjectScheduleBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_schedule");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            psmt.setString(2, today);
            log("3/6 Success do_search_schedule");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_schedule");

            while (rs.next()) {
                ProjectScheduleBean bean = new ProjectScheduleBean();
                bean.setPjschedule_seq(rs.getInt(1));
                bean.setDodate(rs.getString(2));
                bean.setWriter(rs.getString(3));
                bean.setDoperson(rs.getString(4));
                bean.setReason(rs.getString(5));
                bean.setProgress(rs.getInt(6));
                bean.setProject_seq(rs.getInt(7));
                bean.setIsdeleted(rs.getString(8));
                bean.setTitle(rs.getString(9));
                bean.setProjectname(rs.getString(10));

                scheduleList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_schedule", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_schedule");

        return scheduleList;

    }
    /**
     * 개인 일정 전체 받아오는 메소드   ////////////////////////////// 테스트 필요
     *
     * @author seongki
     * @return scheduleList
     */
    public ArrayList<UserScheduleBean> do_search_userschedule(String email) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT  MYSCHEDULE_SEQ, DODATE, REASON, PUBLICRANGE, PROGRESS, TITLE, ISDELETED, EMAIL"
                 + " FROM MYSCHEDULE " 
              +
                " WHERE EMAIL = ? AND ISDELETED = 'N' ";

        ArrayList<UserScheduleBean> scheduleList = new ArrayList<UserScheduleBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_schedule");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            log("3/6 Success do_search_schedule");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_schedule");

            while (rs.next()) {
                UserScheduleBean bean = new UserScheduleBean();
                bean.setMyschedule_seq(rs.getInt(1));
                bean.setDodate(rs.getString(2));
                bean.setReason(rs.getString(3));
                bean.setPublicrange(rs.getString(4));
                bean.setProgress(rs.getInt(5));
                bean.setTitle(rs.getString(6));
                bean.setIsdeleted(rs.getString(7));
                bean.setEmail(rs.getString(8));

                scheduleList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_schedule", e);

        } finally {
            this.close(conn, psmt, rs);
        }
        log("6/6 Success do_search_schedule");

        return scheduleList;

    }

    /**
     * 개인일정 시퀀스로 받아오는 메소드
     * @param seq
     * @return
     */
    
	public UserScheduleBean do_search_user_detail(int seq) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT  MYSCHEDULE_SEQ, DODATE, REASON, PUBLICRANGE, PROGRESS, TITLE, ISDELETED, EMAIL"
                + " FROM MYSCHEDULE " 
                +  " WHERE MYSCHEDULE_SEQ = ? ";
		UserScheduleBean bean = new UserScheduleBean();

		try {
			conn = getConnection();
			log("2/6 Success do_search_user_detail");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq); // DB에서 꺼내오기작업
			
			log("3/6 Success do_search_user_detail");

			rs = psmt.executeQuery();
			log("4/6 Success do_search_user_detail");

			while (rs.next()) {
				bean.setMyschedule_seq(rs.getInt(1));
				bean.setDodate(rs.getString(2));
				bean.setReason(rs.getString(3));
				bean.setPublicrange(rs.getString(4));
				bean.setProgress(rs.getInt(5));
				bean.setTitle(rs.getString(6));
				bean.setIsdeleted(rs.getString(7));
				bean.setEmail(rs.getString(8));

			}
			log("5/6 Success do_search_user_detail");

		} catch (SQLException e) {
			log("Fail do_search_user_detail", e);
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 Success do_search_user_detail");
		}
		return bean;
	}

    /**
     * 프로젝트일정 시퀀스로 받아오는 메소드
     * @param seq
     * @return
     */

    public ProjectScheduleBean do_search_project_detail(int seq) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;


        String sql = " SELECT  PJSCHEDULE_SEQ, DODATE, WRITER, DOPERSON, REASON, PROGRESS, PROJECT_SEQ, ISDELETED, TITLE  "
                + " FROM PROJECTSCHEDULE "
                +  " WHERE PJSCHEDULE_SEQ = ? ";

        ProjectScheduleBean bean = new ProjectScheduleBean();

        try {
            conn = getConnection();
            log("2/6 Success do_search_user_detail");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, seq); // DB에서 꺼내오기작업

            log("3/6 Success do_search_user_detail");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_user_detail");

            while (rs.next()) {
                bean.setPjschedule_seq(rs.getInt(1));
                bean.setDodate(rs.getString(2));
                bean.setWriter(rs.getString(3));
                bean.setDoperson(rs.getString(4));
                bean.setReason(rs.getString(5));
                bean.setProgress(rs.getInt(6));
                bean.setProject_seq(rs.getInt(7));
                bean.setIsdeleted(rs.getString(8));
                bean.setTitle(rs.getString(9));
            }
            log("5/6 Success do_search_user_detail");

        } catch (SQLException e) {
            log("Fail do_search_user_detail", e);
        } finally {
            this.close(conn, psmt, rs);
            log("6/6 Success do_search_user_detail");
        }
        return bean;
    }
    
    /**
     * 가입한 모든 프로젝트일정 리스트로 받아오는 메소드
     * @param email
     * @return
     */
    
    public ArrayList<ProjectScheduleBean> do_search_all_projectschedule(String email) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT A.PJSCHEDULE_SEQ, A.DODATE, A.WRITER, A.DOPERSON, A.REASON, A.PROJECT_SEQ, A.ISDELETED, A.TITLE "
                 + " FROM PROJECTSCHEDULE A INNER JOIN MEMBERS B " 
                 + " ON(A.PROJECT_SEQ = B.PROJECT_SEQ) "
                 + " INNER JOIN CUSTOMUSER C "
                 + " ON(B.EMAIL = C.EMAIL) "
                 + " WHERE C.EMAIL = ? " ;

        ArrayList<ProjectScheduleBean> projectscheduleList = new ArrayList<ProjectScheduleBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_all_projectschedule");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            log("3/6 Success do_search_all_projectschedule");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_all_projectschedule");

            while (rs.next()) {
               ProjectScheduleBean bean = new ProjectScheduleBean();
                bean.setPjschedule_seq(rs.getInt(1));
                bean.setDodate(rs.getString(2));
                bean.setWriter(rs.getString(3));
                bean.setDoperson(rs.getString(4));
                bean.setReason(rs.getString(5));
                bean.setProject_seq(rs.getInt(6));
                bean.setIsdeleted(rs.getString(7));
                bean.setTitle(rs.getString(8));

                projectscheduleList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_all_projectschedule", e);

        } finally {
            this.close(conn, psmt, rs);
        }
        log("6/6 Success do_search_all_projectschedule");

        return projectscheduleList;

    }
    
    

    /**
     * 개인일정 쓰기 메소드                  // 창건 수정
     * @return (count > 0) ? true : false;
     */

    public boolean do_insert_userschedule(Object bean) {

        Connection conn = null;
        PreparedStatement psmt = null;

        String sql = " INSERT INTO MYSCHEDULE(MYSCHEDULE_SEQ, TITLE, REASON, PUBLICRANGE, EMAIL, DODATE ) "
                + " VALUES (MYSCHEDULE_SEQ.NEXTVAL, ?, ?, ?, ?, ?) ";

        UserScheduleBean userscheduleBean = (UserScheduleBean)bean;

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success Callist");

            psmt = conn.prepareStatement(sql);

            psmt.setString(1, userscheduleBean.getTitle());
            psmt.setString(2, userscheduleBean.getReason());
            psmt.setString(3, userscheduleBean.getPublicrange());
            psmt.setString(4, userscheduleBean.getEmail());
            psmt.setString(5, userscheduleBean.getDodate());

            log("3/6 Success Callist");

            count = psmt.executeUpdate();
            log("4/6 Success Callist");

        } catch (SQLException e) {
            log("Fail Callist", e);

        } finally {
            this.close(conn, psmt, null);

        }

        return (count > 0) ? true : false;
    }

   /**
    * 개인일정 댓글 보기 메소드               // 태영 수정
    *
    * @return userCommentList
    */
    public ArrayList<UserCommentBean> do_search_usercomment(int myschedule_seq){

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT B.WRITER, B.CONTENTSS, B.DATES, C.NICKNAME, C.IMAGE "
                + " FROM MYSCHEDULE A "
                + " INNER JOIN USERCOMMENT B "
                + " ON( A.MYSCHEDULE_SEQ = B.SCHEDULE_SEQ) "
                + " INNER JOIN CUSTOMUSER C "
                + " ON(B.WRITER = C.EMAIL) "
                + " WHERE A.MYSCHEDULE_SEQ = ? "
                + " ORDER BY B.DATES DESC";

        ArrayList<UserCommentBean> userCommentList = new ArrayList<UserCommentBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_usercomment");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, myschedule_seq);
            log("3/6 Success do_search_usercomment");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_usercomment");

            while (rs.next()) {
                UserCommentBean bean = new UserCommentBean();
                bean.setWriter(rs.getString(1));
                bean.setContentss(rs.getString(2));
                bean.setDates(rs.getString(3));
                bean.setWriternickname(rs.getString(4));
                bean.setWriterimage(rs.getString(5));
                userCommentList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_usercomment", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_usercomment");

        return userCommentList;
    }


   /**
    * 개인일정 댓글 쓰기 메소드                       // 태영 수정
    *
    * @return (count > 0) ? true : false;
    */

   public boolean do_insert_usercomment(UserCommentBean bean) {

      Connection conn = null;
      PreparedStatement psmt = null;

      String sql = " INSERT INTO USERCOMMENT(COMMENT_SEQ, SCHEDULE_SEQ, WRITER, CONTENTSS) "
            + " VALUES(MYCOMMENT_SEQ.NEXTVAL, ?, ?, ?) ";

      UserCommentBean usercommentBean = bean;

      int count = 0;

      try {
         conn = getConnection();
         log("2/6 Success insert_usercomment");

         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, usercommentBean.getSchedule_seq());
         psmt.setString(2, usercommentBean.getWriter());
         psmt.setString(3, usercommentBean.getContentss());
         log("3/6 Success insert_usercomment");

         count = psmt.executeUpdate();
         log("4/6 Success insert_usercomment");

      } catch (SQLException e) {
         log("Fail insert_usercomment", e);

      } finally {
         this.close(conn, psmt, null);

      }

      return (count > 0) ? true : false;
   }

    /**
     * 프로젝트 일정 쓰기 메소드                      // 창건 수정
     * @return count > 0 ? true : false;
     */

    public boolean do_insert_projectschedule(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = " INSERT INTO PROJECTSCHEDULE(PJSCHEDULE_SEQ, DODATE, WRITER, DOPERSON, REASON, PROJECT_SEQ, TITLE) "
                + "  VALUES(PJSCHEDULE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?) ";

        int count = 0;

        ProjectScheduleBean projectscheduleBean = (ProjectScheduleBean)bean;

        try {
            conn = getConnection();
            log("2/6 Success do_insert_projectcomment");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, projectscheduleBean.getDodate());
            psmt.setString(2, projectscheduleBean.getWriter());
            psmt.setString(3, projectscheduleBean.getDoperson());
            psmt.setString(4, projectscheduleBean.getReason());
            psmt.setInt(5, projectscheduleBean.getProject_seq());
            psmt.setString(6, projectscheduleBean.getTitle());
            log("3/6 Success do_insert_projectcomment");

            count = psmt.executeUpdate();

            log("4/6 Success do_insert_projectcomment");
        } catch (SQLException e) {
            log("Fail do_insert_projectcomment", e);

        } finally {
            close(conn, psmt, null);
            log("5/6 Success do_insert_projectcomment");
        }
        return count > 0 ? true : false;
    }

   /**
    * 프로젝트일정 수정 메소드        // 창건 수정
    *
    * @return count > 0 ? true : false;
    */
   public boolean do_update_projectschedule(Object bean) {
      Connection conn = null;
      PreparedStatement psmt = null;
      String sql = " UPDATE PROJECTSCHEDULE " +
                " SET DOPERSON = ?, REASON = ?, PROGRESS = ?, TITLE = ?, DODATE = ? " +
                " WHERE PJSCHEDULE_SEQ=? ";
      int count = 0;

      ProjectScheduleBean projectscheduleBean = (ProjectScheduleBean) bean;

      try {
         conn = getConnection();
         log("2/6 Success do_update_projectschedule");

         psmt = conn.prepareStatement(sql);
         psmt.setString(1, projectscheduleBean.getDoperson());
         psmt.setString(2, projectscheduleBean.getReason());
         psmt.setInt(3, projectscheduleBean.getProgress());
         psmt.setString(4, projectscheduleBean.getTitle());
            psmt.setString(5, projectscheduleBean.getDodate());
         psmt.setInt(6, projectscheduleBean.getPjschedule_seq());

         log("3/6 Success do_update_projectschedule");

         count = psmt.executeUpdate();
         log("4/6 Success do_update_projectschedule");
      } catch (SQLException e) {
         log("Fail do_update_projectschedule", e);

      } finally {
         close(conn, psmt, null);
         log("5/6 Success do_update_projectschedule");
      }
      return count > 0 ? true : false;
   }

   /**
    * 개인일정 수정 메소드                      // 태영 수정
    *
    * @return count > 0 ? true : false;
    */
    public boolean do_update_userschedule(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = " UPDATE MYSCHEDULE  "
                + " SET TITLE = ?, REASON = ?, PROGRESS = ?, PUBLICRANGE = ?"
                + " WHERE MYSCHEDULE_SEQ = ? ";
        int count = 0;

        UserScheduleBean userscheduleBean = (UserScheduleBean)bean;


        try {
            conn = getConnection();
            log("2/6 Success do_update_userschedule");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, userscheduleBean.getTitle());
            psmt.setString(2, userscheduleBean.getReason());
            psmt.setInt(3, userscheduleBean.getProgress());
            psmt.setString(4, userscheduleBean.getPublicrange());
            psmt.setInt(5, userscheduleBean.getMyschedule_seq());

            log("3/6 Success do_update_userschedule");

            count = psmt.executeUpdate();
            log("4/6 Success do_update_userschedule");
        } catch (SQLException e) {
            log("Fail do_update_userschedule", e);

        } finally {
            close(conn, psmt, null);
            log("5/6 Success do_update_userschedule");
        }
        return count > 0 ? true : false;
    }


    /**
     * 프로젝트일정 삭제 메소드            // 창건 수정
     * @return count > 0 ? true : false;
     */
    public boolean do_delete_projectschedule(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = " UPDATE PROJECTSCHEDULE "
                + " SET ISDELETED = 'Y' "
                + " WHERE PJSCHEDULE_SEQ= ? ";
        int count = 0;

        ProjectScheduleBean projectscheduleBean = (ProjectScheduleBean)bean;


        try {
            conn = getConnection();
            log("2/6 Success do_delete_projectschedule");

            psmt = conn.prepareStatement(sql);

            psmt.setInt(1, projectscheduleBean.getPjschedule_seq());

            log("3/6 Success do_delete_projectschedule");

            count = psmt.executeUpdate();
            log("4/6 Success do_delete_projectschedule");
        } catch (SQLException e) {
            log("Fail do_delete_projectschedule", e);

        } finally {
            close(conn, psmt, null);
            log("5/6 Success do_delete_projectschedule");
        }
        return count > 0 ? true : false;
    }

   /**
    * 프로젝트일정 댓글 쓰는 메소드             ////////////////////////// 테스트 필요
    *
    * @return count > 0 ? true : false;
    */
   public boolean do_insert_projectcomment(Object bean) {
      Connection conn = null;
      PreparedStatement psmt = null;
      String sql = " INSERT INTO PROJECTCOMMENT(COMMENT_SEQ, SCHEDULE_SEQ, WRITER, CONTENTSS) "
            + " VALUES(PJCOMMENT_SEQ.NEXTVAL, ?, ?, ?) ";

      int count = 0;

      ProjectCommentBean projectcommentscheduleBean = (ProjectCommentBean) bean;

      try {
         conn = getConnection();
         log("2/6 Success do_insert_projectcomment");

         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, projectcommentscheduleBean.getSchedule_seq());
         psmt.setString(2, projectcommentscheduleBean.getWriter());
         psmt.setString(3, projectcommentscheduleBean.getContentss());
         log("3/6 Success do_insert_projectcomment");

         count = psmt.executeUpdate();
         log("4/6 Success do_insert_projectcomment");
      } catch (SQLException e) {
         log("Fail do_insert_projectcomment", e);

      } finally {
         close(conn, psmt, null);
         log("5/6 Success do_insert_projectcomment");
      }
      return count > 0 ? true : false;
   }

    /**
     * 프로젝트일정 댓글 읽어오는 메소드           // 창건 수정
     * @return projectcomentList
     */
    public ArrayList<ProjectCommentBean> do_search_projectcomment(int seq) {

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT B.WRITER, B.CONTENTSS, B.DATES  "
                + " FROM PROJECTSCHEDULE A INNER JOIN PROJECTCOMMENT B  "
                + " ON( A.PJSCHEDULE_SEQ = B.SCHEDULE_SEQ) "
                + " WHERE A.PJSCHEDULE_SEQ = ? "
                + " ORDER BY B.DATES DESC";

        ArrayList<ProjectCommentBean> projectcomentList = new ArrayList<ProjectCommentBean>();

        try{
            conn = getConnection();
            log("2/6 Success do_search_projectcomment");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, seq);
            log("3/6 Success do_search_projectcomment");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_projectcomment");
            while(rs.next()){
                ProjectCommentBean bean = new ProjectCommentBean();
                bean.setWriter(rs.getString(1));
                bean.setContentss(rs.getString(2));
                bean.setDates(rs.getString(3));

                projectcomentList.add(bean);
            }
            log("5/6 Success do_search_projectcomment");
        } catch (SQLException e) {
            log("Fail userList", e);
        } finally {
            this.close(conn, psmt, rs);
            log("6/6 Success do_search_projectcomment");
        }
        return projectcomentList;
    }

    /**
     * 프로젝트 일정 하나만 읽어오는 메소드      // 창건 수정
     * @return projectscheduleList
     */

    public ArrayList<ProjectScheduleBean> do_search_projectschedule(int setPjschedule_seq) {

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT PJSCHEDULE_SEQ, DODATE, WRITER, DOPERSON, REASON, PROJECT_SEQ, ISDELETED, TITLE, PROGRESS  "
                + " FROM PROJECTSCHEDULE  "
                + " WHERE PROJECT_SEQ = ? ";

        ArrayList<ProjectScheduleBean> projectscheduleList = new ArrayList<ProjectScheduleBean>();

        try{
            conn = getConnection();
            log("2/6 Success do_search_projectschedule");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, setPjschedule_seq);
            log("3/6 Success do_search_projectschedule");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_projectschedule");
            while(rs.next()){
                ProjectScheduleBean bean = new ProjectScheduleBean();
                bean.setPjschedule_seq(rs.getInt(1));
                bean.setDodate(rs.getString(2));
                bean.setWriter(rs.getString(3));
                bean.setDoperson(rs.getString(4));
                bean.setReason(rs.getString(5));
                bean.setProject_seq(rs.getInt(6));
                bean.setIsdeleted(rs.getString(7));
                bean.setTitle(rs.getString(8));
                bean.setProgress(rs.getInt(9));
                projectscheduleList.add(bean);
            }
            log("5/6 Success do_search_projectschedule");
        } catch (SQLException e) {
            log("Fail userList", e);
        } finally {
            this.close(conn, psmt, rs);
            log("6/6 Success do_search_projectschedule");
        }
        return projectscheduleList;
    }

   /**
    * 개인일정 삭제          // 태영 수정
    */

    public boolean do_delete_userschedule(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = " UPDATE MYSCHEDULE   "
                + " SET ISDELETED = 'Y' "
                + " WHERE MYSCHEDULE_SEQ = ? ";
        int count = 0;

        UserScheduleBean userscheduleBean = (UserScheduleBean)bean;


        try {
            conn = getConnection();
            log("2/6 Success do_delete_projectschedule");

            psmt = conn.prepareStatement(sql);

            psmt.setInt(1, userscheduleBean.getMyschedule_seq());

            log("3/6 Success do_delete_projectschedule");

            count = psmt.executeUpdate();
            log("4/6 Success do_delete_projectschedule");
        } catch (SQLException e) {
            log("Fail do_delete_projectschedule", e);

        } finally {
            close(conn, psmt, null);
            log("5/6 Success do_delete_projectschedule");
        }
        return count > 0 ? true : false;
    }

   @Override
   public boolean do_insert(Object bean) {
      return false;
   }

   @Override
   public boolean do_update(Object bean) {
      return false;
   }

   @Override
   public boolean do_delete(Object bean) {
      return false;
   }

   @Override
   public boolean do_upsert(Object bean) {
      return false;
   }

   @Override
   public boolean do_detail(Object bean) {
      return false;
   }
}