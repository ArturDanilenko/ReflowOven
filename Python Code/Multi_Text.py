import serial
import nexmo
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import sys, time, math
import threading
from threading import Thread


lock = threading.Lock()

ser = serial.Serial(
    port='COM8',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS
)



    
def runPlotter():
    xsize=100
    ysize = 250
    def data_gen():
        t = data_gen.t
        while True:
            t+=1
            lock.acquire()
            result = ser.readline()
            val=float(result)
            lock.release()
            yield t, val
           
        
    def run(data):
        # update the data
        t,y = data
        if t>-1:
            xdata.append(t)
            ydata.append(y)
            if t>xsize:
                # Scroll to the left.
                ax.set_xlim(t-xsize, t)
            line.set_data(xdata, ydata)
            
        return line,

    def on_close_figure(event):
        sys.exit(0)


    data_gen.t = -1
    fig = plt.figure()
    fig.canvas.mpl_connect('close_event', on_close_figure)
    ax = fig.add_subplot(111)
    line, = ax.plot([], [], lw=2)
    ax.set_ylim(-10, ysize)
    ax.set_xlim(0, xsize)
    ax.grid()
    xdata, ydata = [], []
    ani = animation.FuncAnimation(fig, run, data_gen, blit=False, interval=100, repeat=False)
    plt.show()

            

def runText():
    client = nexmo.Client(key='f7cc0105', secret='skbMFLX1yz0rGVZc')
    state = 0
    while True:
        lock.acquire()
        result = ser.readline()
        val=float(result)
        lock.release()
        if val > 40 and state == 0:
            client.send_message({
                'from': '12366000369',
                'to': '17789980302',
                'text': val
                })
            state = 1
        else:
            print('none')
         

if __name__ == "__main__":
    t1 = threading.Thread(target = runPlotter)
    t2 = threading.Thread(target = runText)
    t1.setDaemon(True)
    t2.setDaemon(True)
    t1.start()
    t2.start()
    while True:
        pass
