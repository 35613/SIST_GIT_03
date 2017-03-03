package dao;

import java.sql.*;
import java.util.ArrayList;

import bean.ProjectBean;
import bean.UserBean;
import oracle.net.aso.s;


public class MembersDAO extends SuperDAO implements DAO {

    private static MembersDAO dao;

    private MembersDAO() {
        super.init();
    }
    

    public static MembersDAO getInstance() {
        if (dao == null) {
            dao = new MembersDAO();
        }
        return dao;
    }

    // 마지막으로 생성된 프로젝트 시퀀스값 가져오는 메소드
    public int do_search_projectseq() {
        int pjseq = 0;

        Connection conn = null;
        Statement statementmt = null;
        ResultSet rs = null;
        String sql = " SELECT MAX(PROJECT_SEQ) " +
                "  FROM PROJECTS ";

        try{
            conn = getConnection();

            statementmt = conn.createStatement();
            log("3/6 Success do_search_joinproject");

            rs = statementmt.executeQuery(sql);
            log("4/6 Success do_search_joinproject");
            while(rs.next()){
               pjseq = rs.getInt(1);
            }
            log("5/6 Success do_search_joinproject");
        } catch (SQLException e) {
            log("Fail userList", e);
        } finally {
            this.close(conn, statementmt, rs);
            log("6/6 Success do_search_joinproject");
        }
        return pjseq;
    }

    //가입된 회원 가져오는 메소드
    public ArrayList<UserBean> do_search(int project_seq) {

    	Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT B.NICKNAME, B.EMAIL, B.IMAGE "
        		   + " FROM MEMBERS A "
                   + " INNER JOIN CUSTOMUSER B"
                   + " ON (A.EMAIL = B.EMAIL) "
                   + " where A.PROJECT_SEQ = ? ";
        ArrayList<UserBean> userList = new ArrayList<UserBean>();

        try{
            conn = getConnection();
   			log("2/6 Success userList");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, project_seq);
            log("3/6 Success userList");   
            
            rs = psmt.executeQuery();
            log("4/6 Success userList");        
            while(rs.next()){
            	UserBean bean = new UserBean();
            	bean.setNickname(rs.getString(1));
				bean.setEmail(rs.getString(2));
                bean.setImage(rs.getString(3));
            
            	userList.add(bean);
            }
   			log("5/6 Success userList");
   		} catch (SQLException e) {
   			log("Fail userList", e);
   		} finally {
   			this.close(conn, psmt, rs);
   			log("6/6 Success userList");
   		}
   		return userList;
    }
    
    //가입한 프로젝트 리스트 가져오기
    public ArrayList<ProjectBean> do_search_joinproject(String email) {

    	Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT B.IMAGE, B.PROJECTNAME, B.README, B.PROGRESS, B.PROJECT_SEQ, B.ISEND "
        		   + " FROM MEMBERS A "
                   + " INNER JOIN PROJECTS B"
                   + " ON (A.PROJECT_SEQ = B.PROJECT_SEQ) "
                   + " WHERE A.EMAIL = ?"
                   + " ORDER BY B.STARTDATE DESC";
        
        ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();

        try{
            conn = getConnection();
   			log("2/6 Success do_search_joinproject");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            log("3/6 Success do_search_joinproject");   
            
            rs = psmt.executeQuery();
            log("4/6 Success do_search_joinproject");        
            while(rs.next()){
            	ProjectBean bean = new ProjectBean();
            	bean.setImage(rs.getString(1));
            	bean.setProjectname(rs.getString(2));
            	bean.setReadme(rs.getString(3));
            	bean.setProgress(rs.getInt(4));
            	bean.setProject_seq(rs.getInt(5));
            	bean.setIsend(rs.getString(6));
            	projectList.add(bean);
            }
   			log("5/6 Success do_search_joinproject");
   		} catch (SQLException e) {
   			log("Fail userList", e);
   		} finally {
   			this.close(conn, psmt, rs);
   			log("6/6 Success do_search_joinproject");
   		}
   		return projectList;
    }

    //프로젝트 가입시
    public boolean do_insert_member(int project_seq, String email) {
    	Connection conn = null;
		PreparedStatement psmt = null;
		String sql = " INSERT INTO MEMBERS (PROJECT_SEQ, EMAIL) "
				+ " VALUES ( ?, ? ) ";
		int count = 0;

		try {
			conn = getConnection();
			log("2/6 Success do_insert_member");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, project_seq);
			psmt.setString(2, email);
			log("3/6 Success do_insert_member");

			count = psmt.executeUpdate();
			log("4/6 Success do_insert_member");
		} catch (SQLException e) {
			log("Fail do_insert_member", e);

		} finally {
			close(conn, psmt, null);
			log("5/6 Success do_insert_member");
		}
		return count > 0 ? true : false;
	}

    //받은 hidden parameter가 탈퇴면
    public boolean do_delete_member(int project_seq, String email) {
        Connection conn = null;
        PreparedStatement psmt = null;
        String sql = " DELETE FROM MEMBERS "
                + " WHERE EMAIL = ? AND PROJECT_SEQ = ? ";
        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success do_delete_member");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            psmt.setInt(2, project_seq);
            log("3/6 Success do_delete_member");

            count = psmt.executeUpdate();
            log("4/6 Success do_delete_member");

        } catch (SQLException e) {
            log("Fail do_delete_member", e);

        } finally {
            close(conn, psmt, null);
            log("5/6 Success do_insert_member");
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
