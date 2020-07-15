<%@page import="v1.board.c9.dto.BoardDto"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="v1.board.c9.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<title>Welcome To Board v1</title>
<style>
	body {
		background-color: black;
		color: white;
	}
	.container .body {
		max-width: 800px;
		margin: auto;
		margin-top: 50px;
	}
	.form-group select.form-control {
		width: 120px;
		text-align: right;
		height: 35px;
		padding-left:23px;
		padding-top: 3px;
	}
	
	#main-table table {
		color: lightgray;
		text-align: center;
	}
	table a {
		text-decoration: none;
		color: lightgray;
	}
	table a:hover {
		color: white;
		font-weight: bolder;
	}
</style>
</head>
<body>
<%
	if (session.getAttribute("loginUserNo") == null) {
		
		response.sendRedirect("../common/home.jsp?error=session");
		return;
	}
	
	String paramPageNo = request.getParameter("pageno");
	String paramKeyword = request.getParameter("keyword");
	String paramWriterType = request.getParameter("writertype");
	String paramRowCount = request.getParameter("rowcount");
	
	int userNo = (int) session.getAttribute("loginUserNo");
	String userNickname = (String) session.getAttribute("loginUserNickname");
	int pageNo = paramPageNo == null ? 1 : Integer.parseInt(paramPageNo);
	String keyword = paramKeyword == null ? "" : paramKeyword;
	String writerType = paramWriterType == null ? "" : paramWriterType;
	int rowsPerPage = paramRowCount == null ? 10 : Integer.parseInt(paramRowCount);
	
	Map<String, Object> conditionMap = new HashMap<String, Object>();
	conditionMap.put("keyword", keyword);
	conditionMap.put("writerType", writerType);
	conditionMap.put("pageNo", pageNo);
	conditionMap.put("rowsPerPage", rowsPerPage);
	conditionMap.put("userNo", userNo);
	
	BoardDao boardDao = new BoardDao();
	List<BoardDto> boardList = boardDao.getBoardListWithCondition(userNo, conditionMap);
%>
<div class="container">
	<div class="header mb-3">
		<!-- 마우스를 맨 위에 대고 있으면 header 보이기 -->
		<%@ include file="../common/header.jsp" %>
	</div>
	
	<div class="row justify-content-center">
		<div class="col-9">
			<div style="border: 1px solid lightgray;" onmouseover="showHeader()"></div>
		</div>
	</div>
	
	<div class="body">
		<div class="row">
			<div class="col-12 text-center mb-5">
				<h1>Board v1 List</h1>
				<small class="text-muted">Welcome, <%=userNickname %></small>
			</div>
		</div>
	
		<form id="form-list-condition" method="GET" action="list.jsp">
			<div id="upper-form" class="row">
				<div class="col-12 d-flex justify-content-end">
					<div class="form-group">
						<select id="select-row-count" class="form-control" name="rowcount">
							<option value="10">10 rows</option>
							<option value="20">20 rows</option>
							<option value="50">50 rows</option>
						</select>
					</div>
					<div class="ml-1 form-group">
						<select id="select-writer" class="form-control" name="writertype">
							<option value="all">get All</option>
							<option value="my">get My</option>
						</select>
					</div>
				</div>
			</div>
			
			
			<div id="main-table" class="row">
				<div class="col-12">
					<table class="table">
						<colgroup>
							<col width=10%>
							<col width=*>
							<col width=30%>
							<col width=15%>
						</colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>Title</th>
								<th>Writer</th>
								<th>RegDate</th>
							</tr>
						</thead>
						<tbody>
						<%
							if (boardList.isEmpty()) {
						%>
							<tr>
								<td colspan="5" style="color: crimson">There's No Articles Written Yet.</td>
							</tr>
						<%
							} else {
								for (BoardDto board : boardList) {
									String myTitle = "";
									if (board.getUserNo() == userNo) {
										myTitle="font-style: italic;";
									} 
						%>
							<tr style="<%=myTitle %>">
								<td><%=board.getNo() %></td>
								<td>
									<a href="detail.jsp?boardno=<%=board.getNo() %>" >
										<%=board.getTitle() %>
									</a>
								</td>
								<td><%=board.getUserNickname() %></td>
								<td><%=board.getCreatedDate() %></td>
							</tr>
							
						<%
								}
							}
						%>
						<tr>
							<td><a class="badge badge-secondary">Write</a></td>
							<td colspan="3"></td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<div id="lower-form" class="row mt-3">
				<div class="col-8 pl-5  text-muted">
					<small>&laquo; 1234 &raquo;</small>
				</div>
			
				<div class="col-4 d-flex justify-content-end">
					<div class="form-group">
						<input type="text" name="keyword" />
						<button class="badge badge-dark">Find</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div class="row justify-content-center mt-5">
		<div class="col-9">
			<div style="border: 1px solid lightgray;" onmouseover="showFooter()"></div>
		</div>
	</div>
	<div class="footer" onclick="hideFooter()">
		<!-- 마우스를 맨 아래에 대고 있으면 footer 보이기 -->
		<%@ include file="../common/footer.jsp" %>
	</div>
</div>
<script type="text/javascript">
	function showFooter() {
		document.querySelector(".footer div").style.display="";
	}
	
	function hideFooter() {
		document.querySelector(".footer div").style.display="none";
	}

	function showHeader() {
		document.querySelector(".header div").style.display="";
	}
	
	function hideHeader() {
		document.querySelector(".header div").style.display="none";
	}
</script>
</body>
</html>