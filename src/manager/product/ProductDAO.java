package manager.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class ProductDAO {
	
	private ProductDAO() {}
	
	private static ProductDAO instance = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	// DB연결, 질의를 위한 객체 변수
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//#######################
	// manager.product에서 사용하는 메소드
	
	// 상품 등록 메소드
	public void insertProduct(ProductDTO product) {
		String sql = "insert into "
				+ "product(product_kind, product_name, product_color, product_price, product_count, product_com,"
				+ "product_country, product_date,product_image1,product_image2, product_image3, product_content,discount_rate)"
				+ " values(? ,? ,? ,? ,? ,? ,? ,? ,?, ?, ?, ?, ?)";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setString(3, product.getProduct_color());
			pstmt.setInt(4, product.getProduct_price());
			pstmt.setInt(5, product.getProduct_count());
			pstmt.setString(6, product.getProduct_com());
			pstmt.setString(7, product.getProduct_country());
			pstmt.setString(8, product.getProduct_date());
			pstmt.setString(9, product.getProduct_image1());
			pstmt.setString(10, product.getProduct_image2());
			pstmt.setString(11, product.getProduct_image3());
			pstmt.setString(12, product.getProduct_content());
			pstmt.setInt(13, product.getDiscount_rate());
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			System.out.println("insertProduct 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	// 전체 상품 수 조회 메소드 - 검색하지 않은 상품 수
	public int getProductCount() {
		String sql ="select count(*) from product";
		int cnt =0;
		
		try {
			conn=JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1); // rs의 첫번째값을 가져온다. 즉 : cnt에 product 갯수를 넣는다. 
			
		}catch(Exception e) {
			System.out.print("getProductCount 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
		
	}
	
	// 전체 상품 수 조회 메소드 - 검색했을 때
		public int getProductCount(String s_search, String i_search) {
			String sql ="select count(*) from product where ";
			if(s_search.equals("상품명")) {
				sql += "product_name";
			} else if(s_search.equals("컬러")) {
				sql += "product_color";
			} else if(s_search.equals("제조사")) {
				sql += "product_com";
			}
				sql += " like ?";
			
			int cnt =0;
			
			try {
				conn=JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + i_search + "%");
				rs = pstmt.executeQuery();
				rs.next();
				cnt = rs.getInt(1); // rs의 첫번째값을 가져온다. 즉 : cnt에 product 갯수를 넣는다. 
				
			}catch(Exception e) {
				System.out.print("getProductCount 메소드 : " + e.getMessage());
				e.printStackTrace();
			}finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return cnt;
			
		}
		
	// 전체 상품 조회 메소드 : 검색 처리를 하지 않은 것 !!!!
	public List<ProductDTO> getProductList(int startRow, int pageSize) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product order by product_id desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				// 11개의 정보
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_color(rs.getString("product_color"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_com(rs.getString("product_com"));
				product.setProduct_country(rs.getString("product_country"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
			
		}catch(Exception e) {
			System.out.println("getProductList 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 검색한 전체 상품 조회 메소드 - 페이징 처리, 검색 처리를 함
	public List<ProductDTO> getProductList(int startRow, int pageSize, String s_search, String i_search) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where ";
			if(s_search.equals("상품명")) {
				sql += "product_name";
			} else if(s_search.equals("컬러")) {
				sql += "product_color";
			} else if(s_search.equals("제조사")) {
				sql += "product_com";
			}
				sql += " like ? order by product_id desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + i_search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				// 11개의 정보
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_com(rs.getString("product_com"));
				product.setProduct_country(rs.getString("product_country"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
			
		}catch(Exception e) {
			System.out.println("getProductList 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	
	// 상품 상세 보기(1건 보기) 메소드
	public ProductDTO getProduct(int product_id) {
		ProductDTO product = new ProductDTO();
		String sql = "select * from product where product_id = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			rs.next();
			
			// 12개의 정보
			product.setProduct_id(rs.getInt("product_id"));
			product.setProduct_kind(rs.getString("product_kind"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_color(rs.getString("product_color"));
			product.setProduct_price(rs.getInt("product_price"));
			product.setProduct_count(rs.getInt("product_count"));
			product.setProduct_com(rs.getString("product_com"));
			product.setProduct_country(rs.getString("product_country"));
			product.setProduct_date(rs.getString("product_date"));
			product.setProduct_image1(rs.getString("product_image1"));
			product.setProduct_image2(rs.getString("product_image2"));
			product.setProduct_image3(rs.getString("product_image3"));
			product.setProduct_content(rs.getString("product_content"));
			product.setDiscount_rate(rs.getInt("discount_rate"));
			product.setReg_date(rs.getTimestamp("reg_date"));
			
		}catch(Exception e) {
			System.out.println("getProduct 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return product;
	}
	
	// 상품 수정 메소드
	public void updateProduct(ProductDTO product) {
		String sql ="update product set product_kind = ?, product_name =?, product_color = ?, product_price=?, product_count=?,"
				+ "product_com=?, product_country=?, product_date=?, product_image1=?, discount_rate=? where product_id=?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setString(3, product.getProduct_color());
			pstmt.setInt(4, product.getProduct_price());
			pstmt.setInt(5, product.getProduct_count());
			pstmt.setString(6, product.getProduct_com());
			pstmt.setString(7, product.getProduct_country());
			pstmt.setString(8, product.getProduct_date());
			pstmt.setString(9, product.getProduct_image1());
			pstmt.setInt(10, product.getDiscount_rate());
			pstmt.setInt(11, product.getProduct_id());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("updateProduct 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}	
	}
	//상품 정보 삭제 메소드
	public void deleteProduct(int product_id) {
		String sql ="delete from product where product_id =?";
				
				
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
					
			pstmt.executeUpdate();
					
		}catch(Exception e) {
			System.out.println("updateProduct 메소드 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}	
				
	}
	//################################################//
	// mall 에서 사용하는 메소드
	
	// shop에서 100번대, 200번대 신상품 3개씩을 리스트에 담아서 리턴아흔 메소드
	// 신상품의 기준 : 출판일 
	public List<ProductDTO> getProductList(String[] nProducts){
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product =null;
		String sql = "select * from product where product_kind = ? order by product_date desc limit 3";
		
		try {
			conn = JDBCUtil.getConnection();
			
			for(String s: nProducts) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, s);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_image1(rs.getString("product_image1"));
					productList.add(product);
				}
			}
			
		}catch(Exception e) {
			System.out.println("getProductList(String[]) 메소드"+ e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 상품 종류 별 보기 메소드 - 페이징 처리
	public List<ProductDTO> getProductList(int startRow, int pageSize, String product_kind){
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where product_kind =? order by product_id desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_com(rs.getString("product_com"));
				product.setProduct_country(rs.getString("product_country"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setDiscount_rate(rs.getInt("discount_rate"));	
				productList.add(product);
			}
			
			
		}catch(Exception e) {
			System.out.println("getProduct(product_kind) : "+ e.getMessage());
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		
		
		
		return productList;
	}
	
	// 전체 상품 수 조회 메소드 - 검색하지 않은 상품 수
		public int getProductCount(String product_kind) {
			String sql ="select count(*) from product where product_kind=?";
			int cnt =0;
			
			try {
				conn=JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_kind);
				rs = pstmt.executeQuery();
				rs.next();
				cnt = rs.getInt(1); // rs의 첫번째값을 가져온다. 즉 : cnt에 product 갯수를 넣는다. 
				
			}catch(Exception e) {
				System.out.print("getProductCount 메소드 : " + e.getMessage());
				e.printStackTrace();
			}finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return cnt;
			
		}

	
	
}