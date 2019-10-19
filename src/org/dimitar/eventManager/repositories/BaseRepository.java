package org.dimitar.eventManager.repositories;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.ParameterExpression;
import javax.persistence.criteria.Root;

import org.apache.commons.collections4.CollectionUtils;

public abstract class BaseRepository<T> {

	private EntityManager entityManager;

	protected EntityManager getEntityManager() {
		if (entityManager == null || !entityManager.isOpen()) {
			this.entityManager = EntityManagerUtil.getEntityManager();
		}
		return entityManager;
	}

	private final Class<T> modelType;

	public BaseRepository(Class<T> modelType) {
		this.modelType = modelType;
	}

	private Class<T> getModelType() {
		return this.modelType;
	}

	public List<T> GetAll() {
		try {
			this.getEntityManager().getTransaction().begin();
			CriteriaBuilder builder = this.getEntityManager().getCriteriaBuilder();
			CriteriaQuery<T> query = builder.createQuery(this.getModelType());
			Root<T> variableRoot = query.from(this.getModelType());
			query.select(variableRoot);

			return getEntityManager().createQuery(query).getResultList();
		} catch (Exception e) {
			System.out.println("An exception occured :(");
			System.out.println(e);
			return new ArrayList<T>();
		} finally {
			this.getEntityManager().close();
		}
	}

	public T findByField(String fieldName, String yourFieldValue) {
		try {
			this.getEntityManager().getTransaction().begin();
			CriteriaBuilder criteriaBuilder = this.getEntityManager().getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.getModelType());
			Root<T> root = criteriaQuery.from(this.getModelType());
			criteriaQuery.select(root);

			ParameterExpression<String> params = criteriaBuilder.parameter(String.class);
			criteriaQuery.where(criteriaBuilder.equal(root.get(fieldName), params));

			TypedQuery<T> query = this.getEntityManager().createQuery(criteriaQuery);
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
		} finally {
			this.getEntityManager().close();
		}
	}

	public T findByField(String fieldName, Integer yourFieldValue) {
		try {
			this.getEntityManager().getTransaction().begin();
			CriteriaBuilder criteriaBuilder = this.getEntityManager().getCriteriaBuilder();
			CriteriaQuery<T> criteriaQuery = criteriaBuilder.createQuery(this.getModelType());
			Root<T> root = criteriaQuery.from(this.getModelType());
			criteriaQuery.select(root);

			ParameterExpression<Integer> params = criteriaBuilder.parameter(Integer.class);
			criteriaQuery.where(criteriaBuilder.equal(root.get(fieldName), params));

			TypedQuery<T> query = this.getEntityManager().createQuery(criteriaQuery);
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
		} finally {
			this.getEntityManager().close();
		}
	}
}
