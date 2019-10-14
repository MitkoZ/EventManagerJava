package org.dimitar.eventManager.repositories;

import org.dimitar.eventManager.models.User;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class UsersRepository extends BaseRepository<User> {
	public UsersRepository() {
		super(User.class);
	}
	
	public Integer Save(User user) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = session.beginTransaction();
		try {
			session.save(user);
			transaction.commit();
			return 1;
		}
		catch(Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			return -1;
		}
		finally {
			session.close();
		}
		
	}
}
