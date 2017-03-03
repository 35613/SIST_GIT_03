package bean;

import java.io.Serializable;

public class FileBean implements Serializable {

	private int file_seq;
	private String original_file_name;
	private String stored_file_name;
	private int post_seq;
	private int project_seq;
	
	public FileBean() {
		// TODO Auto-generated constructor stub
	}

	public FileBean(int file_seq, String original_file_name, String stored_file_name, int post_seq, int project_seq) {
		super();
		this.file_seq = file_seq;
		this.original_file_name = original_file_name;
		this.stored_file_name = stored_file_name;
		this.post_seq = post_seq;
		this.project_seq = project_seq;
	}

	public int getFile_seq() {
		return file_seq;
	}

	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}

	public String getOriginal_file_name() {
		return original_file_name;
	}

	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}

	public String getStored_file_name() {
		return stored_file_name;
	}

	public void setStored_file_name(String stored_file_name) {
		this.stored_file_name = stored_file_name;
	}

	public int getPost_seq() {
		return post_seq;
	}

	public void setPost_seq(int post_seq) {
		this.post_seq = post_seq;
	}

	public int getProject_seq() {
		return project_seq;
	}

	public void setProject_seq(int project_seq) {
		this.project_seq = project_seq;
	}

	@Override
	public String toString() {
		return "FileBean [file_seq=" + file_seq + ", original_file_name=" + original_file_name + ", stored_file_name="
				+ stored_file_name + ", post_seq=" + post_seq + ", project_seq=" + project_seq + "]";
	}
	
	

	



	
}
