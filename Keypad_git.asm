    #include <xc.h>
    #include "configbits.c"
    .global main
    .set noreorder
    
.ent main

main:
/*---------------------------lookup table------------------------------------------------------*/
    addi    sp, sp, -40
    addiu   t0,	zero, 0x00c0	//0
    sw	    t0,0(sp)		
    addiu   t0, zero, 0x00f9	//1
    sw	    t0,4(sp)
    addiu   t0, zero, 0x00a4	//2
    sw	    t0,8(sp)
    addiu   t0, zero, 0x00b0	//3
    sw	    t0,12(sp)
    addiu   t0, zero, 0x0099	//4
    sw	    t0,16(sp)
    addiu   t0, zero, 0x0092	//5   
    sw	    t0,20(sp)
    addiu   t0, zero, 0x0082	//6
    sw	    t0,24(sp)
    addiu   t0,	zero, 0x00f8	//7
    sw	    t0,28(sp)	
    addiu   t0,	zero, 0x0080	//8
    sw	    t0,32(sp)	
    addiu   t0,	zero, 0x0098	//9
    sw	    t0,36(sp)
    
/*---------------------------initialize--------------------------------------------------------*/
la  t0,ANSELA
sw  zero,0(t0)
la  t0,ANSELB
sw  zero,0(to)


//----------------------------
loop:
jal   print
nop
jal   readKey
nop
addu  t0,zero,a0
jal   delay
nop
jal   readKey
nop
bne   a0,t0,loop
nop
j loop
nop
//-----------------------------
print:  //prints {a3,a2,a1,a0}
addi  sp,sp,-4
sw    ra,0(sp)
la    t0,TRISB
sw    zero,0(t0)
//Digit0
addu  t0,a0,sp
addiu t0,t0,4
lw    s0,0(t0)
addiu s0,s0,0x0100
la    t0,LATB
sw    s0,0(t0)
jal   delay
nop
//Digit1
addu  t0,a1,sp
addiu t0,t0,4
lw    s1,0(t0)
addiu s1,s1,0x0200
la    t0,LATB
sw    s1,0(t0)
//Digit2
addu  t0,a2,sp
addiu t0,t0,4
lw    s2,0(t0)
addiu s2,s2,0x0400
la    t0,LATB
sw    s2,0(t0)
//Digit3
addu  t0,a3,sp
addiu t0,t0,4
lw    s3,0(t0)
addiu s3,s3,0x0800
la    t0,LATB
sw    s3,0(t0)

lw    ra,0(sp)
addiu sp,sp,4
jr ra
nop
//------------------------------
    delay:
	    addi	sp,sp,-4
	    sw		t0,0(sp)
	    addiu	t0,zero,0x3fff
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
      la    t0,TRISB
      sw    zero,0(t0)
B12:   
      la    t0,LATB
      addiu t1,zero,0x1000
      sw    t1,0(t0)
          la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
          A0:
          addiu t1,zero,0x0001
          beq   t1,t0,B12_A0
          nop
          A1:
          addiu t1,zero,0x0002
          beq   t1,t0,B12_A1
          nop
          A2:
          addiu t1,zero,0x0004
          beq   t1,t0,B12_A2
          nop
          A3:
          addiu t1,zero,0x0008
          beq   t1,t0,B12_A3
          nop
          A4:
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
          A0:
          addiu t1,zero,0x0001
          beq   t1,t0,B13_A0
          nop
          A1:
          addiu t1,zero,0x0002
          beq   t1,t0,B13_A1
          nop
          A2:
          addiu t1,zero,0x0004
          beq   t1,t0,B13_A2
          nop
          A3:
          addiu t1,zero,0x0008
          beq   t1,t0,B13_A3
          nop
          A4:
          addiu t1,zero,0x0010
          beq   t1,t0,B13_A4
          nop

B14:
      la    t0,LATB
      addiu t1,zero,0x4000
      sw    t1,0(t0)
          la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
          A0:
          addiu t1,zero,0x0001
          beq   t1,t0,B14_A0
          nop
          A1:
          addiu t1,zero,0x0002
          beq   t1,t0,B14_A1
          nop
          A2:
          addiu t1,zero,0x0004
          beq   t1,t0,B14_A2
          nop
          A3:
          addiu t1,zero,0x0008
          beq   t1,t0,B14_A3
          nop
          A4:
          addiu t1,zero,0x0010
          beq   t1,t0,B14_A4
          nop

B15:
      la    t0,LATB
      addiu t1,zero,0x8000
      sw    t1,0(t0)
          la  t0,PORTA
          lw  t0,0(t0)
          beq t0,zero,loop
          nop
          A0:
          addiu t1,zero,0x0001
          beq   t1,t0,B15_A0
          nop
          A1:
          addiu t1,zero,0x0002
          beq   t1,t0,B15_A1
          nop
          A2:
          addiu t1,zero,0x0004
          beq   t1,t0,B15_A2
          nop
          A3:
          addiu t1,zero,0x0008
          beq   t1,t0,B15_A3
          nop
          A4:
          addiu t1,zero,0x0010
          beq   t1,t0,B15_A4
          nop

          jr ra
      nop
  B12_A0:
      addiu   a0,zero,0x0001
      jr  ra
      nop
  B12_A1:
      addiu   a0,zero,0x0002
      jr  ra
      nop
  B12_A2:
      addiu   a0,zero,0x0003
      jr  ra
      nop
  B12_A3:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  B12_A4:
      addiu   a0,zero,0x000f
      jr  ra
      nop

  B13_A0:
      addiu   a0,zero,0x0004
      jr  ra
      nop
  B13_A1:
      addiu   a0,zero,0x0005
      jr  ra
      nop
  B13_A2:
      addiu   a0,zero,0x0006
      jr  ra
      nop
  B13_A3:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  B13_A4:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  
  B14_A0:
      addiu   a0,zero,0x0007
      jr  ra
      nop
  B14_A1:
      addiu   a0,zero,0x0008
      jr  ra
      nop
  B14_A2:
      addiu   a0,zero,0x0009
      jr  ra
      nop
  B14_A3:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  B14_A4:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  
  B15_A0:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  B15_A1:
      addiu   a0,zero,0x0000
      jr  ra
      nop
  B15_A2:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  B15_A3:
      addiu   a0,zero,0x000f
      jr  ra
      nop
  B15_A4:
      addiu   a0,zero,0x000f
      jr  ra
      nop
 
.end main
