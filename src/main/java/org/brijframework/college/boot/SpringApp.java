package org.brijframework.college.boot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@SpringBootApplication
@ImportResource({
	"classpath*:spring-excel-views.xml",
	"classpath*:spring-pdf-views.xml",
	"classpath*:spring-security.xml",
	"classpath*:spring-servlet.xml"
})
@EnableWebMvc
@EnableWebSecurity
public class SpringApp {

	public static void main(String[] args) {
        SpringApplication.run(SpringApp.class, args);
    }
}