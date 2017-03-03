package bean;

import java.io.Serializable;

public class ProjectScheduleBean implements Serializable {

	private int pjschedule_seq;
	private String dodate;
	private String writer;
	private String doperson;
	private String reason;
	private int progress;
	private int project_seq;
	private String isdeleted;
	private String title;
	private String projectname;
	
	public ProjectScheduleBean() {}
	

	public ProjectScheduleBean(int pjschedule_seq, String dodate, String writer, String doperson, String reason,
			int progress, int project_seq, String isdeleted, String title, String projectname) {
		super();
		this.pjschedule_seq = pjschedule_seq;
		this.dodate = dodate;
		this.writer = writer;
		this.doperson = doperson;
		this.reason = reason;
		this.progress = progress;
		this.project_seq = project_seq;
		this.isdeleted = isdeleted;
		this.title = title;
		this.projectname = projectname;
	}




	public int getPjschedule_seq() {
		return pjschedule_seq;
	}

	public void setPjschedule_seq(int pjschedule_seq) {
		this.pjschedule_seq = pjschedule_seq;
	}

	public String getDodate() {
		return dodate;
	}

	public void setDodate(String dodate) {
		this.dodate = dodate;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getDoperson() {
		return doperson;
	}

	public void setDoperson(String doperson) {
		this.doperson = doperson;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}

	public int getProject_seq() {
		return project_seq;
	}

	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}

	public String getIsdeleted() {
		return isdeleted;
	}

	public void setIsdeleted(String isdeleted) {
		this.isdeleted = isdeleted;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}


	@Override
	public String toString() {
		return "ProjectScheduleBean [pjschedule_seq=" + pjschedule_seq + ", dodate=" + dodate + ", writer=" + writer
				+ ", doperson=" + doperson + ", reason=" + reason + ", progress=" + progress + ", project_seq="
				+ project_seq + ", isdeleted=" + isdeleted + ", title=" + title + ", projectname=" + projectname + "]";
	}

	



	
	
}
