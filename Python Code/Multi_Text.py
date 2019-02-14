import serial
import nexmo
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import sys, time, math
import threading
from threading import Thread
#from gtts import gTTS
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart



# Establish a secure session with gmail's outgoing SMTP server using your gmail account
server = smtplib.SMTP( "smtp.gmail.com", 587 )

server.starttls()

server.login( 'brandonbwanakocha@gmail.com', 'ycdrvakkwkbfpgji' )

# End of email Shenanigans--------------------------------------------------------------------------------------------------------

#Initialize time
global InitialTime
InitialTime = int(round(time.time()*1000))

#Initialize the run times dict
runTimes = {
    0: 0,
    1: 1,
    2: 2,
    3: 3,
    4: 4,
    5: 5,
    }


language = 'en'
# TTS strings
welcome = 'This is our ree flow oven'
enterState1 = 'begin stage 0'
tempAbove70 = 'temperature above 70'

#welcomeTTS = gTTS(text=welcome, lang=language, slow=False)
#enterState1TTS = gTTS(text=enterState1, lang=language, slow=False)
#tempAbove70TTS = gTTS(text=tempAbove70, lang=language, slow=False)

# save audio files
#welcomeTTS.save("welcome.mp3")
#enterState1TTS.save("enterState1.mp3")
#tempAbove70TTS.save("tempAbove70.mp3")

lock = threading.Lock()

ser = serial.Serial(
    port='COM10',
    #baudrate=115200,
    baudrate = 57600,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS
)

client = nexmo.Client(key='f7cc0105', secret='skbMFLX1yz0rGVZc')


def SendMail(ImgFileName):
    img_data = open(ImgFileName, 'rb').read()
    msg = MIMEMultipart()
    msg['Subject'] = 'subject'
    msg['From'] = 'brandonbwanakocha@gmail.com'
    msg['To'] = 'brendonbk81@gmail.com'

    text = MIMEText("test")
    msg.attach(text)
    image = MIMEImage(img_data, name=os.path.basename(ImgFileName))
    msg.attach(image)

    s = smtplib.SMTP("smtp.gmail.com", 587)
    s.ehlo()
    s.starttls()
    s.ehlo()
    s.login('brandonbwanakocha@gmail.com', 'ycdrvakkwkbfpgji')
    s.sendmail('brandonbwanakocha@gmail.com', 'brendonbk81@gmail.com', msg.as_string())
    s.quit()

    
def messageControl(State, statemask):
    state0 = 0
    state1 = 1
    state2 = 2
    state3 = 3
    state4 = 4
    state5 = 5


    if State == state0 and statemask == 0:
    # to get a runtime from the time we exit the 0 state to the time we go to state 1
        FinalTime = int(round(time.time()*1000))
        Runtime = (FinalTime - InitialTime)/1000
        runTimes[State] = Runtime

        
        client.send_message({
                'from': '12366000369',
                'to': '17789980302',
                'text': 'REFLOW OVEN: \n Oven in Wait State: \n '
                })
        state = 1
        return 1
    
    elif State == state0 and statemask == 1:
        client.send_message({
                'from': '12366000369',
                'to': '17789980302',
                'text': 'REFLOW OVEN: \n Oven RETURNED TO WAIT STATE. Time to pick up your Board. \n '
                })
        SendMail('reflowprofile.png')
        state = 1
        return 1
        

    elif State == state1 and statemask == 0:
        # calculating Runtime for each state:
        
        FinalTime = int(round(time.time()*1000))
        Runtime = (FinalTime - InitialTime)/1000
        runTimes[State] = Runtime
        Runtime = Runtime -runTimes[State-1]
        
        client.send_message({
            'from': '12366000369',
            'to': '17789980302',
            'text': 'REFLOW OVEN: \n Oven now in RAMP TO SOAK stage \n Total time in WAIT state: ' + str( round(Runtime,2)) + ' seconds'
                })
        state = 1
        
        return 1

    elif State == state2 and statemask == 0:

        FinalTime = int(round(time.time()*1000))
        Runtime = (FinalTime - InitialTime)/1000
        runTimes[State] = Runtime
        Runtime = Runtime -runTimes[State-1]
        
        client.send_message({
            'from': '12366000369',
            'to': '17789980302',
            'text': 'REFLOW OVEN: \n  \n RAMP TO SOAK Complete! \n Runtime:   ' + str( round(Runtime,2)) + ' seconds \n Oven now in PREHEAT/SOAK stage '
                })
        state = 1
        return True


    elif State == state3 and statemask == 0:

        FinalTime = int(round(time.time()*1000))
        Runtime = (FinalTime - InitialTime)/1000
        runTimes[State] = Runtime
        Runtime = Runtime -runTimes[State-1]

        
        client.send_message({
            'from': '12366000369',
            'to': '17789980302',
            'text': 'REFLOW OVEN: \n  \n PREHEAT/SOAK stage Complete! \n Runtime:   ' + str( round(Runtime,2)) + ' s \n Oven now in RAMP TO PEAK stage '
                })
        state = 1
        return True


    elif State == state4 and statemask == 0:
        time.sleep(5)
        FinalTime = int(round(time.time()*1000))
        Runtime = (FinalTime - InitialTime)/1000
        runTimes[State] = Runtime
        Runtime = Runtime -runTimes[State-1]
        
        
        client.send_message({
            'from': '12366000369',
            'to': '17789980302',
            'text': 'REFLOW OVEN: \n  \n RAMP TO PEAK Complete! \n Runtime:   ' + str( round(Runtime,2)) + ' s \n Oven now in PEAK REFLOW stage '
                })
        state = 1
        return True

    elif State == state5 and statemask == 0:

        FinalTime = int(round(time.time()*1000))
        Runtime = (FinalTime - InitialTime)/1000
        runTimes[State] = Runtime
        Runtime = Runtime -runTimes[State-1]
        
        client.send_message({
            'from': '12366000369',
            'to': '17789980302',
            'text': 'REFLOW OVEN: \n  \n PEAK REFLOW stage Complete! \n Runtime:   ' + str( round(Runtime,2)) + ' s \n Oven now COOLING stage '
                })
        state = 1
        return True

    else:
        return True


   
def runPlotter():
    xsize=100
    ysize = 250
    def data_gen():
        t = data_gen.t
        while True:
            t+=1
            lock.acquire()
            data_raw = ser.readline().decode().strip()
            while (not data_raw):
                data_raw = ser.readline().decode().strip()
            result = data_raw
            splitVal = result.split()
            val=float(splitVal[0])
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
            plt.savefig('reflowprofile.png')
            
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
    plt.xlabel('Time/ s')
    plt.ylabel('Temperature/ C')
    plt.title('REFLOW OVEN PROFILE')
    plt.show()

#os.system('welcome.mp3')           
#os.system('enterState1.mp3')


def runText():
    InitialTime = int(round(time.time()*1000))
    client = nexmo.Client(key='f7cc0105', secret='skbMFLX1yz0rGVZc')

    stateMasks = {
            0: 0,
            1: 0,
            2: 0,
            3: 0,
            4: 0,
            5: 0,
            }
   

    
    while True:
        lock.acquire()
        data_raw = ser.readline().decode().strip()
        if data_raw:
            result = data_raw
            splitVal = result.split()
            state = float(splitVal[1])
        else:
            state = 8

        lock.release()
        


        # Shenanigans to controm messages and shit!

        if state < 6 and state >=0 :
           stateMasks[state] = messageControl(state, stateMasks[state])
           

        else:
            print('Invalid state:')

        
         

if __name__ == "__main__":
    t1 = threading.Thread(target = runPlotter)
    t2 = threading.Thread(target = runText)
    t1.setDaemon(True)
    t2.setDaemon(True)
    t1.start()
    t2.start()
    while True:
        pass
