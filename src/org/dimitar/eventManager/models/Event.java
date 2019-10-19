package org.dimitar.eventManager.models;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import java.time.LocalDateTime;

@Entity
@Table(name = "Events")
public class Event {
	
	@Id
	@GeneratedValue(generator="increment")
	@GenericGenerator(name="increment", strategy = "increment")
	@Column(name = "Id")
    private Integer id;

	@Column(name = "Name", nullable = false)
    private String name;
    
	@Column(name = "StartDateTime", nullable = false)
    private LocalDateTime startDateTime;
	
	@Column(name = "EndDateTime", nullable = false)
	private LocalDateTime endDateTime;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UserId", nullable = false)
	private User user;
	
	public Event() {
		// this form used by Hibernate
	}

	public Event(String name, LocalDateTime startDateTime, LocalDateTime endDateTime) {
		// for application use, to create new events
		this.name = name;
		this.startDateTime = startDateTime;
		this.endDateTime = endDateTime;
	}

    public Integer getId() {
		return id;
    }

    private void setId(Integer id) {
		this.id = id;
    }

    public String getName() {
		return name;
    }

    public void setName(String name) {
		this.name = name;
    }

	public LocalDateTime getStartDateTime() {
		return startDateTime;
	}

	public void setStartDateTime(LocalDateTime startDateTime) {
		this.startDateTime = startDateTime;
	}

	public LocalDateTime getEndDateTime() {
		return endDateTime;
	}

	public void setEndDateTime(LocalDateTime endDateTime) {
		this.endDateTime = endDateTime;
	}
	
	public void setUser(User userDb) {
		this.user = userDb;
	}
	
}