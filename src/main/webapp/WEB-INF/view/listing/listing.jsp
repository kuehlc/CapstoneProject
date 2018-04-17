<%@include file="../jspf/header.jsp" %>

<body class="uk-background-muted listing-tutorial">
<div style="border: 20px solid white;
            margin: 0 auto;
            background: white;">

    <%@include file="../jspf/navbar.jspf" %>

    <%@include file="../jspf/messages.jsp" %>

    <div class="uk-container">

        <div class="uk-section uk-padding-small" uk-grid>

            <!-- LEFT SIDE -->
            <div class="uk-width-2-5@m uk-width-1-1@s">
                <div class="uk-margin-small-left uk-margin-small-right" uk-slideshow="animation: fade">

                    <ul class="uk-slideshow-items" style="min-height: 350px">

                        <c:forEach items="${listing.images}" var="image">
                            <li>
                                <img class="uk-align-center"
                                     src="${pageContext.request.contextPath}/directory/${image.image_path}/${image.image_name}"
                                     style="height: auto; width: auto; max-height: 100%; max-width: 100%;">
                            </li>
                        </c:forEach>

                    </ul>

                    <div class="uk-padding-small">
                        <ul class="uk-thumbnav uk-child-width-1-3">

                            <c:forEach items="${listing.images}" var="image" varStatus="loop">
                                <li uk-slideshow-item="${loop.index}"><a href="#">
                                    <img class="uk-thumbnail"
                                         src="${pageContext.request.contextPath}/directory/${image.image_path}/${image.image_name}"
                                         width="100" alt="Listing"></a>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>

                </div>
            </div>

            <!-- RIGHT SIDE -->
            <c:if test="${listing.type.equals('fixed')}">
                <div class="uk-width-3-5@m uk-width-1-1@s">

                    <div class="uk-card uk-card-body">

                        <h1 class="uk-article-title uk-margin-remove-top">
                                ${listing.name}
                        </h1>

                        <p class="uk-text-lead">${listing.description}</p>

                        <p class="uk-article-meta">Listed by <b><a
                                href="/viewProfile?id=${listing.user.userID}"
                                data-intro="Click see more about the seller." data-step="5">${listing.user.username}</a></b>
                        </p>

                        <div class="uk-grid-small uk-child-width-auto uk-tile-default uk-border-rounded uk-padding uk-padding-remove-left"
                             uk-grid>

                            <ul class="uk-grid-small uk-width-2-3 uk-float-left" uk-grid>
                                <li class="uk-width-1-1">

                                <span class="uk-float-left"><strong>Asking Price</strong>
                                    <span class="uk-badge">$${listing.price}</span>
                                </span>
                                </li>
                            </ul>

                            <c:if test="${listing.ended == 0}">
                                <a
                                        <c:if test="${hasOffer}">onclick="return confirm('You have already made an offer for this listing. Making a new one will replace the current one. Is this okay?');"</c:if>
                                        class="uk-button uk-button-text uk-float-right"
                                        style="color: green;"
                                        href="${pageContext.request.contextPath}/makeOffer?listing=${listing.id}">Make
                                    offer</a>
                            </c:if>

                        </div>

                        <!-- Countdown and Progress Bar -->
                        <div class="uk-grid-small" uk-grid>
                            <div class=" uk-width-1-1 uk-align-center">
                                <p class="uk-margin-small-bottom uk-margin-small-top uk-align-center listing-ended"
                                   style="color: red; font-size: 16px; display: none;">
                                    Listing Ended</p>
                                <div class="uk-grid-small uk-countdown uk-margin-remove uk-align-center" uk-grid
                                     uk-countdown="date: ${listing.endTimestamp}">
                                                <span class="uk-days">
                                                    <strong class="uk-countdown-number uk-countdown-days"></strong>
                                                    <strong class="uk-countdown-label uk-margin-small-top uk-margin-left">Days</strong>
                                                </span>
                                    <span class="uk-hours">
                                                        <strong class="uk-countdown-number uk-countdown-hours"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left">Hours</strong>
                                                </span>
                                    <span class="uk-minutes">
                                                        <strong class="uk-countdown-number uk-countdown-minutes"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left">Minutes</strong>
                                                </span>
                                    <span class="uk-seconds">
                                                        <strong class="uk-countdown-number uk-countdown-seconds"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left">Seconds</strong>
                                                </span>
                                    <span>
                                <strong>Remaining</strong>
                            </span>
                                </div>
                                <progress class="uk-progress uk-margin-remove-top" value="${listing.percentLeft}"
                                          max="100">
                                </progress>

                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${listing.type.equals('auction')}">
            <div class="uk-width-3-5@m uk-width-1-1@s">

                <div class="uk-padding-small uk-margin-small-left uk-margin-small-right">
                    <article class="uk-article uk-margin-large">

                        <h1 class="uk-article-title uk-margin-remove-top">
                            <p>${listing.name}</p>
                        </h1>

                        <p class="uk-text-lead">${listing.description}</p>

                        <span class="uk-width-1-1">
                        <p class="uk-article-meta">Listed by <b><a
                                href="/viewProfile?id=${listing.user.userID}"
                                data-intro="Click here to see more about the seller."
                                data-step="5">${listing.user.username}</a></b>
                        <c:if test="${listing.ended == 1 && listing.highestBidder.userID ==
                                sessionScope.user.userID || listing.user.userID == sessionScope.user.userID && viewTransaction != 'true'}">
                            <a class="uk-float-right"
                               data-intro="Having second thoughts about buying this listing? Click here to cancel your purchase."
                               data-step="4"
                               uk-toggle="target: #cancelPurchaseModal">Having Second
                                Thoughts?</a>
                        </c:if>
                        </p>
                    </span>

                        <!-- Bid Section -->
                        <div class="uk-grid-small uk-child-width-auto uk-tile-default uk-border-rounded uk-padding
                    uk-padding-remove-left uk-box-shadow-hover-large uk-box-shadow-medium"
                             uk-grid>

                            <!-- Highest Bid Section -->
                            <ul class="uk-grid-small uk-width-2-3 uk-float-left" uk-grid>
                                <li class="uk-width-1-1">
                                    <c:choose>
                                        <c:when test="${listing.ended == 0}">
                                                <span class="uk-float-left"><strong>Highest Bid:</strong>
                                                    <span class="uk-badge"> $${listing.highestBid}</span>
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="uk-float-left"><strong>Winning Bid:</strong>
                                                    <span class="uk-badge"> $${listing.highestBid}</span>
                                                </span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="uk-width-1-1">
                                    <span class="uk-float-left">
                                        <b>Highest Bidder:</b>
                                        <strong>${listing.highestBidder.username}</strong>
                                        <c:if test="${listing.highestBidder.userID == user.userID}">
                                                <a title="Cancel Bid" uk-icon="icon: ban"
                                                   uk-toggle="target: #cancelBid${listing.id}Modal"
                                                   data-intro="Place a bid but change your mind? Click here to cancel your bid."
                                                   data-step="3"
                                                   style="color: red;"></a>
                                        </c:if>
                                    </span>
                                </li>
                                <li class="uk-width-1-1">
                                    <span class="uk-float-left">
                                        <b>Bid Count:</b>
                                        <strong>${listing.bidCount}</strong>
                                    </span>
                                </li>
                            </ul>

                            <!-- Place Bid Button -->
                            <div class="uk-width-1-3 uk-float-right uk-text-right">
                                <c:choose>
                                    <c:when test="${listing.ended == 0}">
                                        <c:if test="${listing.user.userID != user.userID}">

                                            <a id="placeBidButton" class="uk-button uk-button-text"
                                               style="color: cornflowerblue;"
                                               onclick="toggleBid();" data-intro="Click here to place a bid!"
                                               data-step="1">Place
                                                Bid</a>

                                        </c:if>

                                        <div class="uk-margin-small-top">
                                            <form method="post" action="/bid"
                                                  class="uk-grid-small"
                                                  uk-grid id="bidForm" style="display: none;">
                                                <input class="uk-input uk-width-4-5 uk-float-left uk-border-rounded"
                                                       name="bidValue"
                                                       type="number"
                                                       min="${listing.highestBid}">
                                                <a class="uk-width-1-5 uk-float-right uk-padding-remove"
                                                   uk-icon="icon: check; ratio: 1.50" title="Place Bid"
                                                   onclick="document.getElementById('bidForm').submit();"></a>
                                                <input name="listingID" type="hidden" value="${listing.id}">
                                            </form>
                                        </div>

                                    </c:when>

                                    <c:otherwise>
                                        <c:if test="${sessionScope.user.userID == listing.highestBidder.userID || sessionScope.user.userID == listing.user.userID}">
                                            <c:choose>
                                                <c:when test="${viewCheckout == true}">
                                                    <a href="/checkout?l=${listing.id}" class="uk-button uk-button-text"
                                                       data-intro="Click here to checkout" data-step="1"
                                                       style="color: cornflowerblue; margin-left: 5px;">Checkout</a>
                                                </c:when>
                                                <c:when test="${viewPickUp == true}">
                                                    <a href="/pick-up-review?l=${listing.id}"
                                                       class="uk-button uk-button-text"
                                                       data-intro="Click here view your pick up" data-step="1"
                                                       style="color: cornflowerblue; margin-left: 5px;">View Pick Up</a>
                                                </c:when>
                                                <c:when test="${viewPickUpDetails == true}">
                                                    <a href="/pick-up-review?l=${listing.id}"
                                                       class="uk-button uk-button-text"
                                                       data-intro="Click here view your pick up" data-step="1"
                                                       style="color: cornflowerblue; margin-left: 5px;">View Pick Up
                                                        Details</a>
                                                </c:when>
                                                <c:when test="${viewVerification == true}">
                                                    <a uk-toggle="target: #verifyPickUpModal"
                                                       class="uk-button uk-button-text"
                                                       data-intro="Click here view your pick up" data-step="1"
                                                       style="color: cornflowerblue; margin-left: 5px;">Verify Pick
                                                        Up</a>
                                                </c:when>
                                                <c:when test="${viewTransaction == true}">
                                                    <a href="/viewPurchaseHistory"
                                                       class="uk-button uk-button-text"
                                                       data-intro="Click here view your transaction" data-step="1"
                                                       style="color: cornflowerblue; margin-left: 5px;">View
                                                        Transaction</a>
                                                </c:when>
                                            </c:choose>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Countdown and Progress Bar -->
                        <div class="uk-grid-small" uk-grid data-intro="Place your bid before the time runs out!"
                             data-step="2">
                            <div class="uk-width-1-1 uk-align-center">
                                <strong class="uk-margin-small-bottom uk-margin-small-top uk-align-center listing-ended"
                                        style="color: red; font-size: 16px; display: none;">
                                    Listing Ended</strong>
                                <div class="uk-grid-small uk-countdown uk-margin-remove uk-align-center" uk-grid
                                     uk-countdown="date: ${listing.endTimestamp}">
                                                <span class="uk-days">
                                                    <strong class="uk-countdown-number uk-countdown-days"
                                                            style="font-size: 22px;"></strong>
                                                    <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                            style="font-size: 22px;">Days</strong>
                                                </span>
                                    <span class="uk-hours">
                                                        <strong class="uk-countdown-number uk-countdown-hours"
                                                                style="font-size: 22px;"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                                style="font-size: 22px;">Hours</strong>

                                                </span>
                                    <span class="uk-minutes">
                                                        <strong class="uk-countdown-number uk-countdown-minutes"
                                                                style="font-size: 22px;"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                                style="font-size: 22px;">Minutes</strong>
                                                </span>
                                    <span class="uk-seconds">
                                                        <strong class="uk-countdown-number uk-countdown-seconds"
                                                                style="font-size: 22px;"></strong>
                                                        <strong class="uk-countdown-label uk-margin-small-top uk-margin-left"
                                                                style="font-size: 22px;">Seconds</strong>
                                                </span>
                                    <span>
                                <strong style="font-size: 22px;">Remaining</strong>
                                </span>
                                </div>
                                <progress id="js-progressbar"
                                          class="uk-progress uk-margin-remove-top" value="${listing.percentLeft}"
                                          max="100">
                                </progress>
                            </div>
                        </div>
                    </article>
                </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
<%@include file="bid-buy-modals.jsp" %>
<%@include file="cancel-purchase-modal.jsp" %>
<%@include file="../pickup/pick-up-verification-modal.jsp" %>
<script>
    function toggleBid() {
        if (document.getElementById("bidForm").style.display == 'inline') {
            document.getElementById("bidForm").style.display = "none";
        } else {
            document.getElementById("bidForm").style.display = "inline";
        }
    }

    window.addEventListener("load", function () {
        if (document.getElementById("yes").style.display == "inline") {
            setTimeout(function () {
                introJs(".listing-tutorial").start();
            }, 2000);
        }
    });

</script>

<c:if test="${showTutorial == true}">
    <p id="yes" style="display: inline;"></p>
</c:if>
</html>