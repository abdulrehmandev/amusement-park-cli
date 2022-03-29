include irvine32.inc
buffer = 500
.data
;   to print little drawing
   display0 byte "                                                          __",10,"                                                     __.-(__)-.__ ",10,"                                                    (__)  |   (__) ",10,"                                                 __/  \   |   /   \__ ",10,0
   display1 byte"                                                (__)   \  |  /    (__) ",10,"              ___                               J  `-.  \ | /  .-'  L   ",10,"            //   \\                           .-+.____`-.\|/.-'____.+-.   ",10,"           //     \\                          `-+'     .-/|\`-.    `+-'   ",10,0
   display2 byte"          //       \\                           J_  .-' / | \  `-. _F     ",10,"         //         \\         ___             (__)'   /  |  \    (__)    ",10,"        //           \\      //   \\              `.__/   |   \__.'     ",10,0
   display3 byte"       //             \\    //     \\              (__)   |_  (__)  ",10,"      //               \\__//       \\              / `-.(__)-' \     ",10, "     //                              \\            /   /      \  \         ",10," ___//                                \\__________/__ /________\__\______________    ",10,0

   ; OPTIONS ABOUT RIDES

park byte " WELCOME to  THRILL PARK ",10,0
stars byte "***********************************************************************************",10,0
ride1 BYTE " - Roller Coster [+13]",0
ride2 byte " - Ferris Wheel [+13]",0
ride3 byte " - Pirate Ship Ride",0
ride4 byte " - Tagarda Ride",0
ride5 byte " - Swing Thrill",0
ride6 byte " - Carousel Ride",0

rs byte " Rs. ",0

prices dd 100,70,70,80,50,50

msg byte "Enter Ride Number: ", 0
invalid byte "Invalid Input!", 0
ride dd ?

msgTicket byte "Number of Tickets: ",0
tickets dd ?

msgage byte "Enter the age : ",0
ages dd 100 dup(?)

booked BYTE "Total Tickets booked are: ",0
underAge Byte "Members underaged are: ",0
tPrice BYTE "Total Price for this ride is: ",0
Again BYTE "Do you want to book another ride",10,"Enter y for Yes and n for No:  ",0
again1 DD ?
valid DD 0
Rprice DD 0
noRides BYTE "Numbers of Rides selected: ",0
numrides DD 1 dup(?)
price Byte "Total amount for tickets to be paid is: ",0
total DD 0
mssg byte "               Tickets are Booked!",10,"                             Enjoy your Rides :)",10,"                             Thanks for visitting Thrill Park!!",0

;*************************************************************************************************************************
.code

;----------------------------DISPLAYING FERRIS WHEEL-----------
display_ride proc
mov edx,offset display0
call writestring
mov edx,offset display1
call writestring
mov edx,offset display2
call writestring
mov edx,offset display3
call writestring
call crlf
call crlf
ret
display_ride endp
;*******************************************************************************************************


display proc                   ; Display Procedure

mov edx, offset park
call writestring
mov edx, offset stars
call writestring

mov edi, offset prices

mov ebx, 1
mov eax, ebx
call writedec
inc ebx
									;ride 1
mov edx, offset ride1
call writestring

mov edx, offset rs
call writestring

mov eax, [edi+0]
call writedec
call crlf

mov eax, ebx
call writedec
inc ebx
									;ride 2
mov edx, offset ride2
call writestring
mov edx, offset rs
call writestring

mov eax, [edi+4]
call writedec
call crlf

mov eax, ebx
call writedec
inc ebx
									;ride 3
mov edx, offset ride3
call writestring
mov edx, offset rs
call writestring

mov eax, [edi+8]
call writedec
call crlf

mov eax, ebx
call writedec
inc ebx
									;ride 4
mov edx, offset ride4
call writestring
mov edx, offset rs
call writestring

mov eax, [edi+12]
call writedec
call crlf

mov eax, ebx
call writedec
inc ebx
									;ride 5
mov edx, offset ride5
call writestring
mov edx, offset rs
call writestring

mov eax, [edi+16]
call writedec
call crlf

mov eax, ebx
call writedec
inc ebx
								;ride 6
mov edx, offset ride6
call writestring
mov edx, offset rs
call writestring

mov eax, [edi+20]
call writedec
call crlf

mov edx, offset stars
call writestring

ret
display endp

takeRide proc                    ; Take Ride Procedure
mov ecx, 0

.repeat
mov edx, offset msg
call writestring
call readint

.if eax > 0 && eax < 7
mov ride, eax
inc ecx
.else
mov edx, offset invalid
call writestring
.endif
call crlf
.until ecx == 1

ret
takeRide endp

takeTickets proc             ; Take Tickets Procedure

l1:
call takeRide
inc numrides
mov edx, offset msgTicket
call writestring
call readint
mov tickets, eax           


mov ecx, tickets
mov edi ,offset ages
mov ebx, 0

.while ecx != 0
mov edx, offset msgage
call writestring
call readint

mov [edi + ebx], eax
add ebx, 4 
.if eax > 13
inc valid
.endif
dec ecx
.endw

.if ride ==1 || ride ==2
mov edx, offset booked
call writestring
mov eax,valid
call writedec
call crlf
mov edx, offset underAge
call writestring
mov eax, tickets
sub eax, valid
call writedec
call price1
.else
mov edx, offset booked
call writestring
mov eax,tickets
call writedec
call price1

.endif

call crlf
mov edx, offset Again       ; for again taking input
call writestring
call readchar
.if al == 'y'
call crlf
call crlf
mov ride, 0
mov tickets, 0
mov valid, 0
mov Rprice, 0
jmp l1
.else
jmp l2
.endif

l2:
ret
takeTickets endp

price1 proc                  ; Price Procedure
.if ride == 1
mov edi, offset prices
mov eax,[edi+0]
mov ebx, valid
mul ebx  
add total,eax
add Rprice, eax
.elseif ride == 2
mov edi, offset prices
mov eax,[edi+4]
mov ebx, valid
mul ebx  
add total,eax
add Rprice, eax
.elseif ride == 3
mov edi, offset prices
mov eax,[edi+8]
mov ebx, tickets
mul ebx  
add total,eax
add Rprice, eax
.elseif ride == 4
mov edi, offset prices
mov eax,[edi+12]
mov ebx, tickets
mul ebx  
add total,eax
add Rprice, eax
.elseif ride == 5
mov edi, offset prices
mov eax,[edi+16]
mov ebx, tickets
mul ebx  
add total,eax
add Rprice, eax
.elseif ride == 6
mov edi, offset prices
mov eax,[edi+20]
mov ebx, tickets
mul ebx  
add total,eax
add Rprice, eax
.endif
 
mov edx, offset tPrice
call crlf
call writestring
mov eax, Rprice
call writedec

ret
price1 endp


Total1 proc                      ; Total Procedure
call clrscr
call display_ride
call crlf 
mov edx, offset stars
call writestring
mov edx, offset noRides
call writestring
mov eax, numrides
call writedec
call crlf
mov edx, offset price
call writestring
mov eax, total
call writedec

call crlf
mov edx, offset mssg
call writestring
call crlf
mov edx, offset stars
call writestring
ret 
Total1 endp

main proc

call display_ride
call display
call takeTickets
call Total1
exit
main endp
end
