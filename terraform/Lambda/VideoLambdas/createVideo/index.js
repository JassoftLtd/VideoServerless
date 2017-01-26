'use strict';
console.log('create video for User');

var AWS = require('aws-sdk');
// Get reference to AWS clients
var dynamodb = new AWS.DynamoDB.DocumentClient();

var uuid = require('node-uuid');

exports.handler = function(event, context) {
	var responseCode = 200;

    console.log("event: " + JSON.stringify(event))
    console.log("identity: " + JSON.stringify(event.requestContext.identity.cognitoIdentityId))

    var payload = JSON.parse(event.body);


    const signedUrlExpireSeconds = 3600 // 1 hour

	var generatedId = uuid.v1();
	var currentUser = event.requestContext.identity.cognitoIdentityId.split(':')[1];
    var email = event.requestContext.identity.cognitoAuthenticationProvider.split(':').pop();
    var fileExtension = payload.fileName.split('.').pop();
    const _key = currentUser + '/' + generatedId + '.' + fileExtension;

    getUserPlan(event, email, function (plan) {

        var bucketPrefix = 'dash-cam-videos-';

        var s3 = new AWS.S3({
            apiVersion: '2006-03-01'
        });

        const url = s3.getSignedUrl('putObject', {
            Bucket: bucketPrefix + plan.toLowerCase(),
            Key: _key,
            Expires: signedUrlExpireSeconds,
            ContentType: 'text/plain;charset=UTF-8'
        });

        var responseBody = {
            url: url
        };
        var response = {
            statusCode: responseCode,
            headers: {
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify(responseBody)
        };
        console.log("response: " + JSON.stringify(response))
        context.succeed(response);
    })

};

function getUserPlan(event, email, fn) {
    dynamodb.get({
        TableName: "Subscriptions",
        Key: {
            User: email,
            PlanStatus: "Active"
        }
    }, function(err, data) {
        if (err) return fn(err);
        else {
            if ('Item' in data) {
                var plan = data.Item.Plan;
                console.log("User plan is " + plan)
                fn(plan);
            } else {
                fn(null); // User not found
            }
        }
    });
}