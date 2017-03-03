package bean;

import java.io.Serializable;

public class TagBean implements Serializable {

	private String tagname;
	private String email;
	private int project_seq;
	
	public TagBean() {}
	
	public TagBean(String tagname, String email, int project_seq) {
		super();
		this.tagname = tagname;
		this.email = email;
		this.project_seq = project_seq;
	}

	public String getTagname() {
		return tagname;
	}

	public void setTagname(String tagname) {
		this.tagname = tagname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getProject_seq() {
		return project_seq;
	}

	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}

	@Override
	public String toString() {
		return "TagBean [tagname=" + tagname + ", email=" + email + ", project_seq=" + project_seq + "]";
	}

	
	
	
	
	

}
