package bean;

import java.io.Serializable;

public class UserCommentBean implements Serializable {

	private int comment_seq;
	private int schedule_seq;
	private String dates;
	private String writer;
	private String writernickname;
	private String contentss;
	private String writerimage;
	
	public UserCommentBean() {}
	

	
	public UserCommentBean(int comment_seq, int schedule_seq, String dates, String writer, String writernickname,
			String contentss, String writerimage) {
		super();
		this.comment_seq = comment_seq;
		this.schedule_seq = schedule_seq;
		this.dates = dates;
		this.writer = writer;
		this.writernickname = writernickname;
		this.contentss = contentss;
		this.writerimage = writerimage;
	}



	public String getWriterimage() {
		return writerimage;
	}



	public void setWriterimage(String writerimage) {
		this.writerimage = writerimage;
	}



	public int getComment_seq() {
		return comment_seq;
	}


	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}


	public int getSchedule_seq() {
		return schedule_seq;
	}


	public void setSchedule_seq(int schedule_seq) {
		this.schedule_seq = schedule_seq;
	}


	public String getDates() {
		return dates;
	}


	public void setDates(String dates) {
		this.dates = dates;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public String getContentss() {
		return contentss;
	}


	public void setContentss(String contentss) {
		this.contentss = contentss;
	}
	
	public String getWriternickname() {
		return writernickname;
	}

	public void setWriternickname(String writernickname) {
		this.writernickname = writernickname;
	}



	@Override
	public String toString() {
		return "UserCommentBean [comment_seq=" + comment_seq + ", schedule_seq=" + schedule_seq + ", dates=" + dates
				+ ", writer=" + writer + ", writernickname=" + writernickname + ", contentss=" + contentss
				+ ", writerimage=" + writerimage + "]";
	}

	
	
	
	
}
