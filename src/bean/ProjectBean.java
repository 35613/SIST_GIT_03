package bean;

import java.io.Serializable;

public class ProjectBean implements Serializable {
	
	
	private int project_seq;
	private String projectname;
	private String leader;
	private String startdate;
	private String enddate;
	private int progress;
	private String readme;
	private String isopen;
	private String image;
	private String isend;
	
	
	public ProjectBean() {
		// TODO Auto-generated constructor stub
	}
	
	

	public ProjectBean(int project_seq, String projectname, String leader, String startdate, String enddate,
                       int progress, String readme, String isopen, String image, String isend) {
		this.project_seq = project_seq;
		this.projectname = projectname;
		this.leader = leader;
		this.startdate = startdate;
		this.enddate = enddate;
		this.progress = progress;
		this.readme = readme;
		this.isopen = isopen;
		this.image = image;
		this.isend = isend;
	}



	public int getProject_seq() {
		return project_seq;
	}

	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}

	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}

	public String getLeader() {
		return leader;
	}

	public void setLeader(String leader) {
		this.leader = leader;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}

	public String getReadme() {
		return readme;
	}

	public void setReadme(String readme) {
		this.readme = readme;
	}

	public String getIsopen() {
		return isopen;
	}

	public void setIsopen(String string) {
		this.isopen = string;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getIsend() {
		return isend;
	}

	public void setIsend(String string) {
		this.isend = string;
	}



	@Override
	public String toString() {
		return "ProjectBean [project_seq=" + project_seq + ", projectname=" + projectname + ", leader=" + leader
				+ ", startdate=" + startdate + ", enddate=" + enddate + ", progress=" + progress + ", readme=" + readme
				+ ", isopen=" + isopen + ", image=" + image + ", isend=" + isend + "]";
	}
	
	
}
