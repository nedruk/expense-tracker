import json

import azure.functions as func


def main(req: func.HttpRequest, transactions):
    body_dict = json.loads(transactions)
    body_json = json.dumps(body_dict)
    return func.HttpResponse(status_code=200, body=body_json)