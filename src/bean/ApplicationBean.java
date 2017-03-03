package bean;

import java.io.Serializable;

public class ApplicationBean implements Serializable {

	private int appl_seq;
	private String sendid;
	private String contentss;
	private String apply_date;
	private String confirmed;
	private int project_seq;
	private String email;
	private String projectname;
	private String sendimage;

	public ApplicationBean() {
		// TODO Auto-generated constructor stub
	}

	public ApplicationBean(int appl_seq, String sendid, String contentss, String apply_date, String confirmed,
			int project_seq, String email, String projectname, String sendimage) {
		super();
		this.appl_seq = appl_seq;
		this.sendid = sendid;
		this.contentss = contentss;
		this.apply_date = apply_date;
		this.confirmed = confirmed;
		this.project_seq = project_seq;
		this.email = email;
		this.projectname = projectname;
		this.sendimage = sendimage;
	}

	public int getAppl_seq() {
		return appl_seq;
	}

	public void setAppl_seq(int appl_seq) {
		this.appl_seq = appl_seq;
	}

	public String getSendid() {
		return sendid;
	}

	public void setSendid(String sendid) {
		this.sendid = sendid;
	}

	public String getContentss() {
		return contentss;
	}

	public void setContentss(String contentss) {
		this.contentss = contentss;
	}

	public String getApply_date() {
		return apply_date;
	}

	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}

	public String getConfirmed() {
		return confirmed;
	}

	public void setConfirmed(String confirmed) {
		this.confirmed = confirmed;
	}

	public int getProject_seq() {
		return project_seq;
	}

	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	
	public String getSendimage() {
		return sendimage;
	}

	public void setSendimage(String sendimage) {
		this.sendimage = sendimage;
	}

	@Override
	public String toString() {
		return "ApplicationBean [appl_seq=" + appl_seq + ", sendid=" + sendid + ", contentss=" + contentss
				+ ", apply_date=" + apply_date + ", confirmed=" + confirmed + ", project_seq=" + project_seq
				+ ", email=" + email + ", projectname=" + projectname + ", sendimage=" + sendimage + "]";
	}
	
	
	
}

