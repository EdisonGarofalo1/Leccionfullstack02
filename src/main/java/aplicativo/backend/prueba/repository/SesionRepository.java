package aplicativo.backend.prueba.repository;



import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import aplicativo.backend.prueba.model.entities.Sesion;

public interface SesionRepository  extends  JpaRepository<Sesion,Integer >{
	

	@Query("SELECT s FROM Sesion s JOIN s.usuario u " +
		       "WHERE u.sessionActive = 'A' AND u.status = 'A' AND s.fechaCierre IS NULL AND u.idUsuario = ?1 " +
		       "ORDER BY s.idSesion DESC")
	Sesion findFirstByUsuarioAndFechaCierre(Integer id_usuario);
	
	
	   @Query("SELECT s FROM Sesion s INNER JOIN s.usuario u INNER JOIN u.persona p WHERE p.identificacion = :identificacion")
	    List<Sesion> buscarHistorialPorIdentificacion(@Param("identificacion") String identificacion);

}
