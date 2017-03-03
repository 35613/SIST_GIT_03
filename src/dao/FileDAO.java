package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.BoardBean;
import bean.FileBean;

public class FileDAO extends SuperDAO implements DAO {

    private static FileDAO dao;

    private FileDAO() {
        super.init();
    }

    public static FileDAO getInstance() {
        if (dao == null) {
            dao = new FileDAO();
        }
        return dao;
    }


    @Override
    public boolean do_insert(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;

        FileBean fileBean = (FileBean)bean;

        String sql = "INSERT INTO FILES (FILE_SEQ, ORIGINAL_FILE_NAME, STORED_FILE_NAME, POST_SEQ, PROJECT_SEQ)"+ 
                "VALUES (FILE_SEQ.NEXTVAL, ?, ?,(SELECT MAX(POST_SEQ) FROM BOARDBASE), ?)";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success do_insert_file");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, fileBean.getOriginal_file_name());
            psmt.setString(2, fileBean.getStored_file_name());
            psmt.setInt(3, fileBean.getProject_seq());

            log("3/6 Success do_insert_file");

            count = psmt.executeUpdate();
            log("4/6 Success do_insert_file");

        } catch (SQLException e) {
            log("Fail do_insert_file", e);

        } finally {
            this.close(conn, psmt, null);
            log("5/6 Success do_insert_file");
        }
        return (count > 0) ? true : false;
    }

    public FileBean do_search_file(int post_seq) {

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;


        String sql = " SELECT ORIGINAL_FILE_NAME, STORED_FILE_NAME, FILE_SEQ "
                + " FROM FILES "
                + " WHERE POST_SEQ = ? ";
        
        FileBean bean = new FileBean();
        try {
            conn = getConnection();
            log("2/6 Success do_search_file");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, post_seq);
            log("3/6 Success do_search_file");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_file");


            while (rs.next()) {
                
                bean.setOriginal_file_name(rs.getString(1));
                bean.setStored_file_name(rs.getString(2));
                bean.setFile_seq(rs.getInt(3));
            }

        } catch (SQLException e) {
            log("Fail do_search_file", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_file");

        return bean;

    }

    public boolean do_update_file(int post_seq, ArrayList<FileBean> fileList) {
        Connection conn = null;
        PreparedStatement psmt = null;

        String sql1 = " DELETE FROM FILES "
                + " WHERE POST_SEQ = ? ";

        String sql2 = " INSERT INTO FILES ( FILE_SEQ, ORIGINAL_FILE_NAME, STORED_FILE_NAME, POST_SEQ, PROJECT_SEQ ) "
                + " VALUES ( FILE_SEQ.NEXTVAL, ?, ?, ?, ? ) ";

        int count = 0;

        try{
            conn = getConnection();
            conn.setAutoCommit(false);
            log("2/6 Success do_update_user");

            psmt=conn.prepareStatement(sql1);
            psmt.setInt(1, post_seq);
            log("3/6 Success do_update_user");

            count = psmt.executeUpdate();
            log("4/6 Success do_update_user");

            psmt.clearParameters();
            for (int i = 0; i < fileList.size(); i++) {
                psmt=conn.prepareStatement(sql2);
                psmt.setString(1, fileList.get(i).getOriginal_file_name());
                psmt.setString(2, fileList.get(i).getStored_file_name());
                psmt.setInt(3, fileList.get(i).getPost_seq());
                psmt.setInt(4, fileList.get(i).getProject_seq());
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

    @Override
    public boolean do_update(Object bean) {
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

    @Override
    public boolean do_delete(Object bean) {
        return false;
    }

}
