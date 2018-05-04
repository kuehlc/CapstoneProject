<div id="offer${offer.offerID}" class="uk-flex-top" uk-modal>
    <div class="uk-modal-dialog uk-margin-auto-vertical">
        <button class="uk-modal-close-default" type="button" uk-close></button>

        <div class="uk-container uk-container-large uk-flex-middle uk-align-center">

            <div class="uk-modal-header uk-text-center">
                <h2 class="uk-modal-title"><strong>Offer details</strong></h2>
            </div>

            <div class="uk-modal-body">

                <div class="uk-grid uk-text-center" uk-grid>

                    <div class="uk-width-1-2">
                        <strong>Offer maker:</strong>
                        <p id="offerMaker"></p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong> Status:</strong>
                        <p id="status"></p>
                    </div>

                    <!-- Split -->

                    <div class="uk-width-1-2">
                        <strong>Listing:</strong>
                        <p id="listing-offer"></p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong>Date offer was made:</strong>
                        <p id="date"></p>
                    </div>

                    <!-- Split -->

                    <div class="uk-width-1-2">
                        <strong>Amount offered:</strong>
                        <p id="amount"></p>
                    </div>
                    <div class="uk-width-1-2">
                        <strong> Offer Message:</strong>
                        <p id="message"></p>
                    </div>

                </div>

            </div>

            <div class="uk-modal-footer">

                <div class="uk-float-left uk-padding-remove">
                    <button id="rejectButton" class="uk-button uk-border-rounded"
                            style="background-color: #f3565d"
                            value="${offer.listingID.id}"><strong>Reject offer</strong>
                    </button>
                </div>
                <div class="uk-float-right uk-padding-remove">
                    <button id="acceptButton" class="uk-button uk-border-rounded"
                            style="background-color: #5cb85c" name="listing"
                            value="${offer.listingID.id}"><strong>Accept offer</strong>
                    </button>
                </div>

            </div>

        </div>
    </div>
</div>

<script>

    document.getElementById("offer${offer.offerID}").addEventListener("load", offerClick(${offer.offerID}));

    // Fills the modal with data
    function offerClick(offerdata) {

        $.ajax({
            url: '/offerDetails',
            type: 'GET',
            data: {offerId: offerdata},
            dataType: 'json',
            contentType: 'application/json',
            success: function (result) {

                var offer = result;

                var offerMaker = window.document.getElementById('offerMaker')
                var amount = window.document.getElementById('amount');
                var message = window.document.getElementById('message');
                var dateCreated = window.document.getElementById('date');
                var status = window.document.getElementById('status');
                var listing = window.document.getElementById('listing');

                console.log(document.getElementById('amount').innerText);

                offerMaker.textContent = offer.offerMaker;
                amount.innerHTML = offer['offerAmount'];
                message.textContent = offer.offerMessage;
                dateCreated.textContent = offer.offerDateCreated;
                status.textContent = offer.offerStatus;
                listing.textContent = offer.offerListing;

                console.log(offer)

                console.log(document.getElementById('amount').innerText);

            }

        });
    }

    // Calls button method within modal
    $("#acceptButton").click(function (e) {
        console.log($(this).val());
        $.ajax({
            url: 'acceptOfferAjax',
            type: 'POST',
            data: {listing: $(this).val(), offer: ${offer.offerID}},
            success: function (result) {
                console.log(result);
                if (result) {
                    UIkit.modal("#offer${offer.offerID}").hide();
                    UIkit.notification({message: 'Congratulations!', status: 'success'})
                }
                else {
                    UIkit.notification({
                        message: 'An error occurred while accepting this offer. Please contact an admin.',
                        status: 'danger'
                    })
                }
            }

        });
    });

    // Calls button method within modal
    $("#rejectButton").click(function (e) {
        console.log($(this).val());
        $.ajax({
            url: 'rejectOfferAjax',
            type: 'POST',
            data: {listing: $(this).val(), offer: ${offer.offerID}},
            success: function (result) {
                console.log(result);
                if (result) {
                    UIkit.modal("#offer${offer.offerID}").hide();
                    UIkit.notification({message: 'Offer has been rejected.', status: 'success'})
                }
                else {
                    UIkit.notification({
                        message: 'An error occurred while sending your offer. Please contact an admin.',
                        status: 'danger'
                    })
                }
            }

        });
    });
</script>

