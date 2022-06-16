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
String realFolder = "c:/images_camera";  
int maxSize = 1024 * 1024 * 5;
String encType = "utf-8";
String fileName ="";
List<String> fileNameList = new ArrayList<String>();
MultipartRequest multi = null;
try{
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	Enumeration<?> files = multi.getFileNames();
	while(files.hasMoreElements()){
		String name = (String)files.nextElement();
		if(name == null) name = "nothing.jpg";
		fileNameList.add(multi.getFilesystemName(name));
	}
	
}catch(Exception e){
	System.out.println("productRegisterPro.jsp 파일 : " + e.getMessage());
	e.printStackTrace();
}
// 폼에서 넘어오는 10개의 필드 값을 획득 - 제외) product_id, reg_date
String product_kind = multi.getParameter("product_kind");
String product_name = multi.getParameter("product_name");
String product_color = multi.getParameter("product_color");
int product_price = Integer.parseInt(multi.getParameter("product_price"));
int product_count = Integer.parseInt(multi.getParameter("product_count"));
String product_com = multi.getParameter("product_com");
String product_country = multi.getParameter("product_country");
String product_date = multi.getParameter("product_date");
int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));

// ProductDTO 객체 생성하고 setter 메소드를 사용하여 값을 설정한다.
ProductDTO product = new ProductDTO();
product.setProduct_kind(product_kind);
product.setProduct_name(product_name);
product.setProduct_color(product_color);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setProduct_com(product_com);
product.setProduct_country(product_country);
product.setProduct_date(product_date);
product.setProduct_image1(fileNameList.get(0));     // 업로드한  파일의 실제 이름
product.setProduct_image2(fileNameList.get(1));     // 업로드한  파일의 실제 이름
product.setProduct_image3(fileNameList.get(2));     // 업로드한  파일의 실제 이름
product.setProduct_content(fileNameList.get(3));     // 업로드한  파일의 실제 이름
product.setDiscount_rate(discount_rate);
//System.out.println("product 객체 : " + product);
// DB 연결, 상품 
ProductDAO productDAO = ProductDAO.getInstance(); // DAO 객체 생성해주고
productDAO.insertProduct(product);                // DAO에 있는 메소드 사용하기
response.sendRedirect("productList.jsp");         // 
%>
</body>
</html>