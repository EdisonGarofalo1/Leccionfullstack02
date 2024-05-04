package aplicativo.backend.prueba.service;


import aplicativo.backend.prueba.model.entities.Usuario;
import aplicativo.backend.prueba.response.ResponseData;


public interface SesionService  {
	

	public ResponseData login( String usuariomail,String password) ;
	
	public ResponseData logout(String username) ;
	public ResponseData recuperarPassword(String username) ;
	public ResponseData buscarHistorialSesiones(String identificacion) ;


}
