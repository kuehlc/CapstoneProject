<div class="col-xs-12 col-sm-6 col-md-3 rwrapper">
    <div class="rlisting">
        <div class="col-md-12 nopad">
            <div uk-lightbox>
                <a href="${pageContext.request.contextPath}/resources/img/listings/${listing.image_path}"
                   title="Image" class="thumbnail"><img
                        src="${pageContext.request.contextPath}/resources/img/listings/${listing.image_path}"
                        alt="Listing"/></a>
            </div>
        </div>
        <div class="col-md-12 nopad">
            <a uk-icon="icon: star; ratio: 2"></a>
            <h5>${listing.name}</h5>
            <c:choose>
                <c:when test="${listing.type == 'auction'}">
                    <p>$${listing.highestBid}</p>
                    <div class="uk-grid-small uk-child-width-auto" uk-grid
                         uk-countdown="date: ${listing.endTimestamp}">
                        <div>
                            <div class="uk-countdown-number uk-countdown-days"></div>
                            <div class="uk-countdown-label uk-margin-small uk-text-center uk-visible@s">Days</div>
                        </div>
                        <div class="uk-countdown-separator">:</div>
                        <div>
                            <div class="uk-countdown-number uk-countdown-hours"></div>
                            <div class="uk-countdown-label uk-margin-small uk-text-center uk-visible@s">Hours</div>
                        </div>
                        <div class="uk-countdown-separator">:</div>
                        <div>
                            <div class="uk-countdown-number uk-countdown-minutes"></div>
                            <div class="uk-countdown-label uk-margin-small uk-text-center uk-visible@s">Minutes</div>
                        </div>
                        <div class="uk-countdown-separator">:</div>
                        <div>
                            <div class="uk-countdown-number uk-countdown-seconds"></div>
                            <div class="uk-countdown-label uk-margin-small uk-text-center uk-visible@s">Seconds</div>
                        </div>
                    </div>
                    <div class="rfooter">
                        <button>See More</button>
                        <button type="button"
                                uk-toggle="target: #placeBidModal">Place Bid
                        </button>
                    </div>
                </c:when>
                <c:when test="${listing.type == 'fixed'}">
                    <p>$${listing.price}</p>
                    <div class="rfooter">
                        <button>See More</button>
                        <button type="button"
                                uk-toggle="target: #buyItNowModal">Buy It Now
                        </button>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>

<!-- This is the modal -->
<div id="buyItNowModal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <h2 class="uk-modal-title">Buy It Now</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
            magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
            commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat
            nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
            anim id est laborum.</p>
        <p class="uk-text-right">
            <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel</button>
            <button class="uk-button uk-button-primary" type="button">Buy</button>
        </p>
    </div>
</div>

<div id="placeBidModal" uk-modal>
    <div class="uk-modal-dialog uk-modal-body">
        <form method="post" action="/bid">
            <h2 class="uk-modal-title">Place A Bid</h2>
            <div class="uk-child-width-1-2@s" uk-grid>
                <div>
                    <h4>Name: ${listing.name}</h4>
                    <h4>Highest Bid: ${listing.highestBid}</h4>
                    <h4>Seller: <a href="/viewProfile?id=${listing.user.userID}">${listing.user.username}</a></h4>
                </div>

                <div>
                    <div class="uk-input">
                        <label>Your Bid
                            <input name="bidValue" type="number" min="${listing.highestBid}"></label>
                        <input name="listingID" type="hidden" value="${listing.id}">
                    </div>
                </div>
            </div>
            <p class="uk-text-right">
                <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel</button>
                <button class="uk-button uk-button-primary" type="submit">Bid</button>
            </p>
        </form>
    </div>
</div>
<script>
</script>