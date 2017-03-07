package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		FileBean fileBean = (FileBean) bean;
		String sql = "INSERT INTO FILES (FILE_SEQ, ORIGINAL_FILE_NAME, STORED_FILE_NAME, POST_SEQ, PROJECT_SEQ)VALUES (FILE_SEQ.NEXTVAL, ?, ?,(SELECT MAX(POST_SEQ) FROM BOARDBASE), ?)";
		int count = 0;

		try {
			conn = this.getConnection();
			this.log("2/6 Success do_insert_file");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, fileBean.getOriginal_file_name());
			psmt.setString(2, fileBean.getStored_file_name());
			psmt.setInt(3, fileBean.getProject_seq());
			this.log("3/6 Success do_insert_file");
			count = psmt.executeUpdate();
			this.log("4/6 Success do_insert_file");
		} catch (SQLException arg10) {
			this.log("Fail do_insert_file", arg10);
		} finally {
			this.close(conn, psmt, (ResultSet) null);
			this.log("5/6 Success do_insert_file");
		}

		return count > 0;
	}

	public FileBean do_search_file(int post_seq) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT ORIGINAL_FILE_NAME, STORED_FILE_NAME, FILE_SEQ  FROM FILES  WHERE POST_SEQ = ? ";
		FileBean bean = new FileBean();

		try {
			conn = this.getConnection();
			this.log("2/6 Success do_search_file");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, post_seq);
			this.log("3/6 Success do_search_file");
			rs = psmt.executeQuery();
			this.log("4/6 Success do_search_file");

			while (rs.next()) {
				bean.setOriginal_file_name(rs.getString(1));
				bean.setStored_file_name(rs.getString(2));
				bean.setFile_seq(rs.getInt(3));
			}
		} catch (SQLException arg10) {
			this.log("Fail do_search_file", arg10);
		} finally {
			this.close(conn, psmt, rs);
		}

		this.log("6/6 Success do_search_file");
		return bean;
	}

	public boolean do_update_file(int post_seq, ArrayList<FileBean> fileList) {
		Connection conn = null;
		PreparedStatement psmt = null;
		String sql1 = " DELETE FROM FILES  WHERE POST_SEQ = ? ";
		String sql2 = " INSERT INTO FILES ( FILE_SEQ, ORIGINAL_FILE_NAME, STORED_FILE_NAME, POST_SEQ, PROJECT_SEQ )  VALUES ( FILE_SEQ.NEXTVAL, ?, ?, ?, ? ) ";
		int count = 0;

		try {
			conn = this.getConnection();
			conn.setAutoCommit(false);
			this.log("2/6 Success do_update_user");
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, post_seq);
			this.log("3/6 Success do_update_user");
			count = psmt.executeUpdate();
			this.log("4/6 Success do_update_user");
			psmt.clearParameters();

			for (int e = 0; e < fileList.size(); ++e) {
				psmt = conn.prepareStatement(sql2);
				psmt.setString(1, ((FileBean) fileList.get(e)).getOriginal_file_name());
				psmt.setString(2, ((FileBean) fileList.get(e)).getStored_file_name());
				psmt.setInt(3, ((FileBean) fileList.get(e)).getPost_seq());
				psmt.setInt(4, ((FileBean) fileList.get(e)).getProject_seq());
				count = psmt.executeUpdate();
				psmt.clearParameters();
			}

			this.log("5/6 Success do_update_user");
			conn.commit();
			this.log("6/6 Success do_update_user");
		} catch (SQLException arg19) {
			this.log("Fail do_update_user", arg19);

			try {
				conn.rollback();
			} catch (SQLException arg18) {
				;
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException arg17) {
				;
			}

			this.log("end Success do_update_user");
		}

		return count > 0;
	}

	public boolean do_update(Object bean) {
		return false;
	}

	public boolean do_upsert(Object bean) {
		return false;
	}

	public boolean do_detail(Object bean) {
		return false;
	}

	public boolean do_delete(Object bean) {
		return false;
	}
}