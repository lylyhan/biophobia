void pixelchange(){
  
//static pixel changes, in this case lines on top of sketch
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

void pixelchange2(){
  
//moving pixel change
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
