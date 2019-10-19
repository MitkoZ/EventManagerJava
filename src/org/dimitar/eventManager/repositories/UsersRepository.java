package org.dimitar.eventManager.repositories;

import org.dimitar.eventManager.models.User;

public class UsersRepository extends BaseRepository<User> {
	public UsersRepository() {
		super(User.class);
	}
}
