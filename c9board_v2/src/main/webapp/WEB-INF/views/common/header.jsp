<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uri = request.getRequestURI();
	String[] splitUri = uri.split("/");
	String directory = splitUri[2];
	
	String colorBasic = "style='color: lightgray;'";
	String colorActive = "style='color: white; font-weight: bold;'";
%>
<div id="header-nav" class="row justify-content-center" onclick="hideHeader()">
	<div class="col-5 text-center mt-3">
		<nav class="navbar navbar-expand-sm justify-content-center">
			<ul class="navbar-nav" style="justify-content: space-between; width: 70%;">
				<li class="nav-item">
					<a class="nav-link" <%=directory.equals("common") ? colorActive : colorBasic %> href="/c9/home.do">Home</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" <%=directory.equals("board") ? colorActive : colorBasic %> href="/c9/board/list.do">Board</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" <%=directory.equals("account") ? colorActive : colorBasic %> href="/c9/account/myinfo.do">My</a>
				</li>
			</ul>
		</nav>
	</div>
</div>

<div class="row justify-content-center mt-3">
	<div class="col-9">
		<div style="border: 1px solid lightgray;" onmouseover="showHeader()"></div>
	</div>
</div>