package com.test.repository;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

@Repository
//@Primary
@Qualifier("admin")
public class AdminDAO implements IMemberDAO {

	public int test() {
		
		System.out.println("AdminDAO.test()");
		
		return (int)System.nanoTime();
	}	
}
