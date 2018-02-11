<%@include file="jspf/header.jsp"%>
<style>
.uk-countdown-number {
	font-size: 18px;
}

.uk-countdown-label {
	font-size: 10px;
}

.uk-card-media-left img {
	max-height: 100%;
	max-width: 100%;
}

#grid {
	padding-top: 3%;
}
</style>

<body class="uk-background-muted">

	<%@include file="jspf/navbar.jspf"%>

	<div style="background-color: #f2f2f2;">

		<div class="uk-section">
			<div class="uk-container">

				<form class="uk-form-stacked" method="POST"
					action="subPost">
					<div class="uk-margin">
						<div class="row">
							<div class="col-xs-6 col-xs-offset-2">
								<div class="uk-form-controls">
									<select class="uk-select" id="form-stacked-select"
										name="category">
										<option value="" disabled selected>Select Category</option>
										<option value="apparel">Apparel</option>
										<option value="books">Books</option>
										<option value="furnature">Furnature</option>
										<option value="supplies">School Supplies</option>
										<option value="technology">Technology</option>
									</select>
								</div>
							</div>
							<button class="uk-button uk-button-success">Submit</button>
						</div>

					</div>
				</form>

				<c:if test="${listings != null}">
					<div class="container">


						<hgroup class="mb20">
							<h1>Results</h1>
							<h2 class="lead">
								<strong class="text-danger">${listings.size()}</strong> results
								were found for the search for <strong class="text-danger">${category}</strong>
							</h2>
						</hgroup>

						<!-- NEW TEST -->
						<div class="uk-position-relative uk-visible-toggle uk-light"
							uk-slider>

							<ul
								class="uk-slider-items uk-child-width-1-2 uk-child-width-1-3@m uk-grid">
								<li>
									<div class="uk-panel">
										<a href="listing"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Wolverine.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>
								<li>
									<div class="uk-panel">
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Cat.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>
								<li>
									<div class="uk-panel">
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Wolverine.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>
								<li>
									<div class="uk-panel">
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Wolverine.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>
								<li>
									<div class="uk-panel">
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Wolverine.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>
								<li>
									<div class="uk-panel">
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Wolverine.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>
								<li>
									<div class="uk-panel">
										<a href="#"><img
											src="${pageContext.request.contextPath}/resources/img/listings/Wolverine.jpg"
											alt=""></a>
										<div class="uk-position-center uk-panel">
											<!-- Maybe use this area for something later -->
										</div>
									</div>
								</li>

							</ul>

							<a
								class="uk-position-center-left-out uk-position-small uk-hidden-hover"
								href="#" uk-slidenav-previous uk-slider-item="previous"></a> <a
								class="uk-position-center-right-out uk-position-small uk-hidden-hover"
								href="#" uk-slidenav-next uk-slider-item="next"></a>

						</div>

					</div>
				</c:if>

				<!-- END NEW TEST -->
			</div>
		</div>
	</div>

</body>
<%@include file="jspf/footer.jspf"%>
</html>