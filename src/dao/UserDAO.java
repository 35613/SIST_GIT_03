package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.ProjectBean;
import bean.UserBean;

public class UserDAO extends SuperDAO implements DAO {
	private static UserDAO dao;

	private UserDAO() {
		super.init();
	}

	public static UserDAO getInstance() {
		if (dao == null) {
			dao = new UserDAO();
		}

		return dao;
	}

	public UserBean do_search_userinfo(String email, String pw) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT EMAIL, PW, NICKNAME, USERNAME, PHONE, ADDRESS, WEB, PUBLICRANGE, INVITE, IMAGE FROM CUSTOMUSER WHERE EMAIL = ? AND PW = ?";
		UserBean bean = new UserBean();

		try {
			conn = this.getConnection();
			this.log("2/6 Success userList");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			psmt.setString(2, pw);
			this.log("3/6 Success userList");
			rs = psmt.executeQuery();
			this.log("4/6 Success userList");

			while (rs.next()) {
				bean.setEmail(rs.getString("EMAIL"));
				bean.setPw(rs.getString("PW"));
				bean.setNickname(rs.getString("NICKNAME"));
				bean.setUsername(rs.getString("USERNAME"));
				bean.setPhone(rs.getString("PHONE"));
				bean.setAddress(rs.getString("ADDRESS"));
				bean.setWeb(rs.getString("WEB"));
				bean.setPublicrange(rs.getString("PUBLICRANGE"));
				bean.setImage(rs.getString("IMAGE"));
				bean.setInvite(rs.getString("INVITE"));
			}

			this.log("5/6 Success userList");
		} catch (SQLException arg11) {
			this.log("Fail userList", arg11);
		} finally {
			this.close(conn, psmt, rs);
			this.log("6/6 Success userList");
		}

		return bean;
	}

	public ArrayList<ProjectBean> do_search_userproject(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT B.*  FROM MEMBERS A \tINNER JOIN PROJECTS B \tON (A.PROJECT_SEQ = B.PROJECT_SEQ) \tWHERE A.EMAIL = ? AND B.ISEND = \'N\' ";
		ArrayList projectList = new ArrayList();

		try {
			conn = this.getConnection();
			this.log("2/6 Success do_search_userproject");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			this.log("3/6 Success do_search_userproject");
			rs = psmt.executeQuery();
			this.log("4/6 Success do_search_userproject");

			while (rs.next()) {
				ProjectBean e = new ProjectBean();
				e.setProject_seq(rs.getInt(1));
				e.setProjectname(rs.getString(2));
				e.setLeader(rs.getString(3));
				e.setStartdate(rs.getString(4));
				e.setEnddate(rs.getString(5));
				e.setProgress(rs.getInt(6));
				e.setReadme(rs.getString(7));
				e.setIsopen(rs.getString(8));
				e.setImage(rs.getString(9));
				e.setIsend(rs.getString(10));
				projectList.add(e);
			}
		} catch (SQLException arg10) {
			this.log("Fail do_search_userproject", arg10);
		} finally {
			this.close(conn, psmt, rs);
		}

		this.log("6/6 Success do_search_userproject");
		return projectList;
	}

	public boolean do_search_id(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT EMAIL  FROM CUSTOMUSER  WHERE EMAIL =? ";
		String serch_id = "";

		try {
			conn = this.getConnection();
			this.log("2/6 Success serch_id");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			this.log("3/6 Success serch_id");
			rs = psmt.executeQuery();
			this.log("4/6 Success serch_id");

			while (rs.next()) {
				serch_id = rs.getString(1);
			}

			this.log("5/6 Success serch_id");
		} catch (SQLException arg10) {
			this.log("Faild serch_id", arg10);
		} finally {
			this.close(conn, psmt, rs);
			this.log("6/6 Success serch_id");
		}

		return serch_id != null && !serch_id.equals("");
	}

	public boolean do_insert_user(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		UserBean userBean = (UserBean) bean;
		String sql = " INSERT INTO CUSTOMUSER (EMAIL, PW, NICKNAME, USERNAME)  VALUES (?, ?, ?, ?) ";
		int count = 0;

		try {
			conn = this.getConnection();
			this.log("2/6 Success insert_user");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userBean.getEmail());
			psmt.setString(2, userBean.getPw());
			psmt.setString(3, userBean.getNickname());
			psmt.setString(4, userBean.getUsername());
			this.log("3/6 insert_user");
			this.log("3/6-1 insert_user" + userBean.toString());
			count = psmt.executeUpdate();
			this.log("4/6 insert_user");
		} catch (SQLException arg10) {
			this.log("Fail insert_user", arg10);
		} finally {
			this.close(conn, psmt, (ResultSet) null);
		}

		return count > 0;
	}

	public boolean do_update_user(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		UserBean userBean = (UserBean) bean;
		String sql = " UPDATE CUSTOMUSER  SET PW=?, NICKNAME=?, USERNAME=?, PHONE=?, ADDRESS=?, WEB=?, PUBLICRANGE=?, INVITE=?, IMAGE=?  WHERE EMAIL = ? ";
		int count = 0;

		try {
			conn = this.getConnection();
			this.log("2/6 Success do_update_user");
			psmt = conn.prepareStatement(sql);
			byte e = 1;
			int arg12 = e + 1;
			psmt.setString(e, userBean.getPw());
			psmt.setString(arg12++, userBean.getNickname());
			psmt.setString(arg12++, userBean.getUsername());
			psmt.setString(arg12++, userBean.getPhone());
			psmt.setString(arg12++, userBean.getAddress());
			psmt.setString(arg12++, userBean.getWeb());
			psmt.setString(arg12++, userBean.getPublicrange());
			psmt.setString(arg12++, userBean.getInvite());
			psmt.setString(arg12++, userBean.getImage());
			psmt.setString(arg12++, userBean.getEmail());
			this.log("3/6 Success do_update_user");
			count = psmt.executeUpdate();
			this.log("4/6 Success do_update_user");
		} catch (SQLException arg10) {
			this.log("Fail do_update_user", arg10);
		} finally {
			this.close(conn, psmt, (ResultSet) null);
			this.log("end Success do_update_user");
		}

		return count > 0;
	}

	public boolean do_update_user_non_image(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		UserBean userBean = (UserBean) bean;
		String sql = " UPDATE CUSTOMUSER  SET PW=?, NICKNAME=?, USERNAME=?, PHONE=?, ADDRESS=?, WEB=?, PUBLICRANGE=?, INVITE=?   WHERE EMAIL = ? ";
		int count = 0;

		try {
			conn = this.getConnection();
			this.log("2/6 Success do_update_user");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userBean.getPw());
			psmt.setString(2, userBean.getNickname());
			psmt.setString(3, userBean.getUsername());
			psmt.setString(4, userBean.getPhone());
			psmt.setString(5, userBean.getAddress());
			psmt.setString(6, userBean.getWeb());
			psmt.setString(7, userBean.getPublicrange());
			psmt.setString(8, userBean.getInvite());
			psmt.setString(9, userBean.getEmail());
			this.log("3/6 Success do_update_user");
			count = psmt.executeUpdate();
			this.log("4/6 Success do_update_user");
		} catch (SQLException arg10) {
			this.log("Fail do_update_user", arg10);
		} finally {
			this.close(conn, psmt, (ResultSet) null);
			this.log("end Success do_update_user");
		}

		return count > 0;
	}

	public UserBean do_search_user(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT EMAIL, PW, NICKNAME, USERNAME, PHONE, ADDRESS, WEB, PUBLICRANGE, INVITE, IMAGE  FROM CUSTOMUSER  WHERE EMAIL =? ";
		UserBean bean = new UserBean();

		try {
			conn = this.getConnection();
			this.log("2/6 Success usersearchList");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			this.log("3/6 Success usersearchList");
			rs = psmt.executeQuery();
			this.log("4/6 Success usersearchList");

			while (rs.next()) {
				bean.setEmail(rs.getString(1));
				bean.setPw(rs.getString(2));
				bean.setNickname(rs.getString(3));
				bean.setUsername(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setAddress(rs.getString(6));
				bean.setWeb(rs.getString(7));
				bean.setPublicrange(rs.getString(8));
				bean.setInvite(rs.getString(9));
				bean.setImage(rs.getString(10));
			}

			this.log("5/6 Success usersearchList");
		} catch (SQLException arg10) {
			this.log("Fail userList", arg10);
		} finally {
			this.close(conn, psmt, rs);
			this.log("6/6 Success userList");
		}

		return bean;
	}

	public ArrayList<UserBean> do_search_openuser(ArrayList<String> taglist, int projectseq) {
		ArrayList userList = new ArrayList();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			StringBuilder e = new StringBuilder();
			e.append("    \t\t SELECT EMAIL, NICKNAME, IMAGE                              \n");
			e.append("    \t\t FROM CUSTOMUSER   \t\t\t\t\t\t\t\t            \n");
			e.append("    \t\t WHERE INVITE = \'Y\' AND EMAIL IN                            \n");
			e.append("    \t                                     (SELECT EMAIL              \n");
			e.append("    \t                                      FROM USER_TAG             \n");
			e.append("    \t                                      WHERE TAGNAME IN(         \n");

			int num;
			for (num = 0; num < taglist.size(); ++num) {
				if (num == 0) {
					e.append("?");
				} else {
					e.append(", ?");
				}
			}

			e.append("    \t                                      )GROUP BY EMAIL           \n");
			e.append("    \t                                       HAVING COUNT(*) >= ?)\t\n");
			e.append("    \t\t      AND EMAIL NOT IN (SELECT EMAIL\t \t\t\t\t\t\n");
			e.append("\t\t\t\t\t\t\t\t\tFROM MEMBERS\t\t\t\t\t\t\n");
			e.append("\t\t\t\t\t\t\t\t\tWHERE PROJECT_SEQ = ? )\t\t\t\t\n");
			System.out.println(e);
			conn = this.getConnection();
			psmt = conn.prepareStatement(e.toString());
			num = 1;

			for (int bean = 0; bean < taglist.size(); ++bean) {
				psmt.setString(num++, (String) taglist.get(bean));
			}

			psmt.setInt(num++, taglist.size());
			psmt.setInt(num++, projectseq);
			rs = psmt.executeQuery();

			while (rs.next()) {
				UserBean arg14 = new UserBean();
				arg14.setEmail(rs.getString(1));
				arg14.setNickname(rs.getString(2));
				arg14.setImage(rs.getString(3));
				userList.add(arg14);
			}
		} catch (Exception arg12) {
			System.out.println("selectDBList() : " + arg12);
		} finally {
			this.close(conn, psmt, rs);
		}

		return userList;
	}

	public ArrayList<UserBean> do_search_user_all(int projectseq) {
		ArrayList userList = new ArrayList();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			StringBuilder e = new StringBuilder();
			e.append("    \t\t SELECT EMAIL, NICKNAME, IMAGE                              \n");
			e.append("    \t\t FROM CUSTOMUSER   \t\t\t\t\t\t\t\t            \n");
			e.append("    \t\t WHERE INVITE = \'Y\' \t\t\t                            \n");
			e.append("    \t\t      AND EMAIL NOT IN (SELECT EMAIL\t \t\t\t\t\t\n");
			e.append("\t\t\t\t\t\t\t\t\tFROM MEMBERS\t\t\t\t\t\t\n");
			e.append("\t\t\t\t\t\t\t\t\tWHERE PROJECT_SEQ = ? )\t\t\t\t\n");
			System.out.println(e);
			conn = this.getConnection();
			psmt = conn.prepareStatement(e.toString());
			psmt.setInt(1, projectseq);
			rs = psmt.executeQuery();

			while (rs.next()) {
				UserBean bean = new UserBean();
				bean.setEmail(rs.getString(1));
				bean.setNickname(rs.getString(2));
				bean.setImage(rs.getString(3));
				userList.add(bean);
			}
		} catch (Exception arg10) {
			System.out.println("selectDBList() : " + arg10);
		} finally {
			this.close(conn, psmt, rs);
		}

		return userList;
	}

	public ArrayList<UserBean> do_search_user_nickname(String nickname, int projectseq) {
		ArrayList userList = new ArrayList();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			StringBuilder e = new StringBuilder();
			e.append("    \t\t SELECT EMAIL, NICKNAME, IMAGE                              \n");
			e.append("    \t\t FROM CUSTOMUSER   \t\t\t\t\t\t\t\t            \n");
			e.append("    \t\t WHERE INVITE = \'Y\' \t\t\t                            \n");
			e.append("    \t\t \tAND NICKNAME LIKE ? \t\t\t                        \n");
			e.append("    \t\t    AND EMAIL NOT IN (SELECT EMAIL\t \t\t\t\t\t\t\n");
			e.append("\t\t\t\t\t\t\t\t\tFROM MEMBERS\t\t\t\t\t\t\n");
			e.append("\t\t\t\t\t\t\t\t\tWHERE PROJECT_SEQ = ? )\t\t\t\t\n");
			System.out.println(e);
			conn = this.getConnection();
			psmt = conn.prepareStatement(e.toString());
			nickname = "%" + nickname + "%";
			psmt.setString(1, nickname);
			psmt.setInt(2, projectseq);
			rs = psmt.executeQuery();

			while (rs.next()) {
				UserBean bean = new UserBean();
				bean.setEmail(rs.getString(1));
				bean.setNickname(rs.getString(2));
				bean.setImage(rs.getString(3));
				userList.add(bean);
			}
		} catch (Exception arg11) {
			System.out.println("selectDBList() : " + arg11);
		} finally {
			this.close(conn, psmt, rs);
		}

		return userList;
	}

	public boolean do_insert(Object bean) {
		return false;
	}

	public boolean do_update(Object bean) {
		return false;
	}

	public boolean do_delete(Object bean) {
		return false;
	}

	public boolean do_upsert(Object bean) {
		return false;
	}

	public boolean do_detail(Object bean) {
		return false;
	}
}