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
  void vanish(){
  //lantern(position);
  randshape3(position,10);
  //lantern(position);
  vel=new PVector(0,0,5);
  accel=new PVector(0,0.5);
  vel.add(accel);
  position.add(vel);
  if(position.z>300){
  isdead=true;
  }
  }
  
  void vanish2(){
  lantern(position);
  vel=new PVector(0,0,10);
  accel=new PVector(0,1);
  vel.add(accel);
  position.add(vel);
  println("position",position.z);
  if(position.z>100){
  isdead=true;
  }
  }

}

void randshape2(PVector pos,float r){
 pushMatrix();
 translate(pos.x,pos.y,pos.z);
float ang=random(0,360);
strokeWeight(random(0,10));
strokeCap(SQUARE);
//stroke(104,80,0);
//stroke(random(0,255),random(0,255),random(0,255),100);
stroke(41,26,21);
line(0,0,r*cos(ang),r/2*sin(ang));



popMatrix();

}

void randshape3(PVector pos,float r){
 pushMatrix();
 translate(pos.x,pos.y,pos.z);
strokeWeight(1);
strokeCap(SQUARE);
//stroke(104,80,0);
//stroke(random(0,255),random(0,255),random(0,255));
stroke(255);
ellipse(pos.x,pos.y,r/3,r/2);
ellipse(pos.x,pos.y,r/6,r/4);
line(pos.x,pos.y,pos.z,pos.x,pos.y,pos.z+10);


popMatrix();

}



void lantern(PVector pos){
  
translate(pos.x,pos.y,pos.z);
rotateY(HALF_PI*3/4);

float ang=30;
//stroke(random(0,255),random(0,255),random(0,255));
stroke(255,255,255,0);
beginShape();
for(int k=0;k<360;k+=10){
  pushMatrix();
  rotateX(k*PI/180);
  
  generate_arc(0,0,60,0,ang,1,48,0,0);
popMatrix();
}
endShape();
//rotateX(PI);

}

void generate_arc(float px,float py, float x, float y, float angle,int sign,float tall,float platform,float platform2){
      /*
      the function is supposed to create an arc given start and end coordinates,
      the angle of arc's midpoint with respect to the straight line between start/end
      coordinates(how curvy), and if the arc is concave or convex, indicated by sign.
      
      update: this is a new version accomodated to 3d environment, added start/end point's z position
      */
      noFill();
      beginShape();
      vertex(px,py,platform);
      //calculate distance between start coordinate to midpoint of the arc of intended curviness
      float controlr=sqrt(sq(py-y)+sq(px-x))/(2*cos(radians(angle)));
      //calculate the angle of midpoint with respect to x axis
      float alpha=atan2((y-py),(x-px))+sign*radians(angle);
      //express coordinate of the midpoint in terms of the above variables
      float controlptx=px+controlr*cos(alpha);
      float controlpty=py+controlr*sin(alpha);
      quadraticVertex(controlptx,controlpty,tall,x,y,platform2);
      endShape();
     

      }
