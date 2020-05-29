import * as functions from 'firebase-functions';
const yandexCheckout = require('yandex-checkout')({ shopId: '713094', secretKey: 'test_Ll6KPvTcUybMLLKpYR-tZtW4aOZyBTzV0DkwBboyh4M', debug: true });
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

export const buySection = functions.https.onCall(async ({ langId, sectionId }, context) => {

    if (!context.auth) {
        return { message: 'Authentication Required!', code: 401 };
    }

    const uid = context.auth.uid;

    const langPath = 'langs/' + langId;
    const lang = (await db.doc(langPath).get()).data();
    const section = (await db.doc(langPath + '/sections/' + sectionId).get()).data();

    return yandexCheckout.createPayment({
        'amount': {
            'value': String(section["price"]) + '.00',
            'currency': 'RUB'
        },
        'capture': true,
        'confirmation': {
            'type': 'redirect',
            'return_url': 'http://proyaziki.ru'
        },
        'description': 'Заказ ' + lang["title"]["ru"] + " >> " + section["title"],
        'metadata': {
            'langId': langId,
            'sectionId': sectionId,
            'userId': uid,
        }
    }, `${uid}_${sectionId}`)
        .then(function (payment: any) {
            const resp = { payment: payment };
            console.log("payment: ", payment);
            return resp;
        })
        .catch(function (err: any) {
            const resp = { err: err };
            console.log("err: ", err);
            return resp;
        });
});

export const paymentNotify = functions.https.onRequest(async (req, res) => {
    const metadata = req.body.object.metadata;
    console.log('body metadata: ', metadata);

    await db.doc(`users/${metadata.userId}`).set({
        'purchases': {
            [metadata.langId]: [
                metadata.sectionId
            ]
        }
    }, { merge: true });

    res.status(200).send();
});