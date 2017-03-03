package test;

import bean.*;
import dao.*;

import java.util.ArrayList;


public class mainClass {
    public static void main(String[] args) {
        // BoardDAO 테스트

//        BoardDAO dao = BoardDAO.getInstance();

//        ArrayList<BoardBean> list = dao.do_search( "TEST7@NAVER.COM", 1);
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getWriternickname());

//        BoardBean bean = new BoardBean();
//        bean.setWriter("TEST7@NAVER.COM");
//        bean.setContentss("하이gkdl");
//        bean.setProject_seq(2);
//        dao.do_insert(bean);

//        BoardBean bean = new BoardBean();
//        bean.setContentss("수정");
//        bean.setPost_seq(9);
//        dao.do_update(bean);

//        BoardBean bean = new BoardBean();
//        bean.setIsdeleted("N");
//        bean.setPost_seq(9);
//        dao.do_delete(bean);

//        ArrayList<BoardCommentBean> list = dao.do_search_comment(6);
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getWriternickname());

//        BoardCommentBean commentBean = new BoardCommentBean();
//        commentBean.setContentss("댓글 테스트");
//        commentBean.setWriter("TEST7@NAVER.COM");
//        commentBean.setPost_seq(6);
//        dao.do_insert_comment(commentBean);

        // MembersDAO 테스트

//        MembersDAO dao = MembersDAO.getInstance();

//        ArrayList<Object> list = dao.do_search(5);
//
//        for (int i = 0; i < list.size(); i++) {
//            UserBean bean = (UserBean)list.get(i);
//            System.out.println(bean.getEmail() + " , " + bean.getNickname());
//        }

//        ArrayList<Object> list = dao.do_search_joinproject("TEST2@NAVER.COM");
//
//        for (int i = 0; i < list.size(); i++) {
//            ProjectBean bean = (ProjectBean)list.get(i);
//            System.out.println(bean.getProjectname() + " , " + bean.getProject_seq());
//        }

//        if(dao.do_insert_member(5, "TEST1@NAVER.COM"))
//            System.out.println("성공!");

//        if(dao.do_delete_member(5, "TEST1@NAVER.COM"))
//            System.out.println("성공!");


        // TagDAO 테스트

//        TagDAO dao = TagDAO.getInstance();

//        ArrayList<Object> list = dao.do_search("TEST2@NAVER.COM");
//
//        for (int i = 0; i < list.size(); i++) {
//            TagBean bean = (TagBean)list.get(i);
//            System.out.println(bean.getTagname());
//        }

//        ArrayList<Object> list = dao.do_search_projecttag(6);
//
//        for (int i = 0; i < list.size(); i++) {
//            TagBean bean = (TagBean)list.get(i);
//            System.out.println(bean.getTagname());
//        }


//        ArrayList<Object> list = dao.do_search_tag();
//
//        for (int i = 0; i < list.size(); i++) {
//            TagBean bean = (TagBean)list.get(i);
//            System.out.println(bean.getTagname());
//        }

//        ArrayList<TagBean> tagList = new ArrayList<>();
//        TagBean tagBean = new TagBean();
//        tagBean.setTagname("PostgreSQL");
//        tagList.add(tagBean);
//        TagBean tagBean1 = new TagBean();
//        tagBean1.setTagname("Python");
//        tagList.add(tagBean1);
//        TagBean tagBean2 = new TagBean();
//        tagBean2.setTagname("JAVA");
//        tagList.add(tagBean2);
//
//        if (dao.do_update_user("TEST1@NAVER.COM", tagList))
//            System.out.println("성공!");

//        ArrayList<TagBean> tagList = new ArrayList<>();
//        TagBean tagBean = new TagBean();
//        tagBean.setTagname("PostgreSQL");
//        tagList.add(tagBean);
//        TagBean tagBean1 = new TagBean();
//        tagBean1.setTagname("Python");
//        tagList.add(tagBean1);
//        TagBean tagBean2 = new TagBean();
//        tagBean2.setTagname("JAVA");
//        tagList.add(tagBean2);
//
//        if (dao.do_update_project(2, tagList))
//            System.out.println("성공!");

        // FileDAO 테스트

//        FileDAO dao = FileDAO.getInstance();

//        FileBean bean = new FileBean();
//        bean.setOriginal_file_name("test.jpg");
//        bean.setStored_file_name("D:\\son_sample\\3.jpg");
//        bean.setCrea_id("TEST1@NAVER.COM");
//        bean.setFile_size(256);
//        bean.setPost_seq(7);
//        bean.setProject_seq(6);
//
//        if (dao.do_insert(bean))
//            System.out.println("성공!");

//        ArrayList<FileBean> list = dao.do_search_file(6);
//
//        for (int i = 0; i < list.size(); i++) {
//            FileBean bean = list.get(i);
//            System.out.println(bean.getOriginal_file_name());
//        }

//        ArrayList<FileBean> fileList = new ArrayList<>();
//        FileBean bean = new FileBean();
//        bean.setOriginal_file_name("test1.jpg");
//        bean.setStored_file_name("D:\\son_sample\\1.jpg");
//        bean.setCrea_id("TEST1@NAVER.COM");
//        bean.setFile_size(256);
//        bean.setPost_seq(7);
//        bean.setProject_seq(6);
//        fileList.add(bean);
//        FileBean bean1 = new FileBean();
//        bean1.setOriginal_file_name("test2.jpg");
//        bean1.setStored_file_name("D:\\son_sample\\2.jpg");
//        bean1.setCrea_id("TEST1@NAVER.COM");
//        bean1.setFile_size(256);
//        bean1.setPost_seq(7);
//        bean1.setProject_seq(6);
//        fileList.add(bean1);
//        FileBean bean2 = new FileBean();
//        bean2.setOriginal_file_name("test3.jpg");
//        bean2.setStored_file_name("D:\\son_sample\\3.jpg");
//        bean2.setCrea_id("TEST1@NAVER.COM");
//        bean2.setFile_size(256);
//        bean2.setPost_seq(7);
//        bean2.setProject_seq(6);
//        fileList.add(bean2);
//
//        if (dao.do_update_file(7, fileList))
//            System.out.println("성공!");


        // MessageDAO

//        MessageDAO dao = MessageDAO.getInstance();

//        ArrayList<ApplicationBean> list = dao.do_search_application("TEST3@NAVER.COM");
//
//        for (int i = 0; i < list.size(); i++) {
//            ApplicationBean bean = list.get(i);
//            System.out.println(bean.getContentss());
//        }

//        ArrayList<InvitationBean> list = dao.do_search_invitation("TEST2@NAVER.COM");
//
//        for (int i = 0; i < list.size(); i++) {
//            InvitationBean bean = list.get(i);
//            System.out.println(bean.getProject_seq());
//        }

//        ApplicationBean bean = new ApplicationBean();
//        bean.setContentss("지원");
//        bean.setEmail("TEST2@NAVER.COM");
//        bean.setProject_seq(3);
//        bean.setSendid("TEST1@NAVER.COM");
//
//        if (dao.do_upsert_application(bean))
//            System.out.println("성공!");

//        InvitationBean bean = new InvitationBean();
//        bean.setEmail("TEST5@NAVER.COM");
//        bean.setProject_seq(3);
//
//        if (dao.do_upsert_invitation(bean))
//            System.out.println("성공!");

//        ApplicationBean bean = new ApplicationBean();
//        bean.setAppl_seq(5);
//
//        if (dao.do_update_application(bean))
//            System.out.println("성공!");

//        InvitationBean bean = new InvitationBean();
//        bean.setInvite_seq(3);
//
//        if (dao.do_update_invitation(bean))
//            System.out.println("성공!");


        // UserDAO 테스트

//        UserDAO dao = UserDAO.getInstance();

//        UserBean bean = dao.do_search_userinfo("TEST1@NAVER.COM", "TEST1");
//        System.out.println(bean.getPhone());

//        ArrayList<ProjectBean> list = dao.do_search_userproject("TEST1@NAVER.COM");
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getProjectname());

//        if (dao.do_search_id("TEST30@NAVER.COM"))
//            System.out.println("이미 있음");
//        else
//            System.out.println("없음");

//        UserBean bean = new UserBean();
//        bean.setEmail("TEST11@NAVER.COM");
//        bean.setPw("TEST11");
//        bean.setNickname("TEST11");
//        bean.setUsername("TESTNAME11");
//
//        if (dao.do_insert_user(bean))
//            System.out.println("성공!");

//        UserBean bean = new UserBean();
//        bean.setEmail("TEST11@NAVER.COM");
//        bean.setPw("수정");
//        bean.setNickname("수정");
//        bean.setUsername("수정");
//        bean.setAddress("수정");
//        bean.setImage("수정");
//        bean.setInvite("Y");
//        bean.setPhone("010-0000-0000");
//        bean.setPublicrange("비공개");
//        bean.setWeb("hi");
//
//        if (dao.do_update_user(bean))
//            System.out.println("성공!");

//        UserBean bean = dao.do_search_user("TEST11@NAVER.COM");
//        System.out.println(bean.getNickname());

//        ArrayList<String> taglist = new ArrayList<>();
//        taglist.add("JAVA");
//        taglist.add("CSS");
//
//        ArrayList<UserBean> list = dao.do_search_openuser(taglist, 1);
//
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getNickname());


        // scheduleDAO

        ScheduleDAO dao = ScheduleDAO.getInstance();


//        ArrayList<UserScheduleBean> list = dao.do_search_todayuser("TEST1@NAVER.COM", "2017-02-10");
//
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getReason());

//        ArrayList<ProjectScheduleBean> list = dao.do_search_todayproject("TEST2@NAVER.COM", "2017-02-10");
//
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getReason());

//        ArrayList<UserScheduleBean> list = dao.do_search_userschedule("TEST1@NAVER.COM");
//
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getTitle());

//        UserScheduleBean bean = new UserScheduleBean();
//        bean.setTitle("테스트1");
//        bean.setReason("테스트");
//        bean.setPublicrange("Y");
//        bean.setEmail("TEST1@NAVER.COM");
//        bean.setDodate("2017-02-15");
//
//        if (dao.do_insert_userschedule(bean))
//            System.out.println("성공!");

//        ArrayList<UserCommentBean> list = dao.do_search_usercomment(3);
//
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i).getContentss());

//        UserCommentBean bean = new UserCommentBean();
//        bean.setSchedule_seq(1);
//        bean.setWriter("TEST3@NAVER.COM");
//        bean.setContentss("테스트");
//
//        if(dao.do_insert_usercomment(bean))
//            System.out.println("성공!");

//        ProjectScheduleBean bean = new ProjectScheduleBean();
//        bean.setDodate("2017-02-16");
//        bean.setWriter("TEST3@NAVER.COM");
//        bean.setDoperson("TEST7@NAVER.COM");
//        bean.setReason("테스트");
//        bean.setTitle("테스트");
//        bean.setProject_seq(2);
//
//        if (dao.do_insert_projectschedule(bean))
//            System.out.println("성공!");

//        ProjectScheduleBean bean = new ProjectScheduleBean();
//        bean.setDodate("2017-02-15");
//        bean.setWriter("TEST3@NAVER.COM");
//        bean.setDoperson("TEST7@NAVER.COM");
//        bean.setReason("테스트수정");
//        bean.setTitle("테스트수정");
//        bean.setProject_seq(2);
//        bean.setProgress(25);
//        bean.setPjschedule_seq(11);
//
//        if (dao.do_update_projectschedule(bean))
//            System.out.println("성공!");

//        UserScheduleBean bean = new UserScheduleBean();
//        bean.setTitle("수정");
//        bean.setReason("수정");
//        bean.setProgress(0);
//        bean.setPublicrange("Y");
//        bean.setMyschedule_seq(1);
//        dao.do_update_userschedule(bean);

//        ProjectScheduleBean bean = new ProjectScheduleBean();
//        bean.setPjschedule_seq(11);
//        dao.do_delete_projectschedule(bean);

//        ProjectCommentBean bean = new ProjectCommentBean();
//        bean.setSchedule_seq(3);
//        bean.setWriter("TEST7@NAVER.COM");
//        bean.setContentss("테스트");
//
//        if(dao.do_insert_projectcomment(bean))
//            System.out.println("성공!");

//        ArrayList<ProjectCommentBean> list = dao.do_search_projectcomment(3);
//
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i));

//        ArrayList<Object> list = dao.do_search_projectschedule(3);
//        for (int i = 0; i < list.size(); i++)
//            System.out.println(list.get(i));

//        UserScheduleBean bean = new UserScheduleBean();
//        bean.setMyschedule_seq(1);
//        dao.do_delete_userschedule(bean);

    }
}
