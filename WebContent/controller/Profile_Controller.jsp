<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TagDAO"%>
<%@page import="bean.TagBean"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="bean.UserBean" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


 <%
    
 request.setCharacterEncoding("UTF-8");
    // 10Mbyte 제한
    int maxSize  = 1024*1024*10;        
 
    // 웹서버 컨테이너 경로
    String root = request.getSession().getServletContext().getRealPath("/upload/");
 System.out.println(root);
    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
    String savePath = root;
 
    // 업로드 파일명
    String uploadFile = "";
 
    // 실제 저장할 파일명
    String newFileName = "";
 
 
 
    int read = 0;
    byte[] buf = new byte[1024];
    FileInputStream fin = null;
    FileOutputStream fout = null;
    long currentTime = System.currentTimeMillis();  
    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");  
 
    try{
 
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
        String email = multi.getParameter("email");
        UserBean userBean = new UserBean();
        boolean userDAOsuccessFail = false;
        UserDAO userDAO = UserDAO.getInstance();
        System.out.println("asdasd = " + multi.getFilesystemName("uploadFile"));
 		if(multi.getFilesystemName("uploadFile")!=null){
 			
 		
        // 파일업로드
        uploadFile = multi.getFilesystemName("uploadFile");
        System.out.println("파일저장");
        // 실제 저장할 파일명(ex : 20140819151221.zip)
        newFileName = simDf.format(new Date(currentTime)) +"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
 		
         
        // 업로드된 파일 객체 생성
        File oldFile = new File(savePath + uploadFile);
        System.out.println("파일저장");
         
        // 실제 저장될 파일 객체 생성
        File newFile = new File(savePath + newFileName);
        System.out.println("파일저장3");
 		
        ////////////////////////////////
        userBean.setPw(multi.getParameter("password"));
 		    userBean.setNickname(multi.getParameter("nickname"));
 		    userBean.setUsername(multi.getParameter("username"));
 		    userBean.setPhone(multi.getParameter("phone"));
 		    userBean.setAddress(multi.getParameter("address"));
 		    userBean.setWeb(multi.getParameter("web"));
 		    userBean.setPublicrange(multi.getParameter("publicrange"));
 		    userBean.setInvite(multi.getParameter("invite"));
 		    userBean.setEmail(email);
 		    userBean.setImage(newFileName);
 		    
 		    
 		    userDAOsuccessFail = userDAO.do_update_user(userBean);
        
        
        
        ////////////////////////////////
        // 파일명 rename
        if(!oldFile.renameTo(newFile)){
 
            // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
 
            buf = new byte[1024];
            fin = new FileInputStream(oldFile);
            fout = new FileOutputStream(newFile);
            read = 0;
            while((read=fin.read(buf,0,buf.length))!=-1){
                fout.write(buf, 0, read);
                System.out.println("파일저장");
            }
             
            fin.close();
            fout.close();
            oldFile.delete();
        }   
 		}else if(multi.getFilesystemName("uploadFile")==null){
 			
 			
 			 
 			userBean.setPw(multi.getParameter("password"));
 		    userBean.setNickname(multi.getParameter("nickname"));
 		    userBean.setUsername(multi.getParameter("username"));
 		    userBean.setPhone(multi.getParameter("phone"));
 		    userBean.setAddress(multi.getParameter("address"));
 		    userBean.setWeb(multi.getParameter("web"));
 		    userBean.setPublicrange(multi.getParameter("publicrange"));
 		    userBean.setInvite(multi.getParameter("invite"));
 		    userBean.setEmail(email);
 		    userDAOsuccessFail = userDAO.do_update_user_non_image(userBean);
 		}
        System.out.println("파일저장4");

	TagDAO tagDAO = TagDAO.getInstance();
    ArrayList<TagBean> tagList = new ArrayList<TagBean>();
    
    
    String usertag[] = multi.getParameterValues("usertag");
    
    for(int i = 0 ; i < usertag.length; i++ ){
    	TagBean tagBean = new TagBean();
    	 tagBean.setEmail(email);
    	 tagBean.setTagname(usertag[i]);
    	 tagList.add(tagBean);
	    
    }

    tagDAO.do_update_user(email, tagList);
    

    	UserBean userdto = userDAO.do_search_user(email);
    	session.removeAttribute("userBean");
    	session.setAttribute("userBean", userdto);
    	
    	System.out.println("session.getAttribute" + (UserBean)session.getAttribute("userBean"));
    	System.out.println("수정완료" + userBean.toString());
    
       response.sendRedirect("/view/nonPopup/projectboard.jsp");

   
    
    }catch(Exception e){
        e.printStackTrace();
    }

%>