// F1_1985 suspension
//////////////////////////////////////////////////////////////////////////
//
// Conventions:
//
// +x = left
// +z = rear
// +y = up
// +pitch = nose up
// +yaw = nose right
// +roll = right
//
// [BODY]  - a rigid mass with mass and inertial properties
// [JOINT] - a ball joint constraining an offset of one body to an
//           offset of another body (eliminates 3 DOF)
// [HINGE] - a constraint restricting the relative rotations of two
//           bodies to be around a single axis (eliminates 2 DOF).
// [BAR]   - a constraint holding an offset of one body from an offset of
//           another body at a fixed distance (eliminates 1 DOF).
// [JOINT&HINGE] - both the joint and hinge constraints, forming the
//           conventional definition of a hinge (eliminates 5 DOF).
//
//////////////////////////////////////////////////////////////////////////

// Body including all rigidly attached parts (wings, barge boards, etc.)
[BODY]
name=body mass=(0.0) inertia=(0.0,0.0,0.0)
pos=(0.0,0.0,0.0) ori=(0.0,0.0,0.0)

// Front spindles
[BODY]
name=fl_spindle mass=(8.0) inertia=(0.0350,0.0320,0.0290)
pos=( 0.720,0.0,-1.650) ori=(0.0,0.0,0.0)

[BODY]
name=fr_spindle mass=(8.0) inertia=(0.0350,0.0320,0.0290)
pos=(-0.720,0.0,-1.650) ori=(0.0,0.0,0.0)

// Front wheels
[BODY]
name=fl_wheel mass=(20.0) inertia=(1.300,1.020,1.020)
pos=( 0.87195,0.0,-1.650) ori=(0.0,0.0,0.0)

[BODY]
name=fr_wheel mass=(20.0) inertia=(1.300,1.020,1.020)
pos=(-0.87195,0.0,-1.650) ori=(0.0,0.0,0.0)

// Rear spindles
[BODY]
name=rl_spindle mass=(8.5) inertia=(0.0350,0.0320,0.0290)
pos=( 0.690,0.0,1.35) ori=(0.0,0.0,0.0)

[BODY]
name=rr_spindle mass=(8.5) inertia=(0.0350,0.0320,0.0290)
pos=(-0.690,0.0,1.35) ori=(0.0,0.0,0.0)

// Rear wheels (includes half of rear-axle)
[BODY]
name=rl_wheel mass=(25.0) inertia=(1.600,1.300,1.300)
pos=( 0.86545,0.0,1.35) ori=(0.0,0.0,0.0)

[BODY]
name=rr_wheel mass=(25.0) inertia=(1.600,1.300,1.300)
pos=(-0.86545,0.0,1.35) ori=(0.0,0.0,0.0)

// Fuel in tank is not rigidly attached - it is attached with springs and
// dampers to simulate movement.  Properties are defined in the HDV file.
[BODY]
name=fuel_tank mass=(1.0) inertia=(1.0,1.0,1.0)
pos=(0.0,0.0,0.0) ori=(0.0,0.0,0.0)

// Driver's head is not rigidly attached, and it does NOT affect the vehicle
// physics.  Position is from the eyepoint defined in the VEH file, while
// other properties are defined in the head physics file.
[BODY]
name=driver_head mass=(6.0) inertia=(0.02,0.02,0.02)
pos=(0.0,0.0,0.0) ori=(0.0,0.0,0.0)

//////////////////////////////////////////////////////////////////////////
//
// Constraints
//
//////////////////////////////////////////////////////////////////////////

// Front wheel and spindle connections
[JOINT&HINGE]
posbody=fl_wheel negbody=fl_spindle pos=fl_wheel axis=( 0.790,0.0,0.0)

[JOINT&HINGE]
posbody=fr_wheel negbody=fr_spindle pos=fr_wheel axis=(-0.790,0.0,0.0)

// Front left suspension (2 A-arms + 1 steering arm = 5 links)
[BAR] // forward lower arm
posbody=body negbody=fl_spindle pos=( 0.1526491,-0.1223376,-1.6638247) neg=( 0.7253542,-0.1235136,-1.6658900)

[BAR] // rearward lower arm
name=fl_fore_lower posbody=body negbody=fl_spindle pos=( 0.2055682,-0.1223377,-1.210) neg=( 0.7253542,-0.1235136,-1.6658900)

[BAR] // forward upper arm
name=fl_fore_upper posbody=body negbody=fl_spindle pos=( 0.2407367,0.0861990,-1.73500) neg=( 0.6931796,0.1140356,-1.6517838)

[BAR] // rearward upper arm
posbody=body negbody=fl_spindle pos=( 0.2526078,0.0846359,-1.550) neg=( 0.6931796,0.1140356,-1.6517838)

[BAR] // steering arm (must be named for identification)
name=fl_steering posbody=body negbody=fl_spindle pos=( 0.2456495,0.1071572,-1.5502052) neg=( 0.6984568,0.1363793,-1.5510664)

// Front right suspension (2 A-arms + 1 steering arm = 5 links)
[BAR] // forward lower arm
name=fr_fore_lower posbody=body negbody=fr_spindle pos=(-0.1526491,-0.1223376,-1.6638247) neg=(-0.7253542,-0.1235136,-1.6658900)

[BAR] // rearward lower arm
posbody=body negbody=fr_spindle pos=(-0.2055682,-0.1223377,-1.210) neg=(-0.7253542,-0.1235136,-1.6658900)

[BAR] // forward upper arm (used in steering lock calculation)
name=fr_fore_upper posbody=body negbody=fr_spindle pos=(-0.2407367,0.0861990,-1.73500) neg=(-0.6931796,0.1140356,-1.6517838)

[BAR] // rearward upper arm
posbody=body negbody=fr_spindle pos=(-0.2526078,0.0846359,-1.550) neg=(-0.6931796,0.1140356,-1.6517838)

[BAR] // steering arm (must be named for identification)
name=fr_steering posbody=body negbody=fr_spindle pos=(-0.2456495,0.1071572,-1.5502052) neg=(-0.6984568,0.1363793,-1.5510664)



// Rear left suspension (2 A-arms + 1 straight link = 5 links)
[BAR] // forward lower arm
posbody=body negbody=rl_spindle pos=( 0.1630212,-0.0999895,0.75) neg=( 0.6677337,-0.1199895,1.2712110)

[BAR] // rearward lower arm
posbody=body negbody=rl_spindle pos=( 0.1650605,-0.1199895,1.5149001) neg=( 0.6677337,-0.1199895,1.2712110)

[BAR] // forward upper arm
posbody=body negbody=rl_spindle pos=( 0.2374536,0.0957731,0.75) neg=( 0.6391841,0.1200105,1.2752891)

[BAR] // rearward upper arm
posbody=body negbody=rl_spindle pos=( 0.2945522,0.1090282,1.2763084) neg=( 0.6391841,0.1200105,1.2752891)

[BAR] // straight link
posbody=body negbody=rl_spindle pos=( 0.1344717,-0.1080556,1.5250962) neg=( 0.6820085,-0.1131538,1.52)

// Rear right suspension (2 A-arms + 1 straight link = 5 links)
[BAR] // forward lower arm
posbody=body negbody=rr_spindle pos=(-0.1630212,-0.0999895,0.75) neg=(-0.6677337,-0.1199895,1.2712110)

[BAR] // rearward lower arm
posbody=body negbody=rr_spindle pos=(-0.1650605,-0.1199895,1.5149001) neg=(-0.6677337,-0.1199895,1.2712110)

[BAR] // forward upper arm
posbody=body negbody=rr_spindle pos=(-0.2374536,0.0957731,0.75) neg=(-0.6391841,0.1200105,1.2752891)

[BAR] // rearward upper arm
posbody=body negbody=rr_spindle pos=(-0.2945522,0.1090282,1.2763084) neg=(-0.6391841,0.1200105,1.2752891)

[BAR] // straight link
posbody=body negbody=rr_spindle pos=(-0.1344717,-0.1080556,1.5250962) neg=(-0.6820085,-0.1131538,1.52)

// Rear spindle and wheel connections
[JOINT&HINGE]
posbody=rl_wheel negbody=rl_spindle pos=rl_wheel axis=( 0.820,0.0,0.0)

[JOINT&HINGE]
posbody=rr_wheel negbody=rr_spindle pos=rr_wheel axis=(-0.820,0.0,0.0)


