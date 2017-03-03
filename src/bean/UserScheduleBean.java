package bean;

import java.io.Serializable;

public class UserScheduleBean implements Serializable {
	
	private int myschedule_seq;
	private int progress;
	private String dodate;
	private String reason;
	private String email;
	private String title;
	private String publicrange;
	private String isdeleted;
	
	public UserScheduleBean() {}
	
	public UserScheduleBean(int myschedule_seq, int progress, String dodate, String reason, String email, String title,
			String publicrange, String isdeleted) {
		this.myschedule_seq = myschedule_seq;
		this.progress = progress;
		this.dodate = dodate;
		this.reason = reason;
		this.email = email;
		this.title = title;
		this.publicrange = publicrange;
		this.isdeleted = isdeleted;
	}
	
	public int getMyschedule_seq() {
		return myschedule_seq;
	}

	public void setMyschedule_seq(int myschedule_seq) {
		this.myschedule_seq = myschedule_seq;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}

	public String getDodate() {
		return dodate;
	}

	public void setDodate(String dodate) {
		this.dodate = dodate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublicrange() {
		return publicrange;
	}

	public void setPublicrange(String publicrange) {
		this.publicrange = publicrange;
	}

	public String getIsdeleted() {
		return isdeleted;
	}

	public void setIsdeleted(String isdeleted) {
		this.isdeleted = isdeleted;
	}

	@Override
	public String toString() {
		return "UserScheduleBean [myschedule_seq=" + myschedule_seq + ", progress=" + progress + ", dodate=" + dodate
				+ ", reason=" + reason + ", email=" + email + ", title=" + title + ", publicrange=" + publicrange
				+ ", isdeleted=" + isdeleted + "]";
	}
	
	
	
	

}
