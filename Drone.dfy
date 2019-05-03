/*
    Handout 2

*/
   
class Drone {
    // r -> radius
    // n -> operation height
    var r:int;
    var n:int;
    var x:int;
    var targetX:int;
    var y:int;
    var targetY:int;
    var z:int;
    var targetZ:int;

    var points:seq<(int, int, int)>;

    var curSpeed:int;
    var maxSpeed:int;
    
     function RepInv():bool
     reads this`x, this`y, this`z, this`r, this`n, this`curSpeed, this`maxSpeed
    {
        //verify speed
        0 <= curSpeed <= maxSpeed && 
        
        0 < r && 0 < n && 
        
       verifyBoundaries(x,y,z)
        
        
    }

    constructor(radius:int, height:int) 
    requires radius > 0 && height > 0
    ensures RepInv()
    {
    
        r := radius;
        n := height;
        x := 0;
        y := 0;
        z := 0;
        curSpeed := 0;
        maxSpeed := 10;
        points := [];
        

        
    }

    


    function method verifyBoundaries(posX:int, posY:int, posZ:int) : bool
    reads this`r, this`n
    {
        //Semisphere
        ( (posX*posX) + (posY*posY) + ((posZ-n)*(posZ-n) ) <= (r*r) && n <= posZ ) 
        
        || 
        
        //Cylinder
        ( (posX*posX) + (posY*posY) <= (r*r) && 0<=posZ<=n )
    }

    function method verifySemisphere(posX:int, posY:int, posZ:int) : bool
    reads this`r, this`n
    {
        (posX*posX)+(posY*posY)+((posZ-n)*(posZ-n))<=(r*r) && n <= posZ
    }

    function method verifyIdle() : bool
    reads this`z, this`curSpeed
    {
        z != 0 && curSpeed == 0
    }
    
    function method verifyMoving():bool
    reads this`z, this`curSpeed, this`maxSpeed
    {
        curSpeed == maxSpeed
    }

    function method verifyLanded():bool
    reads this`z, this`curSpeed
    {
        z == 0 && curSpeed == 0
    }
    
    

    function method verifyPatrolling():bool 
    reads this`x, this`y, this`z, this`r, this`n, this`curSpeed, this`maxSpeed, this`points
    {
        curSpeed == (maxSpeed/2)

        &&

        |points| > 0
    }

    function method verifyPoint():bool
    reads this`points
    {
        points !=[]
    }
    
    method move(toX:int, toY:int, toZ:int)
    modifies this`targetX, this`targetY, this`targetZ, this`curSpeed
    requires RepInv()
    requires verifySemisphere(toX, toY, toZ)
    requires verifyIdle()
    requires z != 0
    ensures RepInv()
    ensures verifySemisphere(targetX, targetY, targetZ)
    ensures verifyMoving()
    ensures targetZ != 0
    {
        
        targetX := toX;
        targetY := toY;
        targetZ := toZ;

        curSpeed := maxSpeed;
    }

    method completeMove()
    modifies this`x, this`y, this`z, this`curSpeed
    requires RepInv()
    requires verifySemisphere(targetX, targetY, targetZ)
    requires targetZ != 0
    requires verifyMoving()
    ensures verifyIdle()
    ensures RepInv()
    ensures verifySemisphere(x,y,z)
    {
       
        x := targetX;
        y := targetY;
        z := targetZ;

         curSpeed := 0;
    }

    

    method takeOff()
    modifies this`curSpeed
    requires RepInv()
    requires verifyLanded()
    ensures verifyMoving()
    ensures RepInv()
    {
        curSpeed := maxSpeed;
    }

    method completeTakeOff()
    modifies this`z, this`curSpeed
    requires RepInv()
    requires verifyMoving()
    ensures verifyIdle()
    ensures RepInv()
    ensures z == n
    {
        z := n;

        curSpeed := 0;
    }

    method Land()
    modifies this`curSpeed
    requires RepInv()
    requires verifyIdle()
    ensures verifyMoving()
    ensures RepInv()
    {
        curSpeed := maxSpeed;
    }

    method completeLand()
    modifies  this`z, this`curSpeed
    requires RepInv()
    requires verifyMoving()
    ensures verifyLanded()
    ensures RepInv()
    {
        z := 0;

        curSpeed := 0;
    }

    method addWaypoint(toX:int, toY:int, toZ:int)
    modifies this`x, this`y, this`z, this`points, this`curSpeed
    requires RepInv()
    requires verifySemisphere(toX, toY, toZ)
    requires points==[] ==> verifyIdle()
    requires points!=[] ==> verifyPatrolling()
    ensures RepInv()
    ensures points==[] ==> verifyIdle()
    ensures verifyPatrolling()
    
    {
        var tuple: (int, int, int) := (toX, toY, toZ);
        points := points + [tuple];

        
        curSpeed:= maxSpeed/2;
        

    }

    

    

    method nextWaypoint()
    modifies this`x, this`y, this`z, this`points, this`curSpeed
    requires points!=[]
    requires verifySemisphere(points[0].0, points[0].1, points[0].2)
    ensures verifySemisphere(x, y, z)
    {
      
        x := points[0].0;
        y :=points[0].1;
        z :=points[0].2;
        points := points[1..];

        if(points==[]){
            curSpeed:=0;
        }
       
    }

    static method Main() {
        var drone := new Drone(5,9);
        if(drone.verifyLanded()){
            drone.takeOff();
        }
        if(drone.verifySemisphere(5,8,3) && drone.verifyIdle() && !drone.verifyPoint()){
            drone.addWaypoint(5,8,3);
        }
        if(drone.verifyPoint() && drone.verifySemisphere(drone.points[0].0, drone.points[0].1, drone.points[0].2)){
            drone.nextWaypoint();
        }
    }

}