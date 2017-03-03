package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.BoardBean;
import bean.ProjectBean;
import bean.TagBean;

public class ProjectDAO extends SuperDAO implements DAO {

	private static ProjectDAO dao;

	private ProjectDAO() {
		super.init();
	}

	public static ProjectDAO getInstance() {
		if (dao == null) {
			dao = new ProjectDAO();
		}
		return dao;
	}

	public ProjectBean do_search(int seq) {
		// TODO  시퀀스로 프로젝트 정보 검색하는 메소드
		ProjectBean bean = new ProjectBean();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT PROJECT_SEQ,PROJECTNAME,LEADER,TO_CHAR(STARTDATE, 'yyyy-mm-dd'),TO_CHAR(ENDDATE, 'yyyy-mm-dd') ,PROGRESS,README,ISOPEN,IMAGE,ISEND \n");
			sql.append("FROM PROJECTS                                  \n");
			sql.append("WHERE PROJECT_SEQ = ?                          \n");
			 conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt " + psmt.toString());
			System.out.println("2 sql=" + sql.toString());
			psmt.setInt(1, seq);

			rs = psmt.executeQuery();

			while (rs.next()) {

				bean.setProject_seq(rs.getInt(1));
				bean.setProjectname(rs.getString(2));
				bean.setLeader(rs.getString(3));
				bean.setStartdate(rs.getString(4));
				bean.setEnddate(rs.getString(5));
				bean.setProgress(rs.getInt(6));
				bean.setReadme(rs.getString(7));
				bean.setIsopen(rs.getString(8));
				bean.setImage(rs.getString(9));
				bean.setIsend(rs.getString(10));

				

			}
			System.out.println("Project_seq=" + bean.getProject_seq());
			System.out.println("setProjectname=" + bean.getProjectname());
			System.out.println("LEADER=" + bean.getLeader());
			System.out.println("STARTDATE=" + bean.getStartdate());
			System.out.println("ENDDATE  =" + bean.getEnddate());
			System.out.println("PROGRESS =" + bean.getProgress());
			System.out.println("README   =" + bean.getReadme());
			System.out.println("ISOPEN   =" + bean.getIsopen());
			System.out.println("IMAGE    =" + bean.getImage());
			System.out.println("ISEND    =" + bean.getIsend());
			
			
		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			this.close(conn, psmt, rs);
		}

		return bean;
	}

	public ArrayList<ProjectBean> do_search_name(String srch, String email) {
		// TODO  프로젝트 명으로 가입가능한 프로젝트 검색하는 메소드
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();


		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT PROJECT_SEQ, PROJECTNAME, LEADER, STARTDATE, ENDDATE, PROGRESS, README, ISOPEN, IMAGE, ISEND        \n");
			sql.append(" FROM PROJECTS                                  															\n");
			sql.append(" WHERE PROJECTNAME LIKE ? AND ISOPEN ='Y'                    												\n");
			sql.append("    		      AND PROJECT_SEQ IN (SELECT PROJECT_SEQ             										\n");
			sql.append("                                      FROM (SELECT PROJECT_SEQ, MAX(EMAIL) AS MEMAIL						\n");
			sql.append("                                            FROM MEMBERS													\n");
			sql.append("                                            GROUP BY PROJECT_SEQ)											\n");
			sql.append("                                      WHERE PROJECT_SEQ NOT IN (SELECT PROJECT_SEQ 							\n");
			sql.append("																FROM MEMBERS								\n");
			sql.append("																WHERE EMAIL = ? ))							\n");

			srch = "%" + srch + "%";
			conn = getConnection();
			
			psmt = conn.prepareStatement(sql.toString());
			psmt.setString(1, srch);
			psmt.setString(2, email);

			rs = psmt.executeQuery();

			while (rs.next()) {
				ProjectBean bean = new ProjectBean();
				bean.setProject_seq(rs.getInt(1));
				bean.setProjectname(rs.getString(2));
				bean.setLeader(rs.getString(3));
				bean.setStartdate(rs.getString(4));
				bean.setEnddate(rs.getString(5));
				bean.setProgress(rs.getInt(6));
				bean.setReadme(rs.getString(7));
				bean.setIsopen(rs.getString(8));
				bean.setImage(rs.getString(9));
				bean.setIsend(rs.getString(10));
				list.add(bean);
				

			}
			
			
		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			this.close(conn, psmt, rs);
		}

		return list;
	}

	// TODO  프로젝트보드 글 가져오기
	public ArrayList<BoardBean> do_search_pjboard(int pjseq, int pageNum) {
        final int PAGE_SIZE = 20;
        int PAGE_NUM = pageNum;

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT TT1.* " +
                " FROM( " +
                " SELECT ROWNUM 글번호, T1.* " +
                " FROM( " +
                "       SELECT B.WRITER, A.PROJECTNAME, B.CONTENTSS, B.POST_SEQ, B.PROJECT_SEQ,C.NICKNAME" +
                "       FROM PROJECTS A	INNER JOIN BOARDBASE B ON (A.PROJECT_SEQ = B.PROJECT_SEQ),CUSTOMUSER C " +
                "       WHERE A.PROJECT_SEQ = ? AND B.ISDELETED = 'N' AND B.WRITER = C.EMAIL " +
                "       ORDER BY B.WRITEDATE DESC " +
                "   )T1 " +
                " )TT1 " +
                " WHERE 글번호 BETWEEN ( ? * ( ? - 1 ) + 1 ) AND (( ? * (?-1))+? ) ";

        ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_boardlist");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, pjseq);
            psmt.setInt(2, PAGE_SIZE);
            psmt.setInt(3, PAGE_NUM);
            psmt.setInt(4, PAGE_SIZE);
            psmt.setInt(5, PAGE_NUM);
            psmt.setInt(6, PAGE_SIZE);
            log("3/6 Success do_search_boardlist");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_boardlist");

            while (rs.next()) {
                BoardBean bean = new BoardBean();
                bean.setWriter(rs.getString(2));
                bean.setProjectname(rs.getString(3));
                bean.setContentss(rs.getString(4));
                bean.setPost_seq(rs.getInt(5));
                bean.setProject_seq(rs.getInt(6));
                bean.setWriternickname(rs.getString(7));
                boardList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_boardlist", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_boardlist");

        return boardList;
    }
	// TODO  열린 프로젝트 가져오기
	public ArrayList<ProjectBean> do_search_openproject(String email) {
		

		ArrayList<ProjectBean> pjlist = new ArrayList<ProjectBean>();


		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try{
			String sql =
					" SELECT A.PROJECT_SEQ, A.LEADER, A.PROJECTNAME, A.README, A.PROGRESS, A.IMAGE " +
					" FROM PROJECTS A " +
					" WHERE A.ISOPEN = 'Y' AND PROJECT_SEQ IN (SELECT PROJECT_SEQ " +
					"                                          FROM (SELECT PROJECT_SEQ, MAX(EMAIL) AS MEMAIL" +
					"                                                FROM MEMBERS" +
					"                                                GROUP BY PROJECT_SEQ)" +
					"                                          WHERE PROJECT_SEQ NOT IN (SELECT PROJECT_SEQ FROM MEMBERS WHERE EMAIL = ? ))" +
					" ORDER BY A.PROJECT_SEQ ";

			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, email);


			rs = psmt.executeQuery();
			
			while (rs.next()) {
				ProjectBean pjbean = new ProjectBean();
				pjbean.setProject_seq(rs.getInt(1));
				pjbean.setLeader(rs.getString(2));
				pjbean.setProjectname(rs.getString(3));
				pjbean.setReadme(rs.getString(4));
				pjbean.setProgress(rs.getInt(5));
				pjbean.setImage(rs.getString(6));

				pjlist.add(pjbean);

			}

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			this.close(conn, psmt, rs);
		}

		return pjlist;
	}

	public ArrayList<ProjectBean> do_search_openproject_tag(ArrayList<String> taglist, String email) {
		// TODO  선택한 태그로 프로젝트 정보 검색하는 메소드

		ArrayList<ProjectBean> pjlist = new ArrayList<ProjectBean>();
		

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

        try{
    		StringBuilder sql = new StringBuilder();
    		sql.append("    		      SELECT PROJECT_SEQ ,LEADER, PROJECTNAME , README , PROGRESS , IMAGE			\n");
    		sql.append("    		      FROM PROJECTS										                            \n");
    		sql.append("    		      WHERE ISOPEN = 'Y'					                                        \n");
    		sql.append("    		      AND PROJECT_SEQ IN                                        					\n");
    		sql.append("    	                                            (SELECT PROJECT_SEQ                         \n");
    		sql.append("    	                                             FROM PROJECT_TAG                           \n");
    		sql.append("    	                                             WHERE TAGNAME IN(              	    	\n");
    		for (int i = 0; i < taglist.size(); i++) {
    			if (i == 0) {
    				sql.append("?");
    			}else{
    				sql.append(", ?");
    			}
    		}
    		sql.append("    	                                             )GROUP BY PROJECT_SEQ                      \n");
    		sql.append("    	                                             HAVING COUNT(*) >= ?)						\n");
			sql.append("    		      AND PROJECT_SEQ IN (SELECT PROJECT_SEQ             							\n");
			sql.append("                                      FROM (SELECT PROJECT_SEQ, MAX(EMAIL) AS MEMAIL			\n");
			sql.append("                                            FROM MEMBERS										\n");
			sql.append("                                            GROUP BY PROJECT_SEQ)								\n");
			sql.append("                                      WHERE PROJECT_SEQ NOT IN (SELECT PROJECT_SEQ 				\n");
			sql.append("																FROM MEMBERS					\n");
			sql.append("																WHERE EMAIL = ? ))				\n");
    		sql.append("    		      ORDER BY PROJECT_SEQ DESC										                \n");

			System.out.println(sql.toString());
			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			int num = 1;
			for (int i = 0; i < taglist.size(); i++) {
				psmt.setString(num++, taglist.get(i));
    		}
			
			psmt.setInt(num++, taglist.size());
			psmt.setString(num++, email);
			
			
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				ProjectBean pjbean = new ProjectBean();
				pjbean.setProject_seq(rs.getInt(1));
				pjbean.setLeader(rs.getString(2));
				pjbean.setProjectname(rs.getString(3));
				pjbean.setReadme(rs.getString(4));
				pjbean.setProgress(rs.getInt(5));
				pjbean.setImage(rs.getString(6));
				System.out.println(pjbean.toString());

				pjlist.add(pjbean);
				
			}
			
		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			this.close(conn, psmt, rs);
		}

		return pjlist;
	}

	@Override
	public boolean do_insert(Object bean) {
		// TODO  프로젝트 생성 메소드
		ProjectBean pjbean = (ProjectBean) bean;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int retInt = 0;
		boolean flag = false;

		try {
			
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO PROJECTS  (PROJECT_SEQ            \n");
			sql.append("                      ,    PROJECTNAME        \n");
			sql.append("                      ,    LEADER             \n");
			sql.append("                      ,    STARTDATE          \n");
			sql.append("                      ,    ENDDATE            \n");
			sql.append("                      ,    README             \n");
			sql.append("                      ,    ISOPEN   	      \n");
			sql.append("                      ,    IMAGE )  	      \n");
			sql.append("                VALUES(PROJECT_SEQ.nextval	  \n");
			sql.append("                      ,?                      \n");
			sql.append("                      ,?                      \n");
			sql.append("                      ,?                      \n");
			sql.append("                      ,?                      \n");
			sql.append("                      ,?                      \n");
			sql.append("                      ,?                      \n");
			sql.append("                      ,?                      \n");
			sql.append("                      )                       \n");
			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			log("2/6 Success do_search_boardlist");
			System.out.println("1 psmt" + psmt.toString());
			System.out.println("2 sql=" + sql.toString());
			psmt.setString(1, pjbean.getProjectname());
			psmt.setString(2, pjbean.getLeader());
			psmt.setString(3, pjbean.getStartdate());
			psmt.setString(4, pjbean.getEnddate());
			psmt.setString(5, pjbean.getReadme());
			psmt.setString(6, "N");
			psmt.setString(7, "N");


			
			retInt = psmt.executeUpdate();

			System.out.println("Project_seq=" + pjbean.getProject_seq());
			System.out.println("LEADER=" + pjbean.getLeader());
			System.out.println("STARTDATE=" + pjbean.getStartdate());
			System.out.println("ENDDATE  =" + pjbean.getEnddate());
			System.out.println("PROGRESS =" + pjbean.getProgress());
			System.out.println("README   =" + pjbean.getReadme());
			System.out.println("ISOPEN   =" + pjbean.getIsopen());
			System.out.println("IMAGE    =" + pjbean.getImage());
			System.out.println("ISEND    =" + pjbean.getIsend());

		} catch (Exception e) {
			System.out.println("실패 : " + e);
			return false;
		} finally {
			this.close(conn, psmt, rs);
		}
		if (retInt > 0)
			flag = true;
		return flag;
	}

	@Override
	public boolean do_update(Object bean) {
		// TODO  프로젝트 수정 메소드
		ProjectBean pjbean = (ProjectBean) bean;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int retInt = 0;
		boolean flag = false;
		try {

			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE  PROJECTS SET PROJECTNAME = ?            \n");
			sql.append("     ,               LEADER      = ?            \n");
			sql.append("     ,               STARTDATE   = ?            \n");
			sql.append("     ,               ENDDATE     = ?            \n");
			sql.append("     ,               PROGRESS    = ?            \n");
			sql.append("     ,               README      = ?            \n");
			sql.append("     ,               ISOPEN      = ?            \n");
			sql.append("     ,               IMAGE       = ?            \n");
			sql.append("	           WHERE PROJECT_SEQ = ?  	          ");
			 conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("sql=" + sql.toString());


			psmt.setString(1, pjbean.getProjectname());
			psmt.setString(2, pjbean.getLeader());
			psmt.setString(3, pjbean.getStartdate());
			psmt.setString(4, pjbean.getEnddate());
			psmt.setInt(5, pjbean.getProgress());
			psmt.setString(6, pjbean.getReadme());
			psmt.setString(7, pjbean.getIsopen());
			psmt.setString(8, pjbean.getImage());
			psmt.setInt(9, pjbean.getProject_seq());
			retInt = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("실패 : " + e);
			return false;
		} finally {
			this.close(conn, psmt, rs);
		}
		System.out.println("성공");
		if (retInt > 0)
			flag = true;
		return flag;

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
