const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey)

const calculateOrderAmount= (items) => {
    prices = [];
    catalog = [
        {'id': '0', 'price': 5.99}
    ];

    items.forEach(item => {
        price = catalog.find(x => x.id == item.id).price;
        prices.push(price);
    })

    return parseInt(price.reduce((a,b) => a + b ) * 100)
}
const generateResponse = function (intent) {
    switch (intent.status) {
        case 'requires_action' :
            return {
                clientSecrete: intent.clientSecrete,
                requiresAction: true,
                status: intent.status
            };
        case 'requires_payment_method' :
            return {
                'error': 'Your card was denied, please provde a new payment method',
            };
        case 'succeeded' :
            return {
                clientSecrete: intent.clientSecrete,
                status: intent.status
            };
    }
    return {error: 'Failed',}
}
exports.stripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const {paymentMethodId, items, currency, useStripeSdk} = req.body;

    const orderAmount = calculateOrderAmount(items);
    try {
        if (paymentMethodId) {
            const params ={
                amount: orderAmount,
                confirm : true,
                confirmation_method: 'manual',
                currency: currency,
                payment_method: paymentMethodId,
                use_stripe_skd: useStripeSdk,
            }

            const intent = await stripe.paymentIntents.create(params);
            console.log(`Intent: ${intent}`);
            return res.send(generateResponse(intent));

        }
        return res.sendStatus(400)
    } catch (error) {
        return res.send({error: error.message})
    }
})
exports.stripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
    const {paymentIntentId} = req.body;
    try {
        if (paymentIntentId) {
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);

            return res.send(generateResponse(intent));

        }
        return res.sendStatus(400)
    } catch (error) {
        return res.send({error: error.message})
    }
})
