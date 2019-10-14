package org.dimitar.eventManager.repositories;

import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class HibernateUtil {

	private static SessionFactory sessionFactory;

	static {
		try {
			StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
			sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
			// A SessionFactory is set up once for an application!
			// configures settings
			// from
			// hibernate.cfg.xml
		} catch (Exception e) {
			// The registry would be destroyed by the SessionFactory, but we had trouble
			// building the SessionFactory
			// so destroy it manually.
			System.out.println("An exception occured :(");
			System.out.println(e);
		}
	}

	public static SessionFactory getSessionFactory() {
		return sessionFactory;
	}

}