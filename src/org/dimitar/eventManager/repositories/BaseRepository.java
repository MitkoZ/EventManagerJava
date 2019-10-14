package org.dimitar.eventManager.repositories;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.ParameterExpression;
import javax.persistence.criteria.Root;

import org.apache.commons.collections4.CollectionUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public abstract class BaseRepository<T> {

	private final Class<T> modelType;
	
	public BaseRepository(Class<T> modelType) {
		this.modelType = modelType;
	}

	private Class<T> getModelType() {
		return this.modelType;
	}

	public List<T> GetAll() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			List<T> items = session.createCriteria(this.getModelType()).list();
			return items;
		} catch (Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			return new ArrayList<T>();
		}
		finally {
			session.close();
		}
	}

	public T findByField(String fieldName, String yourFieldValue) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.getModelType());
			Root<T> root = criteriaQuery.from(this.getModelType());
			criteriaQuery.select(root);

			ParameterExpression<String> params = criteriaBuilder.parameter(String.class);
			criteriaQuery.where(criteriaBuilder.equal(root.get(fieldName), params));

			TypedQuery<T> query = session.createQuery(criteriaQuery);
			query.setParameter(params, yourFieldValue);

			List<T> queryResult = query.getResultList();

			T returnObject = null;

			if (CollectionUtils.isNotEmpty(queryResult)) {
				returnObject = (T) queryResult.get(0);
			}

			return returnObject;

		} catch (Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			return null;
		}
		finally {
			session.close();
		}
	}

	public T findByField(String fieldName, Integer yourFieldValue) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.getModelType());
			Root<T> root = criteriaQuery.from(this.getModelType());
			criteriaQuery.select(root);

			ParameterExpression<Integer> params = criteriaBuilder.parameter(Integer.class);
			criteriaQuery.where(criteriaBuilder.equal(root.get(fieldName), params));

			TypedQuery<T> query = session.createQuery(criteriaQuery);
			query.setParameter(params, yourFieldValue);

			List<T> queryResult = query.getResultList();

			T returnObject = null;

			if (CollectionUtils.isNotEmpty(queryResult)) {
				returnObject = (T) queryResult.get(0);
			}

			return returnObject;
		} catch (Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			
			return null;
		}
		finally {
			session.close();
		}
	}
}
