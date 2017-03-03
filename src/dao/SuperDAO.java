package dao;

import java.sql.*;

public class SuperDAO {

    public void init() {
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            log("1/6 Success");
        }catch (ClassNotFoundException e) {
            e.printStackTrace();
            log("1/6 Fail", e);
        }
    }

    public void log(String msg){
        System.out.println(getClass() + ":" + msg);
    }
    public void log(String msg, Exception e){
        System.out.println(e + " : " +getClass() + " : " + msg);
    }

    public Connection getConnection() throws SQLException {
        Connection conn = null;
        String url = "jdbc:oracle:thin:@211.238.142.180:1521:xe";
        conn = DriverManager.getConnection(url,"sist2","sist2");
        return conn;
    }

    public void close(Connection conn, Statement stmt, ResultSet rs){
        if(conn!=null){
            try{
                conn.close();
            }catch (SQLException e){}
        }
        if(stmt!=null){
            try{
                stmt.close();
            }catch (SQLException e){}
        }
        if(rs!=null){
            try{
                rs.close();
            }catch (SQLException e){}
        }
    }

}
