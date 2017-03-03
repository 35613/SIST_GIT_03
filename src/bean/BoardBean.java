package bean;

import java.io.Serializable;

public class BoardBean implements Serializable {

	private int post_seq;
	private String writer;
	private int readcount;
	private String isdeleted;
	private String writedate;
	private int project_seq;
	private String contentss;
	private String writernickname;
    private String projectname;
    private String writerimage;
	
	public BoardBean() {
		// TODO Auto-generated constructor stub
	}
	
	public BoardBean(int post_seq, String writer, int readcount, String isdeleted, String writedate, int project_seq,
			String contentss, String writernickname, String projectname, String writerimage) {
		super();
		this.post_seq = post_seq;
		this.writer = writer;
		this.readcount = readcount;
		this.isdeleted = isdeleted;
		this.writedate = writedate;
		this.project_seq = project_seq;
		this.contentss = contentss;
		this.writernickname = writernickname;
		this.projectname = projectname;
		this.writerimage = writerimage;
	}





	public int getPost_seq() {
		return post_seq;
	}

	public void setPost_seq(int post_seq) {
		this.post_seq = post_seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String isIsdeleted() {
		return isdeleted;
	}

	public void setIsdeleted(String isdeleted) {
		this.isdeleted = isdeleted;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public int getProject_seq() {
		return project_seq;
	}

	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}

	public String getContentss() {
		return contentss;
	}

	public void setContentss(String contentss) {
		this.contentss = contentss;
	}

    public String getIsdeleted() {
        return isdeleted;
    }

    public String getWriternickname() {
        return writernickname;
    }

    public void setWriternickname(String writernickname) {
        this.writernickname = writernickname;
    }

    public String getProjectname() {
        return projectname;
    }

    public void setProjectname(String projectname) {
        this.projectname = projectname;
    }
    
	public String getWriterimage() {
		return writerimage;
	}

	public void setWriterimage(String writerimage) {
		this.writerimage = writerimage;
	}

	@Override
	public String toString() {
		return "BoardBean [post_seq=" + post_seq + ", writer=" + writer + ", readcount=" + readcount + ", isdeleted="
				+ isdeleted + ", writedate=" + writedate + ", project_seq=" + project_seq + ", contentss=" + contentss
				+ ", writernickname=" + writernickname + ", projectname=" + projectname + ", writerimage=" + writerimage
				+ "]";
	}

}
