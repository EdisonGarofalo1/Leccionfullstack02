package aplicativo.backend.prueba.dto;

import javax.persistence.Column;

public class usuarioDTO {

	private String userName;


    private String password;

 
    private String mail;


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getMail() {
		return mail;
	}


	public void setMail(String mail) {
		this.mail = mail;
	}
    

}
