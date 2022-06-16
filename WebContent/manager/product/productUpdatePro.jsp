<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");
// 폼의 입력 정보 획득
// 파일 업로드 폼 -> cos.jar 라이브러리 MultipartReuest 클래스를 사용
// request, 업로드 폴더, 파일의 최대 크기, encType, 파일명 중복 정책
ProductDTO product = new ProductDTO();
String realFolder = "c:/images_camera";   // 질문 여기에서 꺼내 사용?? 아니면 여기로 저장시키는가??
int maxSize = 1024 * 1024 * 5;
String encType = "utf-8";
String fileName = "";
MultipartRequest multi = null;
int i=1;
try{
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	Enumeration<?> files = multi.getFileNames();
	while(files.hasMoreElements()){
		String name = (String)files.nextElement();
		fileName = multi.getFilesystemName(name);
	}
}catch(Exception e){
	System.out.println("productUpdatePro.jsp 파일 : " + e.getMessage());
	e.printStackTrace();
}
// pageNum을 획득
String pageNum = multi.getParameter("pageNum");
// 폼에서 넘어오는 11개의 필드 값을 획득 - reg_date(수정 불가)
int product_id = Integer.parseInt(multi.getParameter("product_id"));
String product_kind = multi.getParameter("product_kind");
String product_name = multi.getParameter("product_name");
String product_color = multi.getParameter("product_color");
int product_price = Integer.parseInt(multi.getParameter("product_price"));
int product_count = Integer.parseInt(multi.getParameter("product_count"));
String product_com = multi.getParameter("product_com");
String product_country = multi.getParameter("product_country");
String product_date = multi.getParameter("product_date");
//String product_image = multi.getParameter("product_image"); // 여기서는 이름을 얻을 수 없다.
int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));

// ProductDTO 객체 생성하고 setter 메소드를 사용하여 값을 설정한다.

product.setProduct_id(product_id);
product.setProduct_kind(product_kind);
product.setProduct_name(product_name);
product.setProduct_color(product_color);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setProduct_com(product_com);
product.setProduct_country(product_country);
product.setProduct_date(product_date);

product.setProduct_image1(fileName);     // 업로드한  파일의 실제 이름
product.setDiscount_rate(discount_rate);
//System.out.println("product 객체 : " + product);
// DB 연결, 상품 
ProductDAO productDAO = ProductDAO.getInstance(); // DAO 객체 생성해주고
productDAO.updateProduct(product);                // DAO에 있는 메소드 사용하기
response.sendRedirect("productList.jsp?pageNum=" + pageNum);

%>
</body>
</html>