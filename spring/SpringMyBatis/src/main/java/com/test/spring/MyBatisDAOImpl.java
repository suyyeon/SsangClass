package com.test.spring;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("dao")
public class MyBatisDAOImpl implements MyBatisDAO {

	@Autowired
	private SqlSessionTemplate template;
	
	@Override
	public void test() {
		
		System.out.println("3. " + (template == null));
	}
	
	@Override
	public void m1() {
		
		//MyBatis > XML 기반의 Query 작업
		
		//executeUpdate()
		//- template.insert(null)
		//- template.update(null)
		//- template.delete(null)
		
		//executeQuery()
		//- template.selectOne(null)
		//- template.selectList(null)
		
		template.insert("test.m1");
	}
	
	@Override
	public int m2(String seq) {
	
		return template.update("test.m2", seq);
	}
	
	@Override
	public int m3(String seq) {
		
		return template.delete("test.m3", seq);
	}
	
	@Override
	public int m4(MyBatisDTO dto) {
	
		return template.insert("test.m4", dto);
	}
	
	@Override
	public int m5(String seq) {
		
		//executeQuery() > 반환셋의 레코드 개수(컬럼X)
		//- template.selectOne(null)  > 0 or 1
		//- template.selectList(null) > 0 or 1 or infinite
		
		
		//PreparedState..
		//SQL
		//stat.setString
		//ResultSet rs = execute
		//if (rs.next()) 
		//rs.getInt("price")
		//return
		
		return template.selectOne("test.m5", seq);		
	}
	
	@Override
	public MyBatisDTO m6(String seq) {
	
		return template.selectOne("test.m6", seq);
	}
	
	@Override
	public List<String> m7() {
		
		//executeQuery() > 반환셋의 레코드 개수(컬럼X)
		//- template.selectOne(null)  > 0 or 1
		//- template.selectList(null) > 0 or 1 or infinite
		
		return template.selectList("test.m7");
	}
	
	@Override
	public List<MyBatisDTO> m8() {
	
		return template.selectList("test.m8");
	}
	
	@Override
	public int m9(String table) {
		
		return template.selectOne("test.m9", table);
	}
	
	@Override
	public List<MyBatisDTO> m10(String word) {
	
		return template.selectList("test.m10", word);
	}
	
	@Override
	public List<String> m11(String type) {
	
		return template.selectList("test.m11", type);
	}
}































