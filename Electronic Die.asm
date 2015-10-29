/*
 * AVRAssembler1.asm
 *
 *  Created: 29.4.2014 14:39:27
 *   Author: kararha
 */ 
  ; in R16 first 2 bits represent the state of the buttons
; 00000001 - value of 1d is going to represent the TST button
; 00000010 - value of 2d is going to represent the ACK button
; register R17 - outputs - first 7 leds connected to them
.include "m328Pdef.inc"
.org 0x0000

ldi R16, high(ramend)
out SPH, R16
ldi R16, low(ramend)
out SPL, R16
ldi R17, high(ramend)
out SPH, R17
ldi R17, low(ramend)
out SPL, R17

jmp Start
hwinit:
ldi R16, 0
sts UCSR0B, R16 ; disable UASRT0
ldi R17, 0
sts UCSR0B, R17

LDI    R16,  0x00       	
OUT    DDRC, R16        	; Pins on DDRC as inputs
LDI	   R16, 0x03 
OUT	   PORTC, R16                       	 
LDI    R17,  0xFF	        
OUT    DDRD, R17 			; Pins on PORTD as outputs

ret



LDI R20, 0xFF     
RJMP Start	
   		                
delay:
LDI R18, 0
loop:
LDI R19, 0
INC R18
TST R18
BREQ out1
loop2:
INC R19
TST R19
BREQ loop					; setting a 256*256 delay loop
RJMP loop2
out1:
RET

Start:
RCALL hwinit
CLR R16
CALL delay
LDI R17, 0
OUT PORTD, R17
CALL delay
IN R16, PINC
CPI R16, 2
BREQ S1
CPI R16, 1
BREQ S7
RJMP Start
S1:
RCALL hwinit
LDI R17, 0b00010000		; lighting 1 led(s)
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
OUT PORTD, R17
CPI R16, 2
BREQ S2
CPI R16, 1
BREQ S7
RJMP S1
S2:
RCALL hwinit
LDI R17, 0b10001000		; lighting 2 leds
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
OUT PORTD, R17
CPI R16, 2
BREQ S3
CPI R16, 1
BREQ S7
RJMP S2
S3:
RCALL hwinit
LDI R17, 0b10011000		; lighting 3 leds
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
OUT PORTD, R17
CPI R16, 2
BREQ S4
CPI R16, 1
BREQ S7
RJMP S3
S7:
RCALL hwinit
LDI R17, 0b11111110		; lighting all leds
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
CPI R16, 1
BREQ S7
RJMP Start
S4:
RCALL hwinit
LDI R17, 0b10101010		; lighting 4 leds
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
OUT PORTD, R17
CPI R16, 2
BREQ S5
CPI R16, 1
BREQ S7
RJMP S4
S5:
RCALL hwinit
LDI R17, 0b10111010		; lighting 5 leds
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
OUT PORTD, R17
CPI R16, 2
BREQ S6
CPI R16, 1
BREQ S7
RJMP S5
S6:
RCALL hwinit
LDI R17, 0b11101110		; lighting 6 leds
OUT PORTD, R17
CLR R16
CALL delay
IN R16, PINC
OUT PORTD, R17
CPI R16, 2
BREQ test
CPI R16, 1
BREQ S7
RJMP S6
test:
JMP S1

stop:
rjmp stop






