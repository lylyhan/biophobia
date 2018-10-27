/*
tentacles lean towards me
as if they knew
their misfortune is mine
their ecstacy too
we are of the same blood
*/
int[][] toggle;
int gridsize=30;
tentacles t;
float tributex=0;
int count=0;
float tall=80;
float var;
float angle;
ArrayList<Particles> particles=new ArrayList<Particles>();


void setup(){
size(700,700,P3D);
background(0);
toggle=new int[width/gridsize][height/gridsize];
t=new tentacles(gridsize,gridsize-10);
}

void draw(){
background(0);
tributex=5*sin(frameCount/5);
stroke(128,107,67,100);
strokeWeight(1);
tall=70;
//tall=sqrt(sq(mouseX)+sq(mouseY))/width*2*160;
var=20+10*mouseX/float(width);
angle=40+mouseX/float(width);
//draw the tentacles with mouse-dependent heights
t.draw3dtent(var,30,tall);
if(key=='a'){
//second layer: pulsing cores, pulse implemented by a sinusoid function
strokeWeight(1);
stroke(56,35,7,120);
t.draw3dtent(var/2,0,tall+20*sin(frameCount));
//t.draw3dtent(var*2,0,tall/2);
if(tall>130){
//third layer: blue flames
strokeWeight(2);
stroke(12,25,38,100);
t.bleed(var,tall,random(40,80));
if(tall>160){
//fourth layer: green flames
strokeWeight(2);
stroke(9,48,0,100);
t.bleed(var,tall,random(40,80));
}

}
}
//t.scales(10,tall,20,tall/3);
//rotateX(PI/8);
if(keyPressed==true){
  PVector pos= new PVector(mouseX+noise(20),mouseY+noise(20),0);
keyPressed(pos);
}
loadPixels();
//println("ss",pixels.length);
for (int x = 0; x<width; x+=1) {
  for(int y = 0; y<height; y+=1){
    int loc=(x+(y*width));
    if(x>1){
      if(x%gridsize==2){
       //pixels[loc]=img.pixels[loc];
    pixels[loc]=(pixels[loc-1]+pixels[loc])*2;
      }
    }
    
}
}
updatePixels();



}

void keyPressed(PVector pos){
//draw the particle cloud

  particles.add(new Particles(pos));
  for (int i = 0; i < particles.size(); i++) {
  Particles part = particles.get(i);
  part.move();
  if(part.isdead==true){
    particles.remove(i);
  }
}

}

 
