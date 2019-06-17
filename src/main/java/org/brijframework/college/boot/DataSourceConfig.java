package org.brijframework.college.boot;

import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = { "org.brijframework.college.dao","org.brijframework.college.service" })
public class DataSourceConfig {

	@Bean(name = "dataSource")
	public DataSource dataSource() {
		BasicDataSource dataSource= new BasicDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://localhost:3306/fadsan_school");
		dataSource.setUsername("root");
		dataSource.setPassword("root");
		return dataSource;
	}

	@Bean(name = "sessionFactory")
	public LocalSessionFactoryBean sessionFactory() {
		LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
		sessionFactory.setDataSource(dataSource());
		sessionFactory.setPackagesToScan(new String[] { "org.brijframework.college.model" });
		sessionFactory.setHibernateProperties(hibernateProperties());
		return sessionFactory;
	}

	@Bean(name = "transactionManager")
	public HibernateTransactionManager transactionManager() {
		HibernateTransactionManager txManager = new HibernateTransactionManager();
		txManager.setSessionFactory(sessionFactory().getObject());
		return txManager;
	}

	@SuppressWarnings("serial")
	private Properties hibernateProperties() {
		return new Properties() {
			{
				setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
				setProperty("hibernate.show_sql", "true");
				setProperty("hibernate.hbm2ddl.auto", "update");
			}
		};
	}
	
	/*
	 * @Bean(name = "contentNegotiationManager") public
	 * ContentNegotiationManagerFactoryBean contentNegotiationManager() {
	 * ContentNegotiationManagerFactoryBean bean =new
	 * ContentNegotiationManagerFactoryBean();
	 * bean.setDefaultContentType(MediaType.TEXT_PLAIN); return bean; }
	 * 
	 * @Bean public
	 * org.springframework.web.servlet.view.ContentNegotiatingViewResolver
	 * contentNegotiatingViewResolver() { ContentNegotiatingViewResolver
	 * resolver=new ContentNegotiatingViewResolver();
	 * resolver.setContentNegotiationManager(contentNegotiationManager().getObject()
	 * ); return resolver; }
	 */
}