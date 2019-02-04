#Authored by Brandon Bwankocha Lol.

import smtplib
import serial


ser = serial.Serial(
    port='COM8',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS
)


# Establish a secure session with gmail's outgoing SMTP server using your gmailaccount
server = smtplib.SMTP( "smtp.gmail.com", 587 )

server.starttls()

server.login( '<Your Email Address>', '<Your App password from Gmail>' )


#Using our Lab 3 code, we can retrieve temperature from serial and then use it to see send us a text when Temperature is above 23

while 1:
    result = ser.readline()
    val = float(result)
    if val == 23.0:
        if state == 0:
            server.sendmail( 'Your Reflow Oven', '+17789980302@pcs.rogers.com', ' : Your Message!' )
        state = 1
    print (val)
