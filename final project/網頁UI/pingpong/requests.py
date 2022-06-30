from django.http import JsonResponse
import json
from pingpong.uart import UART
import serial.tools.list_ports

serialUART = UART()

def getCOM(request):
    if request.method == "GET":
        port_list = []
        for port in serial.tools.list_ports.comports():
            port_list.append(port.device)
        return JsonResponse({
            "COM": port_list
        })
    else:
        return error("錯誤", 403)

def connect(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            port = data["port"]
            baudrate = data["baudRate"]
            serialUART.connectUART(port, baudrate)
            print(port, baudrate)
            return JsonResponse({
                "result": "OK"
            })
        except:
            return error("連線錯誤", 403)
    else:
        return error("錯誤", 403)

def close(request):
    if request.method == "POST":
        try:
            serialUART.closeUART()
            return JsonResponse({
                "result": "OK"
            })
        except:
            return error("關閉錯誤", 403)
    else:
        return error("錯誤", 403)

def getData(request):
    if request.method == "GET":
       
        result = str(serialUART.readUARTdata())[:-2]
        result = bin(int(result))[2:]
      
        while True:
            if len(result) < 8:
                result = '0' + result
            else:
                break
        return JsonResponse({
            "data": result
        })
         
    else:
        return error("錯誤", 404)

def error(message, code):
    response = JsonResponse({
        "error": message
    })
    response.status_code = code
    return response