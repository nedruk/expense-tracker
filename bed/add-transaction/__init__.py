import json
import uuid
from datetime import datetime

import azure.functions as func


def main(req: func.HttpRequest, resp: func.Out[func.HttpResponse]):
    payload=json.loads(req.get_body().decode())
    date=datetime.strptime(payload['date'], '%Y-%m-%d')
    row_key_uuid = str(uuid.uuid4())
    table_dict = payload
    table_dict['PartitionKey']=date.strftime('%Y-%m')
    table_dict['RowKey']=row_key_uuid
    table_json = json.dumps(table_dict)
    http_resp = func.HttpResponse(status_code=200,headers={'Content-Type': 'application/json'}, body=table_json)
    resp.set(http_resp)
    return table_json