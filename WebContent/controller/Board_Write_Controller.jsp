<%@page import="bean.FileBean"%>
<%@page import="dao.FileDAO"%>
<%@page import="bean.UserBean"%>
<%@page import="dao.BoardDAO"%>
<%@page import="bean.BoardBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
 	String writer = "";
 	String content = "";
 	String seq = "";
 	boolean boardupload = false;
 
    int read = 0;
    byte[] buf = new byte[1024];
    FileInputStream fin = null;
    FileOutputStream fout = null;
    long currentTime = System.currentTimeMillis();  
    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");  
 
    try{
    	 MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
    	 
    	writer = multi.getParameter("writer");
        content = multi.getParameter("content");
        seq = multi.getParameter("projectseq");
 		
        
        //////////////////////////////////
        	BoardDAO bddao = BoardDAO.getInstance();
		    BoardBean boardbean = new BoardBean();
		     
		 	int pjseq = Integer.parseInt(seq);
			UserBean userdto = (UserBean)session.getAttribute("userBean");
			
			
			boardbean.setContentss(content);
			boardbean.setProject_seq(pjseq);
			boardbean.setWriter(userdto.getEmail());
			System.out.println("bean = " + boardbean.toString());
			
			
			boardupload = bddao.do_insert_board(boardbean);
        
      	/////////////////////////////////////////
        // 파일업로드
        if (multi.getFilesystemName("uploadFile")!=null){
        uploadFile = multi.getFilesystemName("uploadFile");
 
        // 실제 저장할 파일명(ex : 20140819151221.zip)
        newFileName = simDf.format(new Date(currentTime)) +"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
 		
         
        // 업로드된 파일 객체 생성
        File oldFile = new File(savePath + uploadFile);
 
         
        // 실제 저장될 파일 객체 생성
        
        
        
        
        File newFile = new File(savePath + newFileName);
        FileDAO filedao = FileDAO.getInstance();
    	FileBean filebean = new FileBean();
    	filebean.setOriginal_file_name(uploadFile);
    	filebean.setStored_file_name(newFileName);
    	filebean.setProject_seq(pjseq);
    	System.out.println("filebean = " + filebean.toString());
    	boolean fileupload = filedao.do_insert(filebean);
        
        
        // 파일명 rename
        if(!oldFile.renameTo(newFile)){
 
            // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
 
            buf = new byte[1024];
            fin = new FileInputStream(oldFile);
            fout = new FileOutputStream(newFile);
            read = 0;
            while((read=fin.read(buf,0,buf.length))!=-1){
                fout.write(buf, 0, read);
            }
             
            fin.close();
            fout.close();
            oldFile.delete();
        }   
        }
    }catch(Exception e){
        e.printStackTrace();
    }
    
    
   
    
	
	
	
	
	if(boardupload){
		System.out.println("보드성공");
		%>
		<script type="text/javascript">
		    window.opener.location.reload();
		    window.open('','_parent','');window.close();
		</script>
		<%
	}else{
		System.out.println("보드실패");
	}
%>






