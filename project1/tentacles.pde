class tentacles{
    
    float[][] tentx,tenty;
    int x,y;
    //construct arrays that store coordinates of the tentacles
    tentacles(int sizex,int sizey){
      x=sizex;
      y=sizey;
      tentx=new float[width/x][height/y];
      tenty=new float[width/x][height/y];
      
      for(int i=0;i<width/x;i+=1){
        for(int j=0;j<height/y;j+=1){
          //store the random x,y coords in each grid
          tentx[i][j]=(random(i*x,(i+1)*x));
          tenty[i][j]=(random(j*y,(j+1)*y));
        }
      }
   
    }
 //draw tentacles
  void draw3dtent(float innerx,int diameter,float tall){
    /*
    this function is supposed to draw an organic tube-like structure encircled by a lower volcano-like structure at any location
    specified.
    adjustable parameters include diameters of both the center tube and surrounding volcano, and how tall the structure is
    */
    
    for(int i=0;i<width/x;i+=2){
        for(int j=0;j<height/y;j+=1){
          float tall2=tall;
          //store scales of random x,y coord in each grid
          if(i<width/x-1){
            //you brought me the light
             if(abs(sq(i-20)+sq(j-20)-sq(mouseX/x-20)-sq(mouseY/y-20))<2){
                    if(mousePressed==true){
                    //println("yat");
                    
                    tall2=tall*2;
                  }
              
                
                
                }
            beginShape();
              for(int k=0;k<360;k+=10){
                //extend the height of a specific tube
               
                //draw the volcano
                generate_arc(innerx*cos(k)+tentx[i][j],innerx/2*sin(k)+tenty[i][j],(innerx+diameter)*cos(k)+tentx[i][j],(innerx+diameter)*sin(k)+tenty[i][j],40,-1,tall2,0,0);
                //draw the tube
                generate_arc(innerx*cos(k)+tentx[i][j],innerx/2*sin(k)+tenty[i][j],innerx*cos(k+180)+tentx[i][j],innerx/2*sin(k+180)+tenty[i][j],0,1,2*tall2,0,0);
             }
            endShape();
          
          }
        }
      }
  }
  //grow scales
  void scales(float density, float hosttall,float hostdiam,float scalesize){
    /*
    this function is still under development... doesn't seem to create much interesting pattern
    */
    for(int i=0;i<width/x;i+=2){
        for(int j=0;j<height/y;j+=1){
          //store scales of random x,y coord in each grid
          if(i<width/x-1){
            beginShape();
              for(int k=0;k<360;k+=10){
              float a=hostdiam*cos(degrees(k))+tentx[i][j];
              float b=hostdiam*sin(degrees(k))+tenty[i][j];
              float px=hostdiam*cos(degrees(k-density))+tentx[i][j];
              float py=hostdiam*sin(degrees(k-density))+tenty[i][j];
              generate_arc(px,py,a,b,10,-1,scalesize,hosttall/5,hosttall/5); 
              }
            endShape();
          
          }
        }
      }
  
  }
  void bleed(float innerx,float tall,float angle){
    /*
    this function is supposed to draw temporal flare-like structures by using generate_arc
    originating from each core, it spreads inside-out of its host
    parameters include how spread-out(innerx), how tall(tall), and how distorted(angle) the flare is.
    */
    beginShape();
    for(int i=0;i<width/x;i+=2){
        for(int j=0;j<height/y;j+=1){
          for(int k=0;k<360;k+=10){
            if (random(0,1)<0.5){
              generate_arc(tentx[i][j],tenty[i][j],(innerx)*cos(k)+tentx[i][j],(innerx)*sin(k)+tenty[i][j],angle,1,tall,0,tall+20);
            }
            }
    endShape();
        }
    }

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
}
