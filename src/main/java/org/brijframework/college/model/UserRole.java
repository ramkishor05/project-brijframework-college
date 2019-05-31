package org.brijframework.college.model;

// Generated Sep 18, 2013 11:58:04 PM by Hibernate Tools 4.0.0

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * UserRole generated by hbm2java
 */
@Entity
@Table(name = "user_role")
public class UserRole extends AbstractPO<UserRoleId> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private UserRolePrimaryKey userRolePrimaryKey;

	public UserRole() {
	}

	public UserRole(UserRoleId id) {
		this.id = id;
	}

	@Override
	public UserRoleId getId() {
		// TODO Auto-generated method stub
		return this.id;
	}

	@Override
	public void setId(UserRoleId id) {
		this.id = id;

	}

	public UserRolePrimaryKey getUserRolePrimaryKey() {
		return userRolePrimaryKey;
	}

	public void setUserRolePrimaryKey(UserRolePrimaryKey userRolePrimaryKey) {
		this.userRolePrimaryKey = userRolePrimaryKey;
	}

}
