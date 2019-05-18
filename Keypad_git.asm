    #include <xc.h>
    #include "configbits.c"
    .global main
    .set noreorder
    
.ent main

main:
/*---------------------------lookup table------------------------------------------------------*/
   addi    sp, sp, -40
    addiu   t0, zero, 0x003f	//0
    sw	    t0,0(sp)		
    addiu   t0, zero, 0x0006	//1
    sw	    t0,4(sp)
    addiu   t0, zero, 0x005b	//2
    sw	    t0,8(sp)
    addiu   t0, zero, 0x004f	//3
    sw	    t0,12(sp)
    addiu   t0, zero, 0x0066	//4
    sw	    t0,16(sp)
    addiu   t0, zero, 0x006d	//5   
    sw	    t0,20(sp)
    addiu   t0, zero, 0x007d	//6
    sw	    t0,24(sp)
    addiu   t0, zero, 0x0007	//7
    sw	    t0,28(sp)	
    addiu   t0, zero, 0x007f	//8
    sw	    t0,32(sp)	
    addiu   t0, zero, 0x006f	//9
    sw	    t0,36(sp)	
    
    /*---------------------------initialize--------------------------------------------------------*/
la  t0,ANSELA
sw  zero,0(t0)
la  t0,ANSELB
sw  zero,0(t0)

//----------------------------
loop:
/*jal   print
nop
jal   delay
nop
*/
jal print
    nop
jal   readKey
nop
addu  t0,zero,v0
jal   delay
nop
jal   readKey
nop
bne   v0,t0,loop
nop
jal   print
nop
jal   delay
nop
j loop
nop
//-----------------------------
     //Dast nazan namosan!
print:  //prints {v3,v2,v1,v0}	   
addi  sp,sp,-4
sw    ra,0(sp)
la    t0,TRISB
sw    zero,0(t0)
//Digit0
addi s0,v0,0    
sll   s0,s0,2    
addu  t0,s0,sp
addiu t0,t0,4
lw    s0,0(t0)
ori   s0,s0,0x0100
la    t0,LATB
sw    s0,0(t0)
jal   delay
nop
//Digit1
sll	a1,v1,2    
addu  t0,a1,sp
addiu t0,t0,4
lw    s1,0(t0)
ori  s1,s1,0x0200
la    t0,LATB
sw    s1,0(t0)
jal	delay
nop    
/*
    //Digit2
sll	a2,v2,2    
addu  t0,a2,sp
addiu t0,t0,4
lw    s2,0(t0)
ori s2,s2,0x0400
la    t0,LATB
sw    s2,0(t0)
jal	delay
nop
*/	
/*
//Digit3
sll	a3,v3,2    
addu	t0,a3,sp
addiu	t0,t0,4
lw	s3,0(t0)
ori	s3,s3,0x0800
la	t0,LATB
sw	s3,0(t0)
jal	delay
nop
    */
lw    ra,0(sp)
addiu sp,sp,4
    jr ra
nop
//------------------------------
    delay:
	    addi	sp,sp,-4
	    sw		t0,0(sp)
	    addiu	t0,zero,0x2fff
	    countdown:
	    addi	t0,t0,-1
	    beq	t0,zero,delay_return
		  nop
	    j countdown
		  nop
	    delay_return:
	    lw	t0,0(sp)
	    addi    sp,sp,4
	    jr  ra
		  nop
 //-------------------------------------     
     readKey:
      la    t0,TRISA
      addiu t1,zero,0x001f
      sw    t1,0(t0)
      la    t0,CNPDA
      sw    t1,0(t0)
      la    t0,TRISB
      sw    zero,0(t0)
      
      la    t0,LATB
      addiu t1,zero,0x1000
      sw    t1,0(t0)
      la    t0,PORTA
      lw    t1,0(t0)
      addu a0,zero,t1
B12:   
      la    t0,LATB
      addiu t1,zero,0x1000
      sw    t1,0(t0)
      nop
      nop
      nop
      nop
          la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
          
          addiu t1,zero,0x0001
          beq   t1,t0,B12_A0
          nop
          
          addiu t1,zero,0x0002
          beq   t1,t0,B12_A1
          nop
          
          addiu t1,zero,0x0004
          beq   t1,t0,B12_A2
          nop
         
	  addiu t1,zero,0x0008
          beq   t1,t0,B12_A3
          nop
         
          addiu t1,zero,0x0010
          beq   t1,t0,B12_A4
          nop

B13:
      la    t0,LATB
      addiu t1,zero,0x2000
      sw    t1,0(t0)
      
          la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
         
          addiu t1,zero,0x0001
          beq   t1,t0,B13_A0
          nop
         
          addiu t1,zero,0x0002
          beq   t1,t0,B13_A1
          nop
         
          addiu t1,zero,0x0004
          beq   t1,t0,B13_A2
          nop
         
          addiu t1,zero,0x0008
          beq   t1,t0,B13_A3
          nop
         
          addiu t1,zero,0x0010
          beq   t1,t0,B13_A4
          nop

B14:
      la    t0,LATB
      addiu t1,zero,0x4000
      sw    t1,0(t0)
      nop
      nop
      nop
      nop
	  la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
         
          addiu t1,zero,0x0001
          beq   t1,t0,B14_A0
          nop
         
          addiu t1,zero,0x0002
          beq   t1,t0,B14_A1
          nop
         
          addiu t1,zero,0x0004
          beq   t1,t0,B14_A2
          nop
         
          addiu t1,zero,0x0008
          beq   t1,t0,B14_A3
          nop
         
          addiu t1,zero,0x0010
          beq   t1,t0,B14_A4
          nop

B15:
      la    t0,LATB
      addiu t1,zero,0x8000
      sw    t1,0(t0)
      nop
      nop
      nop
      nop
	  la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
          
          addiu t1,zero,0x0001
          beq   t1,t0,B15_A0
          nop
         
          addiu t1,zero,0x0002
          beq   t1,t0,B15_A1
          nop
         
          addiu t1,zero,0x0004
          beq   t1,t0,B15_A2
          nop
         
          addiu t1,zero,0x0008
          beq   t1,t0,B15_A3
          nop
         
          addiu t1,zero,0x0010
          beq   t1,t0,B15_A4
          nop

          jr ra
      nop
  B12_A0:
      addiu   v0,zero,0x0005
      jr  ra
      nop
  B12_A1:
      addiu   v0,zero,0x0002
      jr  ra
      nop
  B12_A2:
      addiu   v0,zero,0x0003
      jr  ra
      nop
  B12_A3:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  B12_A4:
      addiu   v0,zero,0x000f
      jr  ra
      nop

  B13_A0:
      addiu   v0,zero,0x0004
      jr  ra
      nop
  B13_A1:
      addiu   v0,zero,0x0005
      jr  ra
      nop
  B13_A2:
      addiu   v0,zero,0x0006
      jr  ra
      nop
  B13_A3:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  B13_A4:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  
  B14_A0:
      addiu   v0,zero,0x0007
      jr  ra
      nop
  B14_A1:
      addiu   v0,zero,0x0008
      jr  ra
      nop
  B14_A2:
      addiu   v0,zero,0x0009
      jr  ra
      nop
  B14_A3:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  B14_A4:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  
  B15_A0:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  B15_A1:
      addiu   v0,zero,0x0000
      jr  ra
      nop
  B15_A2:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  B15_A3:
      addiu   v0,zero,0x000f
      jr  ra
      nop
  B15_A4:
      addiu   v0,zero,0x000f
      jr  ra
      nop
 
.end main
