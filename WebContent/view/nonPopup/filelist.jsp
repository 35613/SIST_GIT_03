<%@page import="javax.swing.text.DefaultEditorKit.BeepAction"%>
<%@page import="bean.FileBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GROUPPL</title>
    <link rel="stylesheet" href="/view/CSS/bootstrap.min.css">
    <link rel="stylesheet" href="/view/CSS/bootstrap-theme.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="/view/JS/bootstrap.min.js"></script>
    <style type="text/css">
        body { padding-top: 70px; }
        input[type=button]{
      width: 50%;
      height:100%;
      background-color: lightgray;
      border:none;
      background-color: white;
      font-size:1em;
      color:#042AaC;
      outline:none;
      display:inline;
      box-sizing: border-box;
    }

        
    </style>
</head>
<body>
<%
    int invitation = 3;
    int apply = 2;
    String userImg = "/view/image/profile.jpg";

    
    ArrayList<FileBean> Filelist = new ArrayList<>();
    
    /* FileBean bean = new FileBean();
    bean.setOriginal_file_name("original_file_name");
    bean.setCrea_id("crea_id");
    bean.setFile_size(123);
    Filelist.add(bean);
    
    
    FileBean bean1 = new FileBean();
    bean1.setOriginal_file_name("original_file_name1");
    bean1.setCrea_id("crea_id1");
    bean1.setFile_size(1234);
    Filelist.add(bean1);
    
    
    FileBean bean2 = new FileBean();
    bean2.setOriginal_file_name("original_file_name2");
    bean2.setCrea_id("crea_id2");
    bean2.setFile_size(12345);
    Filelist.add(bean2); */
   
    
%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="/view/image/logo/1_Primary_logo_on_transparent_291x67.png" alt="" width="150" height="35"></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                        <img src="<%=userImg%>" alt="" width="30" height="30" class="img-rounded"> 이인재 <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">초대가 <strong><%=invitation%></strong>건 있습니다.</a></li>
                        <li><a href="#">지원이 <strong><%=apply%></strong>건 있습니다.</a></li>
                        <li class="divider"></li>
                        <li><a href="#">회원정보 수정</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>











<div class="container bs-docs-container">
    <div class="row">
        <div class="col-md-9" role="main">
            <div class="bs-docs-section">

                <div class="panel panel-default">
                    <div class="panel-body">
                   	
                    
                    
                       <table border="1" style="text-align: center;">
                       <tr><td colspan="5"><h1>자료실음하하</h1></td> </tr>
                       <col width="300"><col width="250"><col width="250"><col width="250">
                       <tr>
                       <th style="text-align: center;">파일이름</th>
                       <th style="text-align: center;">올린사람</th>
                       <th style="text-align: center;">파일크기</th>
                       <th style="text-align: center;">다운로드</th>
                       </tr>
                       
                       <%for(int i = 0; i< Filelist.size(); i++){ %>
                       <tr>
                       <td><%=Filelist.get(i).getOriginal_file_name() %> </td><%-- 
                       <td><%=Filelist.get(i).getCrea_id() %></td>
                       <td><%=Filelist.get(i).getFile_size() %></td> --%>
                       <td><input type="button" value="down" style="width: 100%" name="bu<%=i %>"> </td>
                       </tr>
                       <%} %>
                      </table>
                    </div>
                </div>

            </div>
        </div>









        <div class="col-md-3" role="complementary">
            <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">
                <jsp:include page="/view/rightmenu.jsp"></jsp:include>
            </nav>
        </div>

    </div>
</div>


</body>
</html>