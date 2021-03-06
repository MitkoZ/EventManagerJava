package org.dimitar.eventManager.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.dimitar.eventManager.models.interfaces.IEntity;
import org.hibernate.annotations.GenericGenerator;
import java.util.*;
import javax.persistence.CascadeType;

@Entity
@Table(name = "Users")
public class User implements IEntity {

	@Id
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	@Column(name = "Id")
	private Integer id;

	@Column(name = "Username", nullable = false, unique = true)
	private String username;

	@Column(name = "Password", nullable = false)
	private String password;

	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Event> Events = new ArrayList<Event>();

	public User() {

	}

	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public List<Event> getEvents() {	
		return this.Events;
	}

	public void setEvents(List<Event> events) {
		this.Events = events;
	}
}
