package bean;

import java.io.Serializable;

public class InvitationBean implements Serializable
{
	private int invite_seq;
	private String invite_date;
	private String confirmed;
	private int project_seq;
	private String email;
	private String projectname;
	
	public InvitationBean() {
		// TODO Auto-generated constructor stub
	}

	public InvitationBean(int invite_seq, String invite_date, String confirmed, int project_seq, String email, String projectname) {
		this.invite_seq = invite_seq;
		this.invite_date = invite_date;
		this.confirmed = confirmed;
		this.project_seq = project_seq;
		this.email = email;
		this.projectname = projectname;
	}

	public int getInvite_seq() {
		return invite_seq;
	}

	public void setInvite_seq(int invite_seq) {
		this.invite_seq = invite_seq;
	}

	public String getInvite_date() {
		return invite_date;
	}

	public void setInvite_date(String invite_date) {
		this.invite_date = invite_date;
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

	@Override
	public String toString() {
		return "InvitationBean [invite_seq=" + invite_seq + ", invite_date=" + invite_date + ", confirmed=" + confirmed
				+ ", project_seq=" + project_seq + ", email=" + email + "]";
	}
	
	
	
}
