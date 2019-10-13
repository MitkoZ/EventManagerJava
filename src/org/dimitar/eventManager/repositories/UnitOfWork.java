package org.dimitar.eventManager.repositories;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class UnitOfWork {
	private UsersRepository usersRepository;

	private SessionFactory sessionFactory;
	private Session hibernateSession;
	private static UnitOfWork unitOfWork;

	private UnitOfWork() {
		// A SessionFactory is set up once for an application!
		StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
		// configures settings
		// from
		// hibernate.cfg.xml
		try {
			this.sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();

			this.hibernateSession = sessionFactory.getCurrentSession();
			this.hibernateSession.beginTransaction();
		} catch (Exception e) {
			// The registry would be destroyed by the SessionFactory, but we had trouble
			// building the SessionFactory
			// so destroy it manually.
			System.out.println("An exception occured :(");
			System.out.println(e);
			StandardServiceRegistryBuilder.destroy(registry);
		}
	}

	public static UnitOfWork getUnitOfWork() {
		if (unitOfWork == null) {
			unitOfWork = new UnitOfWork();
		}
		return unitOfWork;
	}

	public UsersRepository getUsersRepository() {
		if (this.usersRepository == null) {
			this.usersRepository = new UsersRepository(this.hibernateSession);
		}

		return usersRepository;
	}

	public Integer commit() {
		try {
			this.hibernateSession.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			return -1;
		}

		return 1;
	}
}
