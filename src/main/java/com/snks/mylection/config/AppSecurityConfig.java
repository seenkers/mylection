package com.snks.mylection.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;


@Configuration
@EnableWebSecurity
public class AppSecurityConfig extends WebSecurityConfigurerAdapter {
	
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth
        .inMemoryAuthentication()
          .withUser("user")  // #1
            .password("user")
            .roles("USER")
            .and()
          .withUser("admin") // #2
            .password("admin")
            .roles("ADMIN","USER");
    }
    
    @Override
    public void configure(WebSecurity web) throws Exception {
      web
        .ignoring()
           .antMatchers("/resources/**"); // #3
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
        .authorizeRequests()
        .antMatchers("/login","/about").permitAll() // #4
        .antMatchers("/admin/**").hasRole("ADMIN") // #6
        .anyRequest().authenticated() // 7
        .and()
    .formLogin()  // #8
        .loginPage("/login"); // #9
        http
        .csrf().disable();
    }
    
    
    /*
    @Override
    protected void configure(AuthenticationManagerBuilder auth)
    		throws Exception {
    	super.configure(auth);
    	auth.authenticationProvider(authenticationProvider());
    }
    
    @Bean
    @Override
    public UserDetailsService userDetailsServiceBean() throws Exception {
    	 return new UserDetailsServiceImpl();
    }
    
    @Bean 
    public DaoAuthenticationProvider authenticationProvider() { 
    	return new CustomDaoAuthenticationProvider(); 
    }
    */ 
    
}