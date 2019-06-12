package org.brijframework.college.boot;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@SpringBootApplication
@ImportResource({
	"classpath*:spring-excel-views.xml",
	"classpath*:spring-pdf-views.xml",
	"classpath*:spring-security.xml",
	"classpath*:spring-beans.xml",
	"classpath*:spring-servlet.xml"
})
@EnableJpaRepositories
@EnableWebMvc
@EnableWebMvcSecurity
public class SpringApp {

	public static void main(String[] args) {
        SpringApplication.run(SpringApp.class, args);
        BasicDataSource dataSource=new BasicDataSource();
    }
}