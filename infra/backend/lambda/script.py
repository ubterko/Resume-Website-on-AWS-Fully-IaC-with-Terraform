import json
import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visits-count-ie25')
def lambda_handler(event, context):
    response = table.get_item(Key={
        'id':'1'
    })
    views = response['Item']['views']
    views = views + 1
    response = table.put_item(Item={
            'id':'1',
            'views': views
    })

    return views