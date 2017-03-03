package bean;

import java.io.Serializable;

public class BoardCommentBean implements Serializable {

	private int comment_seq;
	private String contentss;
	private String writer;
	private String writernickname;
	private String dates;
	private int post_seq;
	
	public BoardCommentBean() {
		// TODO Auto-generated constructor stub
	}
	
	

	public BoardCommentBean(int comment_seq, String contentss, String writer, String writernickname, String dates, int post_seq) {
		this.comment_seq = comment_seq;
		this.contentss = contentss;
		this.writer = writer;
		this.dates = dates;
		this.post_seq = post_seq;
	}

	public int getComment_seq() {
		return comment_seq;
	}

	public void setComment_seq(int comment_seq) {
		this.comment_seq = comment_seq;
	}

	public String getContentss() {
		return contentss;
	}

	public void setContentss(String contentss) {
		this.contentss = contentss;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

    public String getWriternickname() {
        return writernickname;
    }

    public void setWriternickname(String writernickname) {
        this.writernickname = writernickname;
    }

    public String getDates() {
		return dates;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}

	public int getPost_seq() {
		return post_seq;
	}

	public void setPost_seq(int post_seq) {
		this.post_seq = post_seq;
	}



	@Override
	public String toString() {
		return "BoardCommentBean [comment_seq=" + comment_seq + ", contentss=" + contentss + ", writer=" + writer
				+ ", dates=" + dates + ", post_seq=" + post_seq + "]";
	}
	
	
}