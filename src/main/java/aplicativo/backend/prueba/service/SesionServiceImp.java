package aplicativo.backend.prueba.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import aplicativo.backend.prueba.dto.usuarioDTO;
import aplicativo.backend.prueba.model.entities.Sesion;
import aplicativo.backend.prueba.model.entities.Usuario;
import aplicativo.backend.prueba.repository.SesionRepository;
import aplicativo.backend.prueba.repository.UsuarioRepository;
import aplicativo.backend.prueba.response.ResponseData;
import aplicativo.backend.prueba.util.MessageUtil;



@Service
public class SesionServiceImp implements  SesionService{

	
	@Autowired
	   private SesionRepository sesionRepository;
	
	@Autowired
	   private UsuarioRepository   usuarioRepository;
	 @Autowired
	    private ModelMapper modelMapper;

	@Override
	public ResponseData login(String usuariomail,String password)  {
		Map<String, Object> mapUser = new HashMap<>();
		
		ResponseData response = new ResponseData();
		try {
			 Usuario usuarioDb = usuarioRepository.findByUsernameOrEmail(usuariomail,usuariomail);

                 if(usuarioDb != null ) {
			 
			 
			 if ( usuarioDb.getPassword().equals(password)) {
		        	
				 if(usuarioDb.getStatus() != null && usuarioDb.getStatus().trim().equalsIgnoreCase("Bloqueado")) {
					 response.setMessage("El usuario está bloqueado. Contacte al administrador.");;
					 
					 return response;
					 
				 } else {
				 
	        	
				 boolean existeSecionActiva = usuarioRepository.findByUsuarioIdAndActivaTrue(usuarioDb.getIdUsuario());
	        	
				 if(existeSecionActiva) {
					 response.setMessage("Ya existe una sesión activa para este usuario");
					 return response;
				
				 }
				 usuarioDb.setSessionActive("A");
				 
				 Sesion sesion = new Sesion();
	        	
	             sesion.setUsuario(usuarioDb);
	           
	             sesion.setFechaIngreso(new Date(System.currentTimeMillis()));
	           
	             sesionRepository.save(sesion);
	             usuarioDTO userDTO = convertToDTO(usuarioDb);
					
					mapUser.put("user", userDTO);
					
	   
	             response.setMessage("Se logueo con exito");
	             response.setCode(usuarioDb.getRoles().get(0).getRolName());
	             response.setData(mapUser);
	             return response;
	            
				 }
	        }else {
	        	
	        	 int intentosFallidos = usuarioDb != null ? usuarioDb.getIntentosFallidos() + 1 : 1;
	             if (intentosFallidos >= 3) {
	                 usuarioDb.setStatus("B");
	                 response.setMessage("El usuario ha sido bloqueado después de tres intentos fallidos.");
	             
	               
	             } else {
	                 usuarioDb.setIntentosFallidos(intentosFallidos);
	                 response.setMessage("Credenciales de inicio de sesión incorrectas. Intento " + intentosFallidos + "/3");
	                 
	             }
	             usuarioRepository.save(usuarioDb);
	            
	             return response;
	           
	        }}else {
			  
			 response.setMessage("Credenciales de inicio de sesión incorrectas.");
			 return response;
	        	
	        }
			
			
		} catch (Exception e) {
	     
			response.setCode(MessageUtil.INTERNALERROR.name());
			response.setMessage(MessageUtil.INTERNALERROR.getKey() + e.getMessage());
		}
		
	     return response;
	}

	@Override
	public ResponseData logout(String usuariomail)  {
		ResponseData response = new ResponseData();
		try {
			 Usuario usuarioDb = usuarioRepository.findByUsernameOrEmail(usuariomail,usuariomail);
		
			 if (usuarioDb != null) {
				 usuarioDb.setSessionActive("E");
		
				 Sesion sesionAbierta = sesionRepository.findFirstByUsuarioAndFechaCierre(usuarioDb.getIdUsuario());
				 if (sesionAbierta != null) {
					 sesionAbierta.setFechaCierre( new Date(System.currentTimeMillis()));
					 sesionRepository.save(sesionAbierta);
					 
					 usuarioDb.setSessionActive("E");
			            
			            usuarioRepository.save(usuarioDb);
			            response.setMessage("Sesión cerrada  corretamente.");
			            response.setCode("ok");
					 
				 }else {
					 
					 response.setMessage("No hay Sesión abierta.");
					 
				 }
				 
	       
			 
			 }else {
				 
				  response.setMessage("Usuario no encontrado.");
				 
			 }
			 
		
			
			
	   
	        
		} catch (Exception e) {
			response.setCode(MessageUtil.INTERNALERROR.name());
			response.setMessage(MessageUtil.INTERNALERROR.getKey() + e.getMessage());
		}
	     return response;
		
	}

	@Override
	public ResponseData recuperarPassword(String username) {
		
		ResponseData response = new ResponseData();
		Map<String, Object> mapUser = new HashMap<>();
		
		try {
		   Usuario usuario = usuarioRepository.findByUsernameOrEmail(username,username);
	        

			if (usuario != null) {
				
				usuarioDTO userDTO = convertToDTO(usuario);
				
				mapUser.put("user", userDTO);
				response.setData(mapUser);

				
				response.setCode(MessageUtil.OK.name());
				response.setMessage(MessageUtil.OK.getKey());
			} else {
				response.setCode(MessageUtil.NOTFOUND.name());
				response.setMessage(MessageUtil.NOTFOUND.getKey());
			}
		   
	} catch (Exception e) {
		response.setCode(MessageUtil.INTERNALERROR.name());
		response.setMessage(MessageUtil.INTERNALERROR.getKey() + e.getMessage());
	}
    return response;
	}
	
	  private usuarioDTO convertToDTO(Usuario user) {
	        return modelMapper.map(user, usuarioDTO.class); // Si estás utilizando ModelMapper
	       
	    }

	@Override
	public ResponseData buscarHistorialSesiones(String identificacion) {
		

		ResponseData response = new ResponseData();

		Map<String, Object> mapUsuario = new HashMap<>();
		try {

			 List<Sesion> data = sesionRepository.buscarHistorialPorIdentificacion(identificacion);
		
			if (data != null) {
				
				mapUsuario.put("Usuario", data);
				response.setData(mapUsuario);

				response.setCode(MessageUtil.OK.name());
				response.setMessage(MessageUtil.OK.getKey());
			} else {
				response.setCode(MessageUtil.NOTFOUND.name());
				response.setMessage(MessageUtil.NOTFOUND.getKey());
			}

		} catch (Exception e) {

			response.setCode(MessageUtil.ERRORCONSULTA.name());
			response.setMessage(MessageUtil.ERRORCONSULTA.getKey() + e.getMessage());
		}
	
	return response;

	}

}
