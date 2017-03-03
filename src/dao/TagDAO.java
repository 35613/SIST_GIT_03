package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import bean.TagBean;


public class TagDAO extends SuperDAO implements DAO {

    private static TagDAO dao;

    private TagDAO() {
        super.init();
    }

    public static TagDAO getInstance() {
        if (dao == null) {
            dao = new TagDAO();
        }
        return dao;
    }
    
    
    //유져 테그 서치 메소드
    public ArrayList<TagBean> do_search(String email) {
    	Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT B.TAGNAME " 
        		   + " FROM CUSTOMUSER A  "
                   + " INNER JOIN USER_TAG B"
                   + " ON(A.EMAIL = B.EMAIL) "
                   + "WHERE A.EMAIL = ?";

        ArrayList<TagBean> usertagList = new ArrayList<TagBean>();

        try{
            conn = getConnection();
   			log("2/6 Success userList");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
            log("3/6 Success userList");   
            
            rs = psmt.executeQuery();
            log("4/6 Success userList");        
            while(rs.next()){
            	TagBean bean = new TagBean();
            	bean.setTagname(rs.getString(1));
            	usertagList.add(bean);
            }
   			log("5/6 Success userList");
   		} catch (SQLException e) {
   			log("Fail userList", e);
   		} finally {
   			this.close(conn, psmt, rs);
   			log("6/6 Success userList");
   		}
   		return usertagList;
    }
    
    //프로젝트 태그 서치 메소드
    public ArrayList<String> do_search_projecttag(int project_seq) {
    	Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT TAGNAME " 
        		   + " FROM PROJECT_TAG "
                   + "WHERE PROJECT_SEQ = ?";
        
        ArrayList<String> projecttagList = new ArrayList<String>();

        try{
            conn = getConnection();
   			log("2/6 Success userList");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, project_seq);
            log("3/6 Success userList");   
            
            rs = psmt.executeQuery();
            log("4/6 Success userList");        
            while(rs.next()){
            	projecttagList.add(rs.getString(1));
            }
   			log("5/6 Success userList");
   		} catch (SQLException e) {
   			log("Fail userList", e);
   		} finally {
   			this.close(conn, psmt, rs);
   			log("6/6 Success userList");
   		}
   		return projecttagList;
    }    
    
    //모든 테그 가져오기 검색시 사용
    public ArrayList<String> do_search_tag() {
    	Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        String sql = " SELECT TAGNAME " 
        		   + " FROM TAGS " ;
      
        ArrayList<String> tagList = new ArrayList<String>();

        try{
            conn = getConnection();
   			log("2/6 Success userList");

            psmt = conn.prepareStatement(sql);
       
            log("3/6 Success userList");   
            
            rs = psmt.executeQuery();
            log("4/6 Success userList");        
            while(rs.next()){
            	tagList.add(rs.getString(1));
            }
   			log("5/6 Success userList");
   		} catch (SQLException e) {
   			log("Fail userList", e);
   		} finally {
   			this.close(conn, psmt, rs);
   			log("6/6 Success userList");
   		}
   		return tagList;
    } 
    
    //유져 테그 업데이트
    public boolean do_update_user(String email, ArrayList<TagBean> tagList) {
    	Connection conn = null;
		PreparedStatement psmt = null;

		String sql1 = " DELETE FROM USER_TAG "
				+ " WHERE EMAIL = ? ";

		String sql2 = " INSERT INTO USER_TAG ( EMAIL, TAGNAME ) "
				+ " VALUES ( ?, ? ) ";

		int count = 0;
		try{
			conn = getConnection();
			conn.setAutoCommit(false);
			log("2/6 Success do_update_user");	
			
			psmt=conn.prepareStatement(sql1);
			psmt.setString(1, email);
			log("3/6 Success do_update_user");
			
			count = psmt.executeUpdate();
			log("4/6 Success do_update_user");
			
			psmt.clearParameters();
            for (int i = 0; i < tagList.size(); i++) {
            	psmt=conn.prepareStatement(sql2);
            	psmt.setString(1, email);
    			psmt.setString(2, tagList.get(i).getTagname());
    			count = psmt.executeUpdate();	
    			psmt.clearParameters();
            }
			log("5/6 Success do_update_user");
			conn.commit();
			log("6/6 Success do_update_user");		
					
			
		}catch(SQLException e){
			log("Fail do_update_user", e);
			try{
				conn.rollback();
			}catch(SQLException ex){}
			
		}finally{
			try{
				conn.setAutoCommit(true);				
			}catch(SQLException e){}
			log("end Success do_update_user");
		}		
		
		return count > 0 ? true : false;
	}

    //프로젝트 테그 업데이트
    public boolean do_update_project(int seq, ArrayList<TagBean> tagList) {
    	Connection conn = null;
		PreparedStatement psmt = null;

		String sql1 = " DELETE FROM PROJECT_TAG "
				+ " WHERE PROJECT_SEQ = ? ";

		String sql2 = " INSERT INTO PROJECT_TAG ( PROJECT_SEQ, TAGNAME ) "
				+ " VALUES ( ?, ? ) ";

		int count = 0;
		try{
			conn = getConnection();
			conn.setAutoCommit(false);
			log("2/6 Success do_update");	
			
			psmt=conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			log("3/6 Success do_update");
			count = psmt.executeUpdate();
			log("4/6 Success do_update");
			psmt.clearParameters();
			
            
            for (int i = 0; i < tagList.size(); i++) {
            	
            	psmt=conn.prepareStatement(sql2);
            	psmt.setInt(1, seq);
    			psmt.setString(2, tagList.get(i).getTagname());
    			count = psmt.executeUpdate();	
    			psmt.clearParameters();
            }
			log("5/6 Success do_update");
			conn.commit();
			log("6/6 Success do_update");				
			
		}catch(SQLException e){
			log("Fail do_update", e);
			try{
				conn.rollback();
			}catch(SQLException ex){}
			
		}finally{
			try{
				conn.setAutoCommit(true);				
			}catch(SQLException e){}
			log("end Success do_update");
		}		
		
		return count>0?true:false;
	}


    @Override
    public boolean do_insert(Object bean) {
        return true;
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
