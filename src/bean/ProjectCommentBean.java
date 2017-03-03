package bean;

import java.io.Serializable;

public class ProjectCommentBean implements Serializable {

	int comment_seq;
	String writer;
	String contentss;
	String dates;
	int schedule_seq;
	
	public ProjectCommentBean() {
		// TODO Auto-generated constructor stub
	}
	
	

	public ProjectCommentBean(int comment_seq, String writer, String contentss, String dates, int schedule_seq) {
		this.comment_seq = comment_seq;
		this.writer = writer;
		this.contentss = contentss;
		this.dates = dates;
		this.schedule_seq = schedule_seq;
	}



	public int getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
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

	public String getDates() {
		return dates;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}

	public int getSchedule_seq() {
		return schedule_seq;
	}

	public void setSchedule_seq(int schedule_seq) {
		this.schedule_seq = schedule_seq;
	}



	@Override
	public String toString() {
		return "ProjectCommentBean [comment_seq=" + comment_seq + ", writer=" + writer + ", contentss=" + contentss
				+ ", dates=" + dates + ", schedule_seq=" + schedule_seq + "]";
	}
	
	
}
