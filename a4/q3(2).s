.pos 0x1000
code:
ld $s, r0                     # r0 = address of s
ld 0x0(r0), r1                # r1 = address of s.x array
ld $i, r2                     # r2 = address of i
ld 0x0(r2), r2                # r2 = value of i
ld (r1, r2, 4), r3            # r3 = x[i]
ld $v0, r4                    # r4 = address of v0
st r3, 0x0(r4)                # v0 = x[i]

ld 0x8(r0), r1               # r1 = address of s.y
ld (r1, r2, 4), r3            # r3 = y[i]
ld $v1, r4                    # r4 = address of v1
st r3, 0x0(r4)                # v1 = y[i]

ld 0xc(r0), r1               # r1 = address of s.z
ld 0x0(r1), r3               # r3 = address of s.z->x
ld (r3,r2,4), r4              # r4 = s.z->x[i]
ld $v2, r5                    # r5 = address of v2
st r4, 0x0(r5)                # v2 = s.z -> x[i]

ld 0x10(r1), r3              # r3 = address of s.z -> z
ld 0x8(r3), r4               # r4 = address of s.z -> z -> y
ld (r4,r2,4), r5              # r5 = y[i]
ld $v3, r6                    # r6 = address of v3
st r5, 0x0(r6)                # v3 = y[i]
halt

.pos 0x2000
static:
i:  .long 0x00000001
v0: .long 0x00000002
v1: .long 0x00000003
v2: .long 0x00000004
v3: .long 0x00000005
s:  .long 0x00000006            # x[0]
    .long 0x00000007            # x[1]
    .long s_y                 # s.y (contains the address of y)
    .long s_z                 # s.z

.pos 0x3000
heap:
s_y:        .long 0x0000008     # s.y[0]
            .long 0x0000009     # s.y[1]

s_z:        .long 0x0000000a    # x[0]
            .long 0x0000000b    # x[1]
            .long s_z_y       # s.y (contains the address of y)
            .long s_z_z       # s.z

s_z_y:      .long 0x0000000c    # s_z.y[0]
            .long 0x0000000d    # s_z.y[1]

s_z_z:      .long 0x0000000e    # x[0]
            .long 0x0000000f    # x[1]
            .long s_z_z_y     # s_z_z.y (address of y)
            .long s_z_z_z     # struct pointer address

s_z_z_y:    .long 0x00000010    # s_z_z.y[0]
            .long 0x00000011    # s_z_z.y[1]

s_z_z_z:    .long 0x0000000e    # x[0]
            .long 0x0000000f    # x[1]
            .long 0     # s_z_z.y (address of y)
            .long 0     # struct pointer address
