class Particles{
  //the particles are supposed to spiral upward 
  boolean isdead;
  PVector position;
  PVector accel;
  PVector vel;
  float r;
  int lifespan;
  float sign;
  float a=0.1;//angle's speed
  float b=0.5;//diameter's speed
  
  Particles(PVector pos){
  isdead=false;
  position=pos;
  lifespan=0;
  //the particle has an initial speed firing upward then it will gradually spiral up
  //until lose momentum and fall down
  vel=new PVector(b*cos(a*lifespan)-a*b*lifespan*sin(a*lifespan),b*sin(a*lifespan)+a*b*lifespan*cos(a*lifespan),5);
  sign=1;
  accel=new PVector(0,2*a*b,-0.2);  
  }
  void move(){
    //radius of the trajectory
    r=lifespan*a*sign+10;
    
    //shape of the particle & draw
    randshape2(position,r);
    
    //in circular motion acceleration always perpendicular to speed
      PVector av=new PVector(vel.x,vel.y);
      av.rotate(HALF_PI);
      av.setMag((sq(vel.x)+sq(vel.y))/r);
      accel.x=av.x;
      accel.y=av.y;
    
    //if particle fall below zplane it's dead
    if(position.z<=0 && vel.z<0){
    isdead=true;
    }
    //if radius of particle trajectory too large then shrink
    if(r>=1000){
    sign=-sign;
    }
    //update velocity and position
    vel.add(accel);
    position.add(vel);
    lifespan+=1;
  }


}

void randshape2(PVector pos,float r){
 pushMatrix();
 translate(pos.x,pos.y,pos.z);
float ang=random(0,360);
strokeWeight(random(0,10));
strokeCap(SQUARE);
stroke(165,87,0);
line(0,0,r/2*cos(ang),r/3*sin(ang));

fill(82,87,0);
stroke(82,87,0);

popMatrix();

}
