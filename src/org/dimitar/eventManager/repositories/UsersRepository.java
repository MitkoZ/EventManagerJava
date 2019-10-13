package org.dimitar.eventManager.repositories;

import org.dimitar.eventManager.models.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class UsersRepository extends BaseRepository<User> {

	public UsersRepository(Session hibernateSession) {
		super(User.class, hibernateSession);
	}

	public void Save(User user) {
		this.hibernateSession.save(user);
	}
}
