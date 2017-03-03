package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.ApplicationBean;
import bean.InvitationBean;

/**
 * 
 * 
 * 
 * @author 박진완
 *
 */

public class MessageDAO extends SuperDAO implements DAO {

    private static MessageDAO dao;

    private MessageDAO() {
        super.init();
    }

    public static MessageDAO getInstance() {
        if (dao == null) {
            dao = new MessageDAO();
        }
        return dao;
    }

    public ArrayList<ApplicationBean> do_search_application(String email){

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT A.APPL_SEQ, A.SENDID, A.CONTENTSS, A.APPLY_DATE, "
        		+ " A.PROJECT_SEQ, A.CONFIRMED, A.EMAIL, B.PROJECTNAME "
                + " FROM APPLICATION A INNER JOIN PROJECTS B "
                + " ON(A.PROJECT_SEQ = B.PROJECT_SEQ) "
                + " WHERE A.EMAIL = ? AND CONFIRMED = 'N' ";

        ArrayList<ApplicationBean> list = new ArrayList<ApplicationBean>();	//리턴돼서 넘어 가는 리스트

        try {
            conn = getConnection();
            log("2/6 success do_search_application");
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            log("3/6 success do_search_application");

            rs = psmt.executeQuery();
            log("4/6 success do_search_application");

            while(rs.next()){
                ApplicationBean dto = new ApplicationBean();
                dto.setAppl_seq(rs.getInt(1));
                dto.setSendid(rs.getString(2));
                dto.setContentss(rs.getString(3));
                dto.setApply_date(rs.getString(4));
                dto.setProject_seq(rs.getInt(5));
                dto.setConfirmed(rs.getString(6));
                dto.setEmail(rs.getString(7));
                dto.setProjectname(rs.getString(8));
                list.add(dto);
            }
            log("5/6 success do_search_application");

        } catch (SQLException e) {
            log("fail do_search_application", e);
        }finally {
            close(conn, psmt, rs);
            log("6/6 success do_search_application");
        }

        return list;
    }
    
    public ApplicationBean do_search_detail_application(int seq){

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT A.APPL_SEQ, A.SENDID, A.CONTENTSS, A.APPLY_DATE, A.CONFIRMED, A.PROJECT_SEQ, A.EMAIL, B.PROJECTNAME "
        			+ " FROM APPLICATION A INNER JOIN PROJECTS B "
        			+ " ON(A.PROJECT_SEQ = B.PROJECT_SEQ) "
        			+ " WHERE APPL_SEQ = ? ";

        ApplicationBean bean = new ApplicationBean();
        try {
            conn = getConnection();
            log("2/6 success do_search_detail_application");
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, seq);
            log("3/6 success do_search_detail_application");

            rs = psmt.executeQuery();
            log("4/6 success do_search_detail_application");

            while(rs.next()){
                
                bean.setAppl_seq(rs.getInt(1));
                bean.setSendid(rs.getString(2));
                bean.setContentss(rs.getString(3));
                bean.setApply_date(rs.getString(4));
                bean.setConfirmed(rs.getString(5));
                bean.setProject_seq(rs.getInt(6));
                bean.setEmail(rs.getString(7));
                bean.setProjectname(rs.getString(8));
                
            }
            log("5/6 success do_search_detail_application");

        } catch (SQLException e) {
            log("fail do_search_detail_application", e);
        }finally {
            close(conn, psmt, rs);
            log("6/6 success do_search_detail_application");
        }

        return bean;
    }
    
    

    public ArrayList<InvitationBean> do_search_invitation(String email){

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql =  " SELECT A.INVITE_SEQ, A.INVITE_DATE, A.EMAIL, A.CONFIRMED, A.PROJECT_SEQ, B.PROJECTNAME  "
                + " FROM INVITATION A INNER JOIN PROJECTS B"
                + " ON(A.PROJECT_SEQ = B.PROJECT_SEQ) "
                + " WHERE EMAIL =? AND CONFIRMED = 'N' ";


        ArrayList<InvitationBean> list = new ArrayList<InvitationBean>();

        try {
            conn = getConnection();
            log("2/6 success do_search_application");
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            log("3/6 success do_search_application");

            rs = psmt.executeQuery();
            log("4/6 success do_search_application");

            while(rs.next()){
                InvitationBean dto = new InvitationBean();
                dto.setInvite_seq(rs.getInt(1));
                dto.setInvite_date(rs.getString(2));
                dto.setEmail(rs.getString(3));
                dto.setConfirmed(rs.getString(4));
                dto.setProject_seq(rs.getInt(5));
                dto.setProjectname(rs.getString(6));
                
                list.add(dto);

            }
            log("5/6 success do_search_application");

        } catch (SQLException e) {
            log("fail do_search_application", e);
        }finally {
            close(conn, psmt, rs);
            log("5/6 success do_search_application");
        }

        return list;
    }

    public InvitationBean do_search_detail_invitation(int seq){

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql =" SELECT A.INVITE_SEQ, A.INVITE_DATE, A.EMAIL, A.CONFIRMED, A.PROJECT_SEQ, B.PROJECTNAME "
                + " FROM INVITATION A INNER JOIN PROJECTS B"
                + " ON(A.PROJECT_SEQ = B.PROJECT_SEQ) "
                + " WHERE A.INVITE_SEQ =? ";


        InvitationBean bean = new InvitationBean();
        try {
            conn = getConnection();
            log("2/6 success do_search_application");
            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, seq);
            log("3/6 success do_search_application");

            rs = psmt.executeQuery();
            log("4/6 success do_search_application");

            while(rs.next()){
                bean.setInvite_seq(rs.getInt(1));
                bean.setInvite_date(rs.getString(2));
                bean.setEmail(rs.getString(3));
                bean.setConfirmed(rs.getString(4));
                bean.setProject_seq(rs.getInt(5));
                bean.setProjectname(rs.getString(6));
 
            }
            log("5/6 success do_search_application");

        } catch (SQLException e) {
            log("fail do_search_application", e);
        }finally {
            close(conn, psmt, rs);
            log("5/6 success do_search_application");
        }

        return bean;
    }
    
    
    
    public boolean do_upsert_application(Object bean){

        Connection conn = null;
        PreparedStatement psmt = null;

        ApplicationBean applicationBean = (ApplicationBean)bean;

        String sql = " MERGE INTO APPLICATION "
                + " USING DUAL "
                + " ON (SENDID = ? AND PROJECT_SEQ = ?) "
                + " WHEN MATCHED THEN "
                + " UPDATE SET APPLY_DATE = SYSDATE, CONFIRMED = 'N', CONTENTSS = ? "
                + " WHEN NOT MATCHED THEN "
                + " INSERT (APPL_SEQ, SENDID, CONTENTSS, PROJECT_SEQ, EMAIL) "
                + " VALUES(APPL_SEQ.NEXTVAL, ?, ?, ?, ?) ";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 success do_upsert_invitation");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, applicationBean.getSendid());
            psmt.setInt(2, applicationBean.getProject_seq());
            psmt.setString(3, applicationBean.getContentss());
            psmt.setString(4, applicationBean.getSendid());
            psmt.setString(5, applicationBean.getContentss());
            psmt.setInt(6, applicationBean.getProject_seq());
            psmt.setString(7, applicationBean.getEmail());

            log("3/6 success do_upsert_invitation");

            count = psmt.executeUpdate();
            log("4/6 success do_upsert_invitation");

        } catch (SQLException e) {
            log("fail success do_upsert_invitation",e);
        }finally {
            close(conn, psmt, null);
            log("5/6 success do_upsert_invitation");
        }

        return count>0?true:false;
    }

    public boolean do_upsert_invitation(Object bean){

        Connection conn = null;
        PreparedStatement psmt = null;

        InvitationBean invitationBean = (InvitationBean)bean;

        String sql = " MERGE INTO INVITATION "
                + " USING DUAL "
                + " ON (EMAIL = ? AND PROJECT_SEQ = ?) "
                + " WHEN MATCHED THEN "
                + " UPDATE SET INVITE_DATE = SYSDATE, CONFIRMED = 'N' "
                + " WHEN NOT MATCHED THEN "
                + " INSERT (INVITE_SEQ, PROJECT_SEQ, EMAIL) "
                + " VALUES(INVIT_SEQ.NEXTVAL, ?, ?) ";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 success do_upsert_invitation");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, invitationBean.getEmail());
            psmt.setInt(2, invitationBean.getProject_seq());
            psmt.setInt(3, invitationBean.getProject_seq());
            psmt.setString(4, invitationBean.getEmail());


            log("3/6 success do_upsert_invitation");

            count = psmt.executeUpdate();
            log("4/6 success do_upsert_invitation");

        } catch (SQLException e) {
            log("fail success do_upsert_invitation",e);
        }finally {
            close(conn, psmt, null);
            log("5/6 success do_upsert_invitation");
        }

        return count>0?true:false;
    }

    public boolean do_update_application(Object bean){
    	
    	Connection conn = null;
		PreparedStatement psmt = null;
		
		ApplicationBean applicationBean =(ApplicationBean)bean;
    
        String sql =  " UPDATE APPLICATION "
        			+ " SET CONFIRMED = 'Y' "
        			+ " WHERE APPL_SEQ = ? ";

    	int count = 0;
    
    	try {
			conn = getConnection();
			log("2/6 success addCalendar");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, applicationBean.getAppl_seq());
			log("3/6 success addCalendar");
			
			count = psmt.executeUpdate();
			log("4/6 success addCalendar");
			
		} catch (SQLException e) {
			log("fail success addCalendar",e);
		}finally {
			close(conn, psmt, null);
			log("5/6 success addCalendar");
		}
		
		return count>0?true:false;
    }
    
    public boolean do_update_invitation(Object bean){
    	
    	Connection conn = null;
		PreparedStatement psmt = null;
		
		InvitationBean invitationBean =(InvitationBean)bean;
		
        String sql =  " UPDATE INVITATION "
        			+ " SET CONFIRMED = 'Y' "
        			+ " WHERE INVITE_SEQ = ? ";

    	int count = 0;
    
    	try {
			conn = getConnection();
			log("2/6 success do_update_invitation");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, invitationBean.getInvite_seq());
			log("3/6 success do_update_invitation");
			
			count = psmt.executeUpdate();
			log("4/6 success do_update_invitation");
			
		} catch (SQLException e) {
			log("fail success do_update_invitation",e);
		}finally {
			close(conn, psmt, null);
			log("5/6 success do_update_invitation");
		}
		
		return count>0?true:false;
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
