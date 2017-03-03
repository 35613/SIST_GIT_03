package bean;

import java.io.Serializable;

public class UserBean implements Serializable {

	private String email;
	private String pw;
	private String nickname;
	private String username;
	private String phone;
	private String address;
	private String web;
	private String publicrange;
	private String image;
	private String invite;
	
	public UserBean() {}
	
	public UserBean(String email, String pw, String nickname, String username, String phone, String address, String web,
                    String publicrange, String image, String invite) {
		this.email = email;
		this.pw = pw;
		this.nickname = nickname;
		this.username = username;
		this.phone = phone;
		this.address = address;
		this.web = web;
		this.publicrange = publicrange;
		this.image = image;
		this.invite = invite;
	}
	
	//    //가입된 회원 가져오는 메소드   --빈 수정 필요 4개만 필요한 생성자 만들자
	public UserBean(String email, String nickname, String username, String web) {
		this.email = email;
		this.nickname = nickname;
		this.username = username;
		this.web = web;

	}
	
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getWeb() {
		return web;
	}

	public void setWeb(String web) {
		this.web = web;
	}

	public String getPublicrange() {
		return publicrange;
	}

	public void setPublicrange(String publicrange) {
		this.publicrange = publicrange;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getInvite() {
		return invite;
	}

	public void setInvite(String invite) {
		this.invite = invite;
	}

	@Override
	public String toString() {
		return "UserBean [email=" + email + ", pw=" + pw + ", nickname=" + nickname + ", username=" + username
				+ ", phone=" + phone + ", address=" + address + ", web=" + web + ", publicrange=" + publicrange
				+ ", image=" + image + ", invite=" + invite + "]";
	}
	
	
	

	
	
	
	

}
