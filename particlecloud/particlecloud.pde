ArrayList<Particles> particles=new ArrayList<Particles>();

  
void setup(){
size(500,500,P3D);
background(255);

}

void draw(){
  background(255);
  
  translate(250,250);
  PVector pos= new PVector(random(-mouseX+250,mouseX-250),mouseY-random(-50,50),0);
  particles.add(new Particles(pos));
  for (int i = 0; i < particles.size(); i++) {
  Particles part = particles.get(i);
  part.move();
  if(part.isdead==true){
    particles.remove(i);
  }
}
println(particles.size());

}

class Particles{
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
  vel=new PVector(b*cos(a*lifespan)-a*b*lifespan*sin(a*lifespan),b*sin(a*lifespan)+a*b*lifespan*cos(a*lifespan),5);
  sign=1;
  accel=new PVector(0,2*a*b,-0.1);  
  }
  void move(){
    
    r=lifespan*a*sign+10;
    //sphere(1);
    //stroke(123,random(20,80),21);
    //sphere(2);
    randshape2(position,r);
    //translate(position.x,position.y,position.z);
 
     
      PVector av=new PVector(vel.x,vel.y);
      av.rotate(HALF_PI);
      av.setMag((sq(vel.x)+sq(vel.y))/r);
      accel.x=av.x;
      accel.y=av.y;
      
      //println(accel==vel);
      
      
    //accel.x=-2*a*b*sin(a*lifespan)-sq(a)*r*cos(a*lifespan);
    //accel.y=2*a*b*cos(a*lifespan)-sq(a)*r*sin(a*lifespan);
     
   //println(position);
    if(position.z<=0 && vel.z<0){
    isdead=true;
    }
    if(r>=1000){
    sign=-sign;
    }
    vel.add(accel);
    position.add(vel);
    lifespan+=1;
  }


}

void randshape(PVector pos,float r){
 pushMatrix();
 translate(pos.x,pos.y,pos.z);
for(int i=0;i<360;i+=20){
line(0,0,r*cos(i),r/2*sin(i));

}
popMatrix();

}

void randshape2(PVector pos,float r){
 pushMatrix();
 translate(pos.x,pos.y,pos.z);
float ang=random(0,360);

strokeWeight(random(0,10));
strokeCap(SQUARE);
//stroke(255,38,21);
stroke(165,87,0);
line(0,0,r*cos(ang),r/2*sin(ang));
line(0,0,r*cos(ang+90),r/2*sin(ang+90));
line(0,0,r*cos(ang+45),r/2*sin(ang+45));
fill(82,87,0);
stroke(82,87,0);
//strokeWeight(1);
//noFill();
ellipse(0,0,5,5);
ellipse(r*cos(ang),r/2*sin(ang),5,5);

popMatrix();

}
