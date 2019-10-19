package org.dimitar.eventManager.repositories;

import org.dimitar.eventManager.models.User;

public class UsersRepository extends BaseRepository<User> {
	public UsersRepository() {
		super(User.class);
	}

	public Integer Save(User user) {
		try {
			this.getEntityManager().getTransaction().begin();

			if (user.getId() == null) {
				this.getEntityManager().persist(user); // update
			} else {
				this.getEntityManager().merge(user);// save
			}

			this.getEntityManager().getTransaction().commit();
		} catch (Exception e) {
			System.out.println("An exception occured: " + e);
			return -1;
		} finally {
			this.getEntityManager().close();
		}
		return 1;
	}
}
