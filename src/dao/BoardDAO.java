package dao;

import bean.BoardBean;
import bean.BoardCommentBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO extends SuperDAO implements DAO {

    private static BoardDAO dao;

    private BoardDAO() {
        super.init();
    }

    public static BoardDAO getInstance() {
        if (dao == null) {
            dao = new BoardDAO();
        }
        return dao;
    }

    public  BoardBean do_search(int boardseq) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT A.POST_SEQ, A.WRITER, A.READCOUNT, A.ISDELETED, A.WRITEDATE, A.PROJECT_SEQ, A.CONTENTSS, B.NICKNAME, C.PROJECTNAME" +
                " FROM BOARDBASE A " +
                " INNER JOIN CUSTOMUSER B " +
                " ON (A.WRITER = B.EMAIL) " +
                " INNER JOIN PROJECTS C " +
                " ON (A.PROJECT_SEQ = C.PROJECT_SEQ) " +
                " WHERE A.POST_SEQ = ? ";

        BoardBean boardBean = new BoardBean();

        try {
            conn = getConnection();
            log("2/6 Success do_search_boardlist");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, boardseq);
            log("3/6 Success do_search_boardlist");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_boardlist");

            while (rs.next()) {
                int i = 1;
                
                boardBean.setPost_seq(rs.getInt(i++));
                boardBean.setWriter(rs.getString(i++));
                boardBean.setReadcount(rs.getInt(i++));
                boardBean.setIsdeleted(rs.getString(i++));
                boardBean.setWritedate(rs.getString(i++));
                boardBean.setProject_seq(rs.getInt(i++));
                boardBean.setContentss(rs.getString(i++));
                boardBean.setWriternickname(rs.getString(i++));
                boardBean.setProjectname(rs.getString(i++));
            }

        } catch (SQLException e) {
            log("Fail do_search_boardlist", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_boardlist");

        return boardBean;
    }

    public ArrayList<BoardBean> do_search_boardlist(String email, int pageNum) {
        final int PAGE_SIZE = 2;
        int PAGE_NUM = pageNum;

        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT TT1.* " +
                " FROM( " +
                " SELECT ROWNUM \"글번호\", T1.* " +
                " FROM( " +
                " SELECT C.PROJECTNAME, D.*, (select nickname FROM CUSTOMUSER WHERE EMAIL = d.WRITER) as nickname, (select image FROM CUSTOMUSER WHERE EMAIL = d.WRITER) as image " +
                " FROM CUSTOMUSER A " +
                " INNER JOIN MEMBERS B " +
                " ON (A.EMAIL = B.EMAIL) " +
                " INNER JOIN PROJECTS C " +
                " ON (B.PROJECT_SEQ = C.PROJECT_SEQ) " +
                " INNER JOIN BOARDBASE D " +
                " ON (B.PROJECT_SEQ = D.PROJECT_SEQ) " +
                " WHERE A.EMAIL = ? AND D.ISDELETED = 'N' " +
                " ORDER BY D.WRITEDATE DESC " +
                "   )T1 " +
                " )TT1 " +
                " WHERE 글번호 BETWEEN ( ? * ( ? - 1 ) + 1 ) AND (( ? * (?-1))+? ) ";

        ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_boardlist");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, email);
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
                bean.setProjectname(rs.getString(2));
                bean.setPost_seq(rs.getInt(3));
                bean.setWriter(rs.getString(4));
                bean.setReadcount(rs.getInt(5));
                bean.setIsdeleted(rs.getString(6));
                bean.setWritedate(rs.getString(7));
                bean.setProject_seq(rs.getInt(8));
                bean.setContentss(rs.getString(9));
                bean.setWriternickname(rs.getString(10));
                bean.setWriterimage(rs.getString(11));

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

   
    public boolean do_insert_board(BoardBean boardBean) {

        Connection conn = null;
        PreparedStatement psmt = null;


        String sql = " INSERT INTO BOARDBASE (POST_SEQ, WRITER, CONTENTSS, PROJECT_SEQ) " +
                " VALUES (POST_SEQ.NEXTVAL, ?, ?, ?) ";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success Callist");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, boardBean.getWriter());
            psmt.setString(2, boardBean.getContentss());
            psmt.setInt(3, boardBean.getProject_seq());
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

    @Override
    public boolean do_update(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;

        BoardBean boardBean = (BoardBean)bean;

        String sql = " UPDATE BOARDBASE " +
                " SET CONTENTSS = ? " +
                " WHERE POST_SEQ = ? ";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success Callist");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, boardBean.getContentss());
            psmt.setInt(2, boardBean.getPost_seq());
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

    @Override
    public boolean do_delete(Object bean) {
        Connection conn = null;
        PreparedStatement psmt = null;

        BoardBean boardBean = (BoardBean)bean;

        String sql = " UPDATE BOARDBASE " +
                " SET ISDELETED = 'Y' " +
                " WHERE POST_SEQ = ? ";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success Callist");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, boardBean.getPost_seq());
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

    public ArrayList<BoardCommentBean> do_search_comment(int post_seq) {
        Connection conn = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;

        String sql = " SELECT B.*, C.NICKNAME " +
                " FROM BOARDBASE A " +
                " INNER JOIN BOARDCOMMENT B " +
                " ON(A.POST_SEQ = B.POST_SEQ) " +
                " INNER JOIN CUSTOMUSER C " +
                " ON(B.WRITER = C.EMAIL) " +
                " WHERE A.POST_SEQ = ? ";

        ArrayList<BoardCommentBean> commentList = new ArrayList<BoardCommentBean>();

        try {
            conn = getConnection();
            log("2/6 Success do_search_comment");

            psmt = conn.prepareStatement(sql);
            psmt.setInt(1, post_seq);
            log("3/6 Success do_search_comment");

            rs = psmt.executeQuery();
            log("4/6 Success do_search_comment");

            while (rs.next()) {
                BoardCommentBean bean = new BoardCommentBean();
                bean.setComment_seq(rs.getInt(1));
                bean.setContentss(rs.getString(2));
                bean.setWriter(rs.getString(3));
                bean.setDates(rs.getString(4));
                bean.setPost_seq(rs.getInt(5));
                bean.setWriternickname(rs.getString(6));

                commentList.add(bean);
            }

        } catch (SQLException e) {
            log("Fail do_search_comment", e);

        } finally {
            this.close(conn, psmt, rs);

        }
        log("6/6 Success do_search_comment");

        return commentList;
    }

    public boolean do_insert_comment(Object bean) {

        Connection conn = null;
        PreparedStatement psmt = null;

        BoardCommentBean commentBean = (BoardCommentBean)bean;

        String sql = " INSERT INTO BOARDCOMMENT(COMMENT_SEQ, CONTENTSS, WRITER, POST_SEQ) " +
                " VALUES(BOCOMMENT_SEQ.NEXTVAL, ?, ?, ?) ";

        int count = 0;

        try {
            conn = getConnection();
            log("2/6 Success Callist");

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, commentBean.getContentss());
            psmt.setString(2, commentBean.getWriter());
            psmt.setInt(3, commentBean.getPost_seq());
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

    @Override
    public boolean do_upsert(Object bean) {
        return false;
    }

    @Override
    public boolean do_detail(Object bean) {
        return false;
    }

	@Override
	public boolean do_insert(Object bean) {
		// TODO Auto-generated method stub
		return false;
	}
}
