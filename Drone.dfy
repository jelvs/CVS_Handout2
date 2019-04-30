/*
    Handout 2

*/

class Point{

    var x:real;
    var y:real;
    var z:real;

    constructor(x:real, y:real, z:real) 
    {
        this.x := x;
        this.y := y;
        this.z := z;
    
    }

    method getX() returns (x:real)
    {
        return x;
    }

    method getY() returns (y:real){
        return y;
    }

    method getZ() returns (z:real){
        return z;
    }

}
   
class Drone {
    // r -> radius
    // n -> operation height
    var r:real;
    
    var n:real;


    var curSpeed:int;

    var curPosition:Point;

    var point:Point;
    var wayPoints:array<Point>;

    constructor() 
    {
    
        this.r := 0.0;
        this.n := 0.0;
        this.curSpeed := 0;
        this.wayPoints := new array<Point>;
        this.curPosition := new Point(0.0,0.0,0.0);

        
    }

    function RepInv():bool
    reads this`r ,this`n, 
    {

    }
    
    function Moving():bool

    function Landed():bool
    ensures point.z==0.0
    {
       
    }
    
    

    function Patrolling():bool 
    
    function Hovering():bool 

    method move()
    {

    }

    method completeMove()
    {

    }

    method addWaypoint()
    {

    }

    method nextWayPoint()
    {

    }

    method takeOff()
    {

    }

    method completeTakeOff()
    {

    }

    method land()
    {

    }

    method completeLand()
    {

    }

}