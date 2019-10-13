package org.dimitar.eventManager.repositories;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.ParameterExpression;
import javax.persistence.criteria.Root;

import org.apache.commons.collections4.CollectionUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public abstract class BaseRepository<T> {

	private final Class<T> modelType;
	protected final Session hibernateSession;

	public BaseRepository(Class<T> modelType, Session hibernateSession) {
		this.modelType = modelType;
		this.hibernateSession = hibernateSession;
	}

	private Class<T> getModelType() {
		return this.modelType;
	}

	public List<T> GetAll() {
		try {
			return this.hibernateSession.createCriteria(this.getModelType()).list();
		} catch (Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			return new ArrayList<T>();
		}
	}

	public T findByField(String fieldName, String yourFieldValue) {
		try {
			CriteriaBuilder criteriaBuilder = hibernateSession.getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.getModelType());
			Root<T> root = criteriaQuery.from(this.getModelType());
			criteriaQuery.select(root);

			ParameterExpression<String> params = criteriaBuilder.parameter(String.class);
			criteriaQuery.where(criteriaBuilder.equal(root.get(fieldName), params));

			TypedQuery<T> query = hibernateSession.createQuery(criteriaQuery);
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
	}

	public T findByField(String fieldName, Integer yourFieldValue) {
		try {
			CriteriaBuilder criteriaBuilder = hibernateSession.getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.getModelType());
			Root<T> root = criteriaQuery.from(this.getModelType());
			criteriaQuery.select(root);

			ParameterExpression<Integer> params = criteriaBuilder.parameter(Integer.class);
			criteriaQuery.where(criteriaBuilder.equal(root.get(fieldName), params));

			TypedQuery<T> query = hibernateSession.createQuery(criteriaQuery);
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
	}
}
