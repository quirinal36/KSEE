<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<footer>
	<div id="footer_wrap">
		<div class="menu">
			<div>
				<a href="<c:url value="/about/greet"/>">
					<spring:message code="comm.greetings" text="comm.greetings"></spring:message>
				</a>
				<a href="<c:url value="/about/term"/>">
					<spring:message code="comm.articles_of_ksee" text="comm.articles_of_ksee"></spring:message>
				</a>
				<a href="<c:url value="/term/privacy"/>">
					<spring:message code="comm.personal_information" text="comm.personal_information"></spring:message>
				</a>
				<a href="<c:url value="/term/email"/>">
					<spring:message code="comm.refuse_email" text="comm.refuse_email"></spring:message>
				</a>
			</div>
		</div>
		<div class="text">
			<div>
				<ul>
					<li><spring:message code="comm.co_ksee" text="comm.co_ksee"></spring:message></li>
					<li><spring:message code="comm.president" text="comm.president"></spring:message></li>
					<li><spring:message code="comm.co_num" text="comm.co_num"></spring:message></li>
				</ul>
				<ul>
					<li><spring:message code="comm.co_address" text="comm.co_address"></spring:message></li>
					<li><spring:message code="comm.co_tel" text="comm.co_tel"></spring:message></li>
				</ul>
				<p>COPYRIGHT <span>KSEE</span>. ALL RIGHTS RESERVED.</p>
			</div>
		</div>
	</div>
</footer>