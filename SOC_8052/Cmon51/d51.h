/*
XMON51: In Application Programable Flash Monitor for the 8051
Copyright (C) 2005-2015  Jesus Calvino-Fraga / jesusc at ece.ubc.ca

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
*/

code char * code mnem[]={
    "mov\t",   "inc\t",    "dec\t",    "acall\t", /* A B C D */
    "add\ta,", "addc\ta,", "orl\ta,",  "ajmp\t",  /* E F G H */
    "anl\ta,", "xrl\ta,",  "subb\ta,", "cjne\t",  /* I J K L */
    "xch\ta,", "djnz\t",   "movx\t",   "dptr" };  /* M N O P */

// WARNING: This table is case sensitive
// TOKEN  ACTION
// &      11 bit paged address
// .      8 bit relative address
// :      16 bit absolute address
// *      will be replaced with @r0 or @r1
// ?      will be replaced with r0 to r7
// #      eight bit constant (except opcode 0x90 which is 16 bit constant)
// !      eight bit address or register name (if found)
// %      eight bit address or bit name (if found)
// [A-Z]  Uppercase letters will be replaced with the strings above

//Notice that the disassembler will use the next non '\n' character to format the opcode.
//For example "inc r0" to "inc r6" will use the same format as "inc r7". This saves 
//quite a bit of memory.

code char mnemtbl[] =
    /*00*/	 "nop\n"           \/* nop */
    /*01*/	 "H&\n"            \/* ajmp 11bit*/
    /*02*/	 "ljmp\t:\n"       \/* ljmp 16bit*/
    /*03*/	 "rr\ta\n"         \/* rr a*/
    /*04*/	 "Ba\n"            \/* inc a*/
    /*05*/	 "B!\n"            \/* inc direct*/
    /*06*/	 "\n"              \/* inc @r0*/
    /*07*/	 "B*\n"            \/* inc @r1*/
    /*08*/	 "\n"              \/* inc r0*/
    /*09*/	 "\n"              \/* inc r1*/
    /*0a*/	 "\n"              \/* inc r2*/
    /*0b*/	 "\n"              \/* inc r3*/
    /*0c*/	 "\n"              \/* inc r4*/
    /*0d*/	 "\n"              \/* inc r5*/
    /*0e*/	 "\n"              \/* inc r6*/
    /*0f*/	 "B?\n"            \/* inc r7*/
    /*10*/	 "jbc\t%,.\n"      \/* jbc bit_direct, relative*/
    /*11*/	 "D&\n"            \/* acall 11bit*/
    /*12*/	 "lcall\t:\n"      \/* lcall 16bit*/
    /*13*/	 "rrc a\n"         \/* rrc a*/
    /*14*/	 "Ca\n"            \/* dec a*/
    /*15*/	 "C!\n"            \/* dec direct*/
    /*16*/	 "\n"              \/* dec @r0*/
    /*17*/	 "C*\n"            \/* dec @r1*/
    /*18*/	 "\n"              \/* dec r0*/
    /*19*/	 "\n"              \/* dec r1*/
    /*1a*/	 "\n"              \/* dec r2*/
    /*1b*/	 "\n"              \/* dec r3*/
    /*1c*/	 "\n"              \/* dec r4*/
    /*1d*/	 "\n"              \/* dec r5*/
    /*1e*/	 "\n"              \/* dec r6*/
    /*1f*/	 "C?\n"            \/* dec r7*/
    /*20*/	 "jb\t%,.\n"       \/* jb bit_direct, relative*/
    /*21*/	 "H&\n"            \/* ajmp 11bit*/
    /*22*/	 "ret\n"           \/* ret */
    /*23*/	 "rl\ta\n"         \/* rl a*/
    /*24*/	 "E#\n"            \/* add a,#*/
    /*25*/	 "E!\n"            \/* add a,direct*/
    /*26*/	 "\n"              \/* add a,@r0*/
    /*27*/	 "E*\n"            \/* add a,@r1*/
    /*28*/	 "\n"              \/* add a,r0*/
    /*29*/	 "\n"              \/* add a,r1*/
    /*2a*/	 "\n"              \/* add a,r2*/
    /*2b*/	 "\n"              \/* add a,r3*/
    /*2c*/	 "\n"              \/* add a,r4*/
    /*2d*/	 "\n"              \/* add a,r5*/
    /*2e*/	 "\n"              \/* add a,r6*/
    /*2f*/	 "E?\n"            \/* add a,r7*/
    /*30*/	 "jnb\t%,.\n"      \/* jnb bit_direct, relative*/
    /*31*/	 "D&\n"            \/* acall 11bit*/
    /*32*/	 "reti\n"          \/* reti */
    /*33*/	 "rlc\ta\n"        \/* rlc a*/
    /*34*/	 "F#\n"            \/* addc a,#*/
    /*35*/	 "F!\n"            \/* addc a,direct*/
    /*36*/	 "\n"              \/* addc a,@r0*/
    /*37*/	 "F*\n"            \/* addc a,@r1*/
    /*38*/	 "\n"              \/* addc a,r0*/
    /*39*/	 "\n"              \/* addc a,r1*/
    /*3a*/	 "\n"              \/* addc a,r2*/
    /*3b*/	 "\n"              \/* addc a,r3*/
    /*3c*/	 "\n"              \/* addc a,r4*/
    /*3d*/	 "\n"              \/* addc a,r5*/
    /*3e*/	 "\n"              \/* addc a,r6*/
    /*3f*/	 "F?\n"            \/* addc a,r7*/
    /*40*/	 "jc\t.\n"         \/* jc relative*/
    /*41*/	 "H&\n"            \/* ajmp 11bit*/
    /*42*/	 "orl\t!,a\n"      \/* orl direct,a*/
    /*43*/	 "orl\t!,#\n"      \/* orl direct,#*/
    /*44*/	 "G#\n"            \/* orl a,#*/
    /*45*/	 "G!\n"            \/* orl a,direct*/
    /*46*/	 "\n"              \/* orl a,@r0*/
    /*47*/	 "G*\n"            \/* orl a,@r1*/
    /*48*/	 "\n"              \/* orl a,r0*/
    /*49*/	 "\n"              \/* orl a,r1*/
    /*4a*/	 "\n"              \/* orl a,r2*/
    /*4b*/	 "\n"              \/* orl a,r3*/
    /*4c*/	 "\n"              \/* orl a,r4*/
    /*4d*/	 "\n"              \/* orl a,r5*/
    /*4e*/	 "\n"              \/* orl a,r6*/
    /*4f*/	 "G?\n"            \/* orl a,r7*/
    /*50*/	 "jnc\t.\n"        \/* jnc relative*/
    /*51*/	 "D&\n"            \/* acall 11bit*/
    /*52*/	 "anl\t!,a\n"      \/* anl direct,a*/
    /*53*/	 "anl\t!,#\n"      \/* anl direct,#*/
    /*54*/	 "I#\n"            \/* anl a,#*/
    /*55*/	 "I!\n"            \/* anl a,direct*/
    /*56*/	 "\n"              \/* anl a,@r0*/
    /*57*/	 "I*\n"            \/* anl a,@r1*/
    /*58*/	 "\n"              \/* anl a,r0*/
    /*59*/	 "\n"              \/* anl a,r1*/
    /*5a*/	 "\n"              \/* anl a,r2*/
    /*5b*/	 "\n"              \/* anl a,r3*/
    /*5c*/	 "\n"              \/* anl a,r4*/
    /*5d*/	 "\n"              \/* anl a,r5*/
    /*5e*/	 "\n"              \/* anl a,r6*/
    /*5f*/	 "I?\n"            \/* anl a,r7*/
    /*60*/	 "jz\t.\n"         \/* jz relative*/
    /*61*/	 "H&\n"            \/* ajmp 11bit*/
    /*62*/	 "xrl\t!,a\n"      \/* xrl direct,a*/
    /*63*/	 "xrl\t!,#\n"      \/* xrl direct,#*/
    /*64*/	 "J#\n"            \/* xrl a,#*/
    /*65*/	 "J!\n"            \/* xrl a,direct*/
    /*66*/	 "\n"              \/* xrl a,@r0*/
    /*67*/	 "J*\n"            \/* xrl a,@r1*/
    /*68*/	 "\n"              \/* xrl a,r0*/
    /*69*/	 "\n"              \/* xrl a,r1*/
    /*6a*/	 "\n"              \/* xrl a,r2*/
    /*6b*/	 "\n"              \/* xrl a,r3*/
    /*6c*/	 "\n"              \/* xrl a,r4*/
    /*6d*/	 "\n"              \/* xrl a,r5*/
    /*6e*/	 "\n"              \/* xrl a,r6*/
    /*6f*/	 "J?\n"            \/* xrl a,r7*/
    /*70*/	 "jnz\t.\n"        \/* jnz relative*/
    /*71*/	 "D&\n"            \/* acall 11bit*/
    /*72*/	 "orl\tc,%\n"      \/* orl c, bit_direct*/
    /*73*/	 "jmp\t@a+P\n"     \/* jmp @a+dptr*/
    /*74*/	 "Aa,#\n"          \/* mov a,#*/
    /*75*/	 "A!,#\n"          \/* mov direct,#*/
    /*76*/	 "\n"              \/* mov @r0,#*/
    /*77*/	 "A*,#\n"          \/* mov @r1,#*/
    /*78*/	 "\n"              \/* mov r0,#*/
    /*79*/	 "\n"              \/* mov r1,#*/
    /*7a*/	 "\n"              \/* mov r2,#*/
    /*7b*/	 "\n"              \/* mov r3,#*/
    /*7c*/	 "\n"              \/* mov r4,#*/
    /*7d*/	 "\n"              \/* mov r5,#*/
    /*7e*/	 "\n"              \/* mov r6,#*/
    /*7f*/	 "A?,#\n"          \/* mov r7,#*/
    /*80*/	 "sjmp\t.\n"       \/* sjmp relative*/
    /*81*/	 "H&\n"            \/* ajmp 11bit*/
    /*82*/	 "anl c,%\n"       \/* anl c, bit_direct*/
    /*83*/	 "movc\ta,@a+pc\n" \/* movc a,@a+pc*/
    /*84*/	 "div\tab\n"       \/* div ab*/
    /*85*/	 "A!,!\n"          \/* mov direct, direct*/
    /*86*/	 "\n"              \/* mov direct, @r0*/
    /*87*/	 "A!,*\n"          \/* mov direct, @r1*/
    /*88*/	 "\n"              \/* mov direct, r0*/
    /*89*/	 "\n"              \/* mov direct, r1*/
    /*8a*/	 "\n"              \/* mov direct, r2*/
    /*8b*/	 "\n"              \/* mov direct, r3*/
    /*8c*/	 "\n"              \/* mov direct, r4*/
    /*8d*/	 "\n"              \/* mov direct, r5*/
    /*8e*/	 "\n"              \/* mov direct, r6*/
    /*8f*/	 "A!,?\n"          \/* mov direct, r7*/
    /*90*/	 "AP,#\n"          \/* mov dptr,#  WARNING: only exception to # use*/
    /*91*/	 "D&\n"            \/* acall 11bit*/
    /*92*/	 "A%,c\n"          \/* mov bit_direct, c*/
    /*93*/	 "movc\ta,@a+P\n"  \/* movc a,@a+dptr*/
    /*94*/	 "K#\n"            \/* subb a,#*/
    /*95*/	 "K!\n"            \/* subb a,direct*/
    /*96*/	 "\n"              \/* subb a,@r0*/
    /*97*/	 "K*\n"            \/* subb a,@r1*/
    /*98*/	 "\n"              \/* subb a,r0*/
    /*99*/	 "\n"              \/* subb a,r1*/
    /*9a*/	 "\n"              \/* subb a,r2*/
    /*9b*/	 "\n"              \/* subb a,r3*/
    /*9c*/	 "\n"              \/* subb a,r4*/
    /*9d*/	 "\n"              \/* subb a,r5*/
    /*9e*/	 "\n"              \/* subb a,r6*/
    /*9f*/	 "K?\n"            \/* subb a,r7*/
    /*a0*/	 "orl\tc,/.\n"     \/* orl c,/*/
    /*a1*/	 "H&\n"            \/* ajmp 11bit*/
    /*a2*/	 "Ac,%\n"          \/* mov c, bit_direct*/
    /*a3*/	 "BP\n"            \/* inc dptr*/
    /*a4*/	 "mul\tab\n"       \/* mul ab*/
    /*a5*/	 "db\ta5\n"        \/* db a5*/
    /*a6*/	 "\n"              \/* mov @r0, direct*/
    /*a7*/	 "A*,!\n"          \/* mov @r1, direct*/
    /*a8*/	 "\n"              \/* mov r0, direct*/
    /*a9*/	 "\n"              \/* mov r1, direct*/
    /*aa*/	 "\n"              \/* mov r2, direct*/
    /*ab*/	 "\n"              \/* mov r3, direct*/
    /*ac*/	 "\n"              \/* mov r4, direct*/
    /*ad*/	 "\n"              \/* mov r5, direct*/
    /*ae*/	 "\n"              \/* mov r6, direct*/
    /*af*/	 "A?,!\n"          \/* mov r7, direct*/
    /*b0*/	 "anl\tc,/.\n"     \/* anl c,/*/
    /*b1*/	 "D&\n"            \/* acall 11bit*/
    /*b2*/	 "cpl\t%\n"        \/* cpl */
    /*b3*/	 "cpl\tc\n"        \/* cpl c*/
    /*b4*/	 "La,# .\n"        \/* cjne a,# relative*/
    /*b5*/	 "La,! .\n"        \/* cjne a,direct relative*/
    /*b6*/	 "\n"              \/* cjne @r0,# relative*/
    /*b7*/	 "L*,# .\n"        \/* cjne @r1,# relative*/
    /*b8*/	 "\n"              \/* cjne r0,# relative*/
    /*b9*/	 "\n"              \/* cjne r1,# relative*/
    /*ba*/	 "\n"              \/* cjne r2,# relative*/
    /*bb*/	 "\n"              \/* cjne r3,# relative*/
    /*bc*/	 "\n"              \/* cjne r4,# relative*/
    /*bd*/	 "\n"              \/* cjne r5,# relative*/
    /*be*/	 "\n"              \/* cjne r6,# relative*/
    /*bf*/	 "L?,# .\n"        \/* cjne r7,# relative*/
    /*c0*/	 "push\t!\n"       \/* push direct*/
    /*c1*/	 "H&\n"            \/* ajmp 11bit*/
    /*c2*/	 "clr\t%\n"        \/* clr bit_direct*/
    /*c3*/	 "clr\tc\n"        \/* clr c*/
    /*c4*/	 "swap\ta\n"       \/* swap a*/
    /*c5*/	 "M!\n"            \/* xch a,direct*/
    /*c6*/	 "\n"              \/* xch a,@r0*/
    /*c7*/	 "M*\n"            \/* xch a,@r1*/
    /*c8*/	 "\n"              \/* xch a,r0*/
    /*c9*/	 "\n"              \/* xch a,r1*/
    /*ca*/	 "\n"              \/* xch a,r2*/
    /*cb*/	 "\n"              \/* xch a,r3*/
    /*cc*/	 "\n"              \/* xch a,r4*/
    /*cd*/	 "\n"              \/* xch a,r5*/
    /*ce*/	 "\n"              \/* xch a,r6*/
    /*cf*/	 "M?\n"            \/* xch a,r7*/
    /*d0*/	 "pop\t!\n"        \/* pop direct*/
    /*d1*/	 "D&\n"            \/* acall 11bit*/
    /*d2*/	 "setb\t%\n"       \/* setb bit_direct*/
    /*d3*/	 "setb\tc\n"       \/* setb c*/
    /*d4*/	 "da\ta\n"         \/* da a*/
    /*d5*/	 "N! .\n"          \/* djnz direct relative*/
    /*d6*/	 "\n"              \/* xchd a,@r0*/
    /*d7*/	 "xchd\ta,*\n"     \/* xchd a,@r1*/
    /*d8*/	 "\n"              \/* djnz r0, relative*/
    /*d9*/	 "\n"              \/* djnz r1, relative*/
    /*da*/	 "\n"              \/* djnz r2, relative*/
    /*db*/	 "\n"              \/* djnz r3, relative*/
    /*dc*/	 "\n"              \/* djnz r4, relative*/
    /*dd*/	 "\n"              \/* djnz r5, relative*/
    /*de*/	 "\n"              \/* djnz r6, relative*/
    /*df*/	 "N?,.\n"          \/* djnz r7, relative*/
    /*e0*/	 "Oa,@P\n"         \/* movx a,@dptr*/
    /*e1*/	 "H&\n"            \/* ajmp 11bit*/
    /*e2*/	 "\n"              \/* movx a,@r0*/
    /*e3*/	 "Oa,*\n"          \/* movx a,@r1*/
    /*e4*/	 "clr\ta\n"        \/* clr a*/
    /*e5*/	 "Aa,!\n"          \/* mov a, direct*/
    /*e6*/	 "\n"              \/* mov a,@r0*/
    /*e7*/	 "Aa,*\n"          \/* mov a,@r1*/
    /*e8*/	 "\n"              \/* mov a,r0*/
    /*e9*/	 "\n"              \/* mov a,r1*/
    /*ea*/	 "\n"              \/* mov a,r2*/
    /*eb*/	 "\n"              \/* mov a,r3*/
    /*ec*/	 "\n"              \/* mov a,r4*/
    /*ed*/	 "\n"              \/* mov a,r5*/
    /*ee*/	 "\n"              \/* mov a,r6*/
    /*ef*/	 "Aa,?\n"          \/* mov a,r7*/
    /*f0*/	 "O@P,a\n"         \/* movx @dptr,a*/
    /*f1*/	 "D&\n"            \/* acall 11bit*/
    /*f2*/	 "\n"              \/* movx @r0,a*/
    /*f3*/	 "O*,a\n"          \/* movx @r1,a*/
    /*f4*/	 "cpl\ta\n"        \/* cpl a*/
    /*f5*/	 "A!,a\n"          \/* mov direct, a*/
    /*f6*/	 "\n"              \/* mov @r0,a*/
    /*f7*/	 "A*,a\n"          \/* mov @r1,a*/
    /*f8*/	 "\n"              \/* mov r0,a*/
    /*f9*/	 "\n"              \/* mov r1,a*/
    /*fa*/	 "\n"              \/* mov r2,a*/
    /*fb*/	 "\n"              \/* mov r3,a*/
    /*fc*/	 "\n"              \/* mov r4,a*/
    /*fd*/	 "\n"              \/* mov r5,a*/
    /*fe*/	 "\n"              \/* mov r6,a*/
    /*ff*/	 "A?,a\n"          \/* mov r7,a*/
;
    
