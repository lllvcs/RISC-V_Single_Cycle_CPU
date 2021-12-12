jal start
add x0,x1,x2
 

 
start:
addi x1,x0,1
addi x2,x0,2
addi x3,x0,3
add x4,x1,x3
sub x5,x4,x2
blt x5,x4,a
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
addi x0,x0,0
a:
addi x6,x0,6
this:
jal this
