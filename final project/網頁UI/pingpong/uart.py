import serial
import threading
class UART:
    def __init__(self):
        self.PORT = None
        self.BAUDRATE = 0
        self.serial = None

    def connectUART(self, port = "None", baudRate = 9600):
        self.PORT = port
        self.BAUDRATE = baudRate
        self.serial = serial.Serial(self.PORT, self.BAUDRATE, timeout=0)

    def readUARTdata(self):
        raw_data = self.serial.readline()
        data = raw_data.decode()
        print(data)
        return data

    def closeUART(self):
        self.serial.close()

    


