package aplicativo.backend.prueba.config;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
@Configuration
public class AppConfi {
	@Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }
}
