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



    constructor(r:int, n:int) 
    requires r > 0 && n > 0
    ensures RepInv()
    {
    
        this.r := r;
        this.n := n;
        this.x := 0;
        this.y := 0;
        this.z := 0;
        this.curSpeed := 0;
        this.maxSpeed := 10;
        this.points := [];
        

        
    }

    function RepInv():bool
     reads this`x, this`y, this`z, this`r, this`n, this`curSpeed, this`maxSpeed
    {
        //verify speed
        0 <= curSpeed <= maxSpeed 

        && 
        
        0 <= r && 0 <= n

        &&

        verifyBoundaries(x,y,z)
        
        
    }

    function verifyBoundaries(x:int, y:int, z:int) : bool
    reads this`r, this`n
    {
        //Semisphere
        ( (x*y)+(y*y)+( (z-n)*(z-n) ) <= (r*r) && n <= z) 
        
        || 
        
        //Cylinder
        ((x*x)+(y*y) <= (r*r) && 0<=z<=n)
    }

    function verifySemisphere(x:int, y:int, z:int) : bool
    reads this`r, this`n
    {
        (x*x)+(y*y)+((z-n)*(z-n)) <= (r*r) && n <= z
    }

    function verifyIdle() : bool
    reads this`z, this`curSpeed
    {
        z != 0 && curSpeed == 0
    }
    
    function verifyMoving():bool
    reads this`z, this`curSpeed, this`maxSpeed
    {
        curSpeed == maxSpeed
    }

    function verifyLanded():bool
    reads this`z, this`curSpeed
    {
        z == 0 && curSpeed == 0
    }
    
    

    function verifyPatrolling():bool 
    reads this`x, this`y, this`z, this`r, this`n, this`curSpeed, this`maxSpeed
    {
        curSpeed == (maxSpeed/2)

        &&

        verifySemisphere(x,y,z)
    }
    

/*
    method getX() returns (x:int)
    {
        return x;
    }

    method getY() returns (y:int){
        return y;
    }

    method getZ() returns (z:int){
        return z;
    }
*/

    method move(x:int, y:int, z:int)
    modifies this`targetX, this`targetY, this`targetZ, this`curSpeed
    requires RepInv()
    requires verifyIdle()
    ensures RepInv()
    ensures verifyMoving()
    {
        targetX := x;
        targetY := y;
        targetZ := z;
        curSpeed := maxSpeed;


    }

    method completeMove()
    requires RepInv()
    ensures RepInv()
    {

    }

    method addWaypoint()
    requires RepInv()
    ensures RepInv()
    {

    }

    method nextWayPoint()
    requires RepInv()
    ensures RepInv()
    {

    }

    method takeOff()
    requires RepInv()
    ensures RepInv()
    {

    }

    method completeTakeOff()
    requires RepInv()
    ensures RepInv()
    {

    }

    method land()
    requires RepInv()
    ensures RepInv()
    {

    }

    method completeLand()
    requires RepInv()
    ensures RepInv()
    {

    }

}