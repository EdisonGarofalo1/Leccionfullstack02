package aplicativo.backend.prueba.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.bind.annotation.RestController;


import aplicativo.backend.prueba.model.entities.Usuario;
import aplicativo.backend.prueba.response.ResponseData;
import aplicativo.backend.prueba.service.SesionService;


@RestController
@RequestMapping("api/sesion")
public class SesionController {
	
	@Autowired
	private  SesionService sesionService;
	
	


	
	@PostMapping("/login")
	public ResponseData login(@RequestBody Map<String, Object> requestBody) {
	  
	   
	    String usuariomail = (String) requestBody.get("usuariomail");
	    
	    String password = (String) requestBody.get("password");
	    
	    return sesionService.login(usuariomail,password);
	    
	
	}

	
	
	
	@PostMapping("/logout")
	 
	public ResponseData logout(@RequestBody Map<String, String> requestBody) {
		
           String usuariomail = (String) requestBody.get("usuariomail");
	    
	  
	
            return sesionService.logout(usuariomail);
            
     
	}
	
	@PostMapping("/password")
	public ResponseData detalle(@RequestBody Map<String, String> requestBody) {
		String username = requestBody.get("userName");
	    return sesionService.recuperarPassword(username);
	}

	
	@PostMapping("/buscarHistorialSesiones")
	public ResponseData buscarHistorialSesiones(@RequestBody Map<String, String> requestBody) {
		String identificacion = requestBody.get("identificacion");
	    return sesionService.buscarHistorialSesiones(identificacion);
	}

	
	
}
