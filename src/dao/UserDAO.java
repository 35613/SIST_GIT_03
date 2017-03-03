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

	//로그인 회원정보 가져오는 메소드
	public UserBean do_search_userinfo(String email, String pw) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql = " SELECT EMAIL, PW, NICKNAME, USERNAME, PHONE, ADDRESS, WEB, PUBLICRANGE, INVITE, IMAGE FROM CUSTOMUSER " 
					+ "WHERE EMAIL = ? AND PW = ?";
		UserBean bean = new UserBean();

		try {
			conn = getConnection();
			log("2/6 Success userList");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email); // DB에서 꺼내오기작업
			psmt.setString(2, pw);
			log("3/6 Success userList");

			rs = psmt.executeQuery();
			log("4/6 Success userList");

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
			log("5/6 Success userList");

		} catch (SQLException e) {
			log("Fail userList", e);
		} finally {
			this.close(conn, psmt, rs);
			log("6/6 Success userList");
		}
		return bean;
	}

	//회원이 소속된 프로젝트 리스트 불러오는 메소드
	public ArrayList<ProjectBean> do_search_userproject(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT B.* "
					+ " FROM MEMBERS A "
					+ "	INNER JOIN PROJECTS B "
					+ "	ON (A.PROJECT_SEQ = B.PROJECT_SEQ) " 
					+ "	WHERE A.EMAIL = ? AND B.ISEND = 'N' ";
		ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();

		try {
			conn = getConnection();
			log("2/6 Success do_search_userproject");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			log("3/6 Success do_search_userproject");

			rs = psmt.executeQuery();
			log("4/6 Success do_search_userproject");

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
				projectList.add(bean);
			}

		} catch (SQLException e) {
			log("Fail do_search_userproject", e);

		} finally {
			this.close(conn, psmt, rs);

		}
		log("6/6 Success do_search_userproject");
		return projectList;
	}

	//아이디 중복확인시 필요한  메소드
	public boolean do_search_id(String email) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT EMAIL " + 
					 " FROM CUSTOMUSER " + 
					 " WHERE EMAIL =? ";

		String serch_id = "";
		try {
			conn = this.getConnection();
			log("2/6 Success serch_id");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			log("3/6 Success serch_id");

			rs = psmt.executeQuery(); 
			log("4/6 Success serch_id");

			while (rs.next()) {
				serch_id = rs.getString(1);
			}
			log("5/6 Success serch_id");

		} catch (SQLException e) {
			log("Faild serch_id", e);

		} finally {
			this.close(conn, psmt, rs);
			log("6/6 Success serch_id");
		}

		if (serch_id == null || serch_id.equals("")) {
			return false; 
		}

		return true; 
	}

	//회원가입 메소드
	public boolean do_insert_user(Object bean) {

		Connection conn = null;
		PreparedStatement psmt = null;

		UserBean userBean = (UserBean) bean;

		String sql = " INSERT INTO CUSTOMUSER (EMAIL, PW, NICKNAME, USERNAME) " 
					+ " VALUES (?, ?, ?, ?) ";

		int count = 0;

		try {
			conn = getConnection();
			log("2/6 Success insert_user");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, userBean.getEmail());
			psmt.setString(2, userBean.getPw());
			psmt.setString(3, userBean.getNickname());
			psmt.setString(4, userBean.getUsername());
			log("3/6 insert_user");
			log("3/6-1 insert_user"+userBean.toString());
			count = psmt.executeUpdate();
			log("4/6 insert_user");

		} catch (SQLException e) {
			log("Fail insert_user", e);

		} finally {
			this.close(conn, psmt, null);

		}
		return (count > 0) ? true : false;
	}
	
	//회원정보 수정 메소드
	public boolean do_update_user(Object bean){
		
		Connection conn = null;
		PreparedStatement psmt = null;
				
		UserBean userBean = (UserBean) bean;

		String sql = " UPDATE CUSTOMUSER " +
                " SET PW=?, NICKNAME=?, USERNAME=?, PHONE=?, ADDRESS=?, WEB=?, PUBLICRANGE=?, INVITE=?, IMAGE=? " +
                " WHERE EMAIL = ? ";
		
		int count = 0;
		try{
			conn = getConnection();
			log("2/6 Success do_update_user");	
			
			psmt=conn.prepareStatement(sql);
			int i= 1;
			psmt.setString(i++, userBean.getPw());
			psmt.setString(i++, userBean.getNickname());
			psmt.setString(i++, userBean.getUsername());
			psmt.setString(i++, userBean.getPhone());
			psmt.setString(i++, userBean.getAddress());
			psmt.setString(i++, userBean.getWeb());
			psmt.setString(i++, userBean.getPublicrange());
			psmt.setString(i++, userBean.getInvite());
			psmt.setString(i++, userBean.getImage());
            psmt.setString(i++, userBean.getEmail());
			log("3/6 Success do_update_user");
			
			count = psmt.executeUpdate();
			log("4/6 Success do_update_user");
					
		}catch(SQLException e){
			log("Fail do_update_user", e);
		}finally{
			this.close(conn, psmt, null);
			log("end Success do_update_user");
		}		
		return count>0?true:false;
	}

public boolean do_update_user_non_image(Object bean){
		
		Connection conn = null;
		PreparedStatement psmt = null;
				
		UserBean userBean = (UserBean) bean;

		String sql = " UPDATE CUSTOMUSER "+ 
					 " SET PW=?, NICKNAME=?, USERNAME=?, PHONE=?, ADDRESS=?, WEB=?, PUBLICRANGE=?, INVITE=?  " + 
					 " WHERE EMAIL = ? ";
		
		int count = 0;
		try{
			conn = getConnection();
			log("2/6 Success do_update_user");	
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, userBean.getPw());
			psmt.setString(2, userBean.getNickname());
			psmt.setString(3, userBean.getUsername());
			psmt.setString(4, userBean.getPhone());
			psmt.setString(5, userBean.getAddress());
			psmt.setString(6, userBean.getWeb());
			psmt.setString(7, userBean.getPublicrange());
			psmt.setString(8, userBean.getInvite());
            psmt.setString(9, userBean.getEmail());
			log("3/6 Success do_update_user");
			
			count = psmt.executeUpdate();
			log("4/6 Success do_update_user");
					
		}catch(SQLException e){
			log("Fail do_update_user", e);
		}finally{
			this.close(conn, psmt, null);
			log("end Success do_update_user");
		}		
		return count>0?true:false;
	}
	
	
	
	
	//회원정보 불러오는 메소드
	public UserBean do_search_user(String email){
		Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        
        String sql = " SELECT EMAIL, PW, NICKNAME, USERNAME, PHONE, ADDRESS, WEB, PUBLICRANGE, INVITE, IMAGE " 
        		   + " FROM CUSTOMUSER "  
 	               + " WHERE EMAIL =? ";

        UserBean bean = new UserBean();
        
        try{
            conn = getConnection();
   			log("2/6 Success usersearchList");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);;
            log("3/6 Success usersearchList");   
            
            rs = psmt.executeQuery();
            log("4/6 Success usersearchList");        
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
   			log("5/6 Success usersearchList");
            } catch (SQLException e) {
    			log("Fail userList", e);
    		} finally {
    			this.close(conn, psmt, rs);
    			log("6/6 Success userList");
    		}
   		return bean;
        }

	// 태그별 초대가능한 멤버 불러오는 메소드
	public ArrayList<UserBean> do_search_openuser(ArrayList<String> taglist, int projectseq) {

		ArrayList<UserBean> userList = new ArrayList<UserBean>();

		Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        try{
            StringBuilder sql = new StringBuilder();
            sql.append("    		 SELECT EMAIL, NICKNAME, IMAGE                              \n");
            sql.append("    		 FROM CUSTOMUSER   								            \n");
            sql.append("    		 WHERE INVITE = 'Y' AND EMAIL IN                            \n");
            sql.append("    	                                     (SELECT EMAIL              \n");
            sql.append("    	                                      FROM USER_TAG             \n");
            sql.append("    	                                      WHERE TAGNAME IN(         \n");
            for (int i = 0; i < taglist.size(); i++) {
                if (i == 0) {
                    sql.append("?");
                }else{
                    sql.append(", ?");
                }
            }
            sql.append("    	                                      )GROUP BY EMAIL           \n");
            sql.append("    	                                       HAVING COUNT(*) >= ?)	\n");
            sql.append("    		      AND EMAIL NOT IN (SELECT EMAIL	 					\n");
			sql.append("									FROM MEMBERS						\n");
			sql.append("									WHERE PROJECT_SEQ = ? )				\n");

			System.out.println(sql);
			conn = getConnection();
            psmt = conn.prepareStatement(sql.toString());

            int num = 1;
            for (int i = 0; i < taglist.size(); i++) {
                psmt.setString(num++,taglist.get(i));
            }
            psmt.setInt(num++, taglist.size());
            psmt.setInt(num++, projectseq);

            rs = psmt.executeQuery();

            while (rs.next()) {
                UserBean bean = new UserBean();
                bean.setEmail(rs.getString(1));
                bean.setNickname(rs.getString(2));
                bean.setImage(rs.getString(3));

                userList.add(bean);
            }

        } catch (Exception e) {
            System.out.println("selectDBList() : " + e);
        } finally {
            this.close(conn, psmt, rs);
        }

        return userList;
    }

    // 초대 가능한 멤버 전체 불러오는 메소드
	public ArrayList<UserBean> do_search_user_all(int projectseq) {

		ArrayList<UserBean> userList = new ArrayList<UserBean>();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try{
			StringBuilder sql = new StringBuilder();
			sql.append("    		 SELECT EMAIL, NICKNAME, IMAGE                              \n");
			sql.append("    		 FROM CUSTOMUSER   								            \n");
			sql.append("    		 WHERE INVITE = 'Y' 			                            \n");
			sql.append("    		      AND EMAIL NOT IN (SELECT EMAIL	 					\n");
			sql.append("									FROM MEMBERS						\n");
			sql.append("									WHERE PROJECT_SEQ = ? )				\n");

			System.out.println(sql);
			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setInt(1, projectseq);

			rs = psmt.executeQuery();

			while (rs.next()) {
				UserBean bean = new UserBean();
				bean.setEmail(rs.getString(1));
				bean.setNickname(rs.getString(2));
				bean.setImage(rs.getString(3));

				userList.add(bean);
			}

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			this.close(conn, psmt, rs);
		}

		return userList;
	}

	// 닉네임으로 검색한 멤버 불러오는 메소드
	public ArrayList<UserBean> do_search_user_nickname(String nickname, int projectseq) {

		ArrayList<UserBean> userList = new ArrayList<UserBean>();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try{
			StringBuilder sql = new StringBuilder();
			sql.append("    		 SELECT EMAIL, NICKNAME, IMAGE                              \n");
			sql.append("    		 FROM CUSTOMUSER   								            \n");
			sql.append("    		 WHERE INVITE = 'Y' 			                            \n");
			sql.append("    		 	AND NICKNAME LIKE ? 			                        \n");
			sql.append("    		    AND EMAIL NOT IN (SELECT EMAIL	 						\n");
			sql.append("									FROM MEMBERS						\n");
			sql.append("									WHERE PROJECT_SEQ = ? )				\n");
			System.out.println(sql);

			conn = getConnection();
			psmt = conn.prepareStatement(sql.toString());

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

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			this.close(conn, psmt, rs);
		}

		return userList;
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
