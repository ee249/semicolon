package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import vo.StarbucksVO;

@Repository
public class StarbucksDAOImpl implements StarbucksDAO{

	@Autowired
	SqlSession session = null;
	
	@Override
	public List<StarbucksVO> listAll() {
		String statement = "resource.StarbucksMapper.selectStarbucksinfo";
		List<StarbucksVO> list = session.selectList(statement);
		System.out.println("-------DAO------");
		System.out.println(list);
		System.out.println("----------------");
		return list;
	}

	@Override
	public boolean insert(StarbucksVO vo) {
		boolean result = false;
		String statement = "resource.StarbucksMapper.insertStarbucks";
		if (session.insert(statement, vo) == 1)
			result = true;
		return result;
	}

}
