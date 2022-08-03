package mall.buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BuyDAO {

	private BuyDAO() {}
	
	private static BuyDAO instance = new BuyDAO();
	
	public static BuyDAO getInstance() {
		return instance;
	}
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 구매 목록 정보
	
	//구매 목록 추가
	
	
	//구매 목록 수정
		
		
	//구매 목록 삭제
	
	
}
