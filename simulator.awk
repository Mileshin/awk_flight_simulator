

BEGIN {
    #screen width and height
    w=64
    h=48
    #default color mode, change at runtime by pressing 1-4
    #1 = no color, chars only, fast drawing
    #2 = colored chars
    #3 = background color only
    #4 = background color with char textures
    colormode = 4


    #INITIALIZATION
    buffer[w,h]

    moveSpeed = 0
	rotSpeed = 0.3
    fuel = 1001   
    #key bindings
    exit_key = "q"
    #key moving
    movf_key = "w"
    movb_key = "s"
    movl_key = "a"
    movr_key = "d"
    movup_key = "k"
    movdown_key = "j"
    rotl_key = "h"
    rotr_key = "l"

	#initial player direction vector
	dirX = -1
	dirY = 0

	#camera plane perpendicular to direction vector
	planeX = -0.66
	planeY = 0.0

	#LEVEL DESIGN
	mapWidth=66
	mapHeight=64
	map =\
	"555559955555555555555555555555555555555555555555555555555555555555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"999999999999999999999999999999999999999999999999999999999999999999"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555........55555555..............1...........555559955555"\
	"555559955555..........5555................1...........555559955555"\
	"555559955555...........55.................1...........555559955555"\
	"555559955555...........55................313..........555559955555"\
	"555559955555....mmm....55.............................555559955555"\
	"555559955555....mMm....55.............................555559955555"\
	"555559955555....mmm....55......mmm....mmm....mmm......555559955555"\
	"555559955555...........55......mMm....mMm....mMm......555559955555"\
	"555559955555....mmm....55......mmm....mmm....mmm......555559955555"\
	"555559955555....mMm....55.............................555559955555"\
	"555559955555....mmm....55.............................555559955555"\
	"555559955555...........5555.......mmm.....mmm.........555559955555"\
	"555559955555...........5..55......mMm.....mMm.........555559955555"\
	"555559955555...........5...55.....mmm.....mmm.........555559955555"\
	"555559955555....mmm....5....555.......................555559955555"\
	"555559955555....mMm....5......55......................555559955555"\
	"555559955555....mmm....5.......55............mmm......555559955555"\
	"555559955555...........55.......55...........mMm......555559955555"\
	"555559955555............55.......5...........mmm......555559955555"\
	"555559955555.............55......5......mmm...........555559955555"\
	"555559955555..............55....55......mMm....mmm....555559955555"\
	"555559955555...............55..55.......mmm....mMm....555559955555"\
	"555559955555................5..555.............mmm....555559955555"\
	"555559955555....mmm.........555555....................555559955555"\
	"555559955555....mMm..........5555.....................555559955555"\
	"555559955555....mmm..........5555......555555.........555559955555"\
	"555559955555.................5555.....555555555555....555559955555"\
	"555559955555.................555......5555555555555555555559955555"\
	"555559955555....555555555555555........555555555555555555559955555"\
	"555559955555....5.......................55555555555...555559955555"\
	"555559955555....5.....................................555559955555"\
	"555559955555....5......1111..1111..1111..1111.........555559955555"\
	"555559955555....5.........1..1..1..1..1.....1.........555559955555"\
	"555559955555....5......1111..1111..1111....1..........555559955555"\
	"555559955555....5......1........1..1..1...1...........555559955555"\
	"555559955555....5......1111..1111..1111..1............555559955555"\
	"555559955555....5.....................................555559955555"\
	"555559955555....5.....................................555559955555"\
	"555559955555....5...............................1.....555559955555"\
	"555559955555....5...............................1.....555559955555"\
	"555559955555....5...............................1.....555559955555"\
	"555559955555....................................1.....555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"555559955555555555555555555555555555555555555555555555555559955555"\
	"999999999999999999999999999999999999999999999999999999999999999999"\
	"555555555555555555555555555555555555555555555555555555555555555555"\
	"555555555555555555555555555555555555555555555555555555555555555555"\
	"555555555555555555555555555555555555555555555555555555555555555555"\
	"555555555555555555555555555555555555555555555555555555555555555555"\
	"555555555555555555555555555555555555555555555555555555555555555555"

	ceilingTex = ".."
	ceilingColor = 7
	ceilingIsBright = 1

	floorTex = "__"
	floorColor = 3
	floorIsBright = 0


	#initial player position
	posX = 48
	posY = 48
    winX =14
    winY=42
    Background();
    rise(w/2,(w/2)%2,h/2);
    speedometer();
    fuel_meter();
    redraw();
    system("stty -echo")
    while(moveSpeed == 0){
    cmd = "bash -c 'read -n 1 input; echo $input'"
    cmd | getline input
    close(cmd)
    if(input==movup_key){
        moveSpeed = 25/3/150
        takeoff();
        moveSpeed = 1
    }
    if(input==exit_key){
        result=3}
    }
    system("stty echo")
	#ENTERING MAIN LOOP
    if(moveSpeed != 0)
	result = main()

	#EXITING
	print "\n"
	if(result == 0)
	  print "YOU WIN!"
	else if (result == 1)
	  print "YOU CRASHED!"
	else if (result == 2)
      print "RUN OUT OF FUEL"
    else 
	  print "You quit."
}

function takeoff(){
    for(i=w/2;i>21;i-=2){
        Background();
        if(int(i)%2==1) 
        rise(i,1,h/2);
        else 
        rise(i,2,h/2);
        speedometer();
        fuel_meter();
        moveSpeed+=25/3/150;
        redraw();
        system("sleep 1")
    }
    for(j=h/2;j<h-2;j+=2){
        Background();
        rise(i+1,int((j+1))%2,j);
        speedometer();
        fuel_meter();
        redraw();
        moveSpeed+=25/3/150;
        system("sleep 1")
    }
}
function worldMap(y, x) {
  y = int(y)
  x = int(x)
  tile = substr(map, mapWidth*y+x+1, 1)
  if (tile == ".") 
    return 0
  return tile
}

function abs(x) {
  if(x<0)
    return -x
  return x
}

function Background(){
  for(x = 0; x < w; x++){
    for(y = 0; y < h/2 +4; y++){
      buffer[x,y] = getPixel(ceilingColor, ceilingIsBright, colormode, ceilingTex);
    }
    for(y = int(h/2)+4; y < h; y++){
      buffer[x,y] = getPixel(floorColor, floorIsBright, colormode, floorTex);
    }
  }
}

function redraw(){
  printf "\033[H"
  for(y = 0; y < h; y++){
    str = ""
    for(x = 0; x < w; x++){
      str = str buffer[x,y]
    }
 #   str = str "\n"
    print str
  }
#printf str
  printf "\033[J"
}

function getCode(color, isBright, isBG){
  if(color == 0)
    color = 10
  else if (isBright==1)
    color+=60
  if(isBG==1)
    color+=10
  color+=30-1
  return color
}

function buildPixel(bg_color, fg_color, text){
  pixel = "\033[" bg_color ";" fg_color "m" text "\033[0m";
  return pixel;
}

function getPixel(basecolor, isBright, colormode, tex){
  color = "??";

  if (colormode==1) {
    color = tex;
  }
  else if (colormode==2) {
    fg_color = getCode(basecolor, isBright, 0);
    bg_color = getCode(0, isBright, 1);
    color = buildPixel(bg_color, fg_color, tex);
  }
  else if (colormode==3) {
    tex = "  ";
    fg_color = getCode(0, isBright, 0);
    bg_color = getCode(basecolor, isBright, 1);
    color = buildPixel(bg_color, fg_color, tex);
  }
  else if (colormode==4){
    bg_color = getCode(basecolor, isBright, 1);
    if (isBright == 0)
      isBright = 1;
    else
      isBright = 0;
    fg_color = getCode(basecolor, isBright, 0);
    color = buildPixel(bg_color, fg_color, tex);
  }
  return color;
}
function draw_surface(right_border,left_border,delta_left,delta_right,delta1,delta2,color,bright,nh,delta_nh)
{
    if((color=="m") || (color=="M")) return 0
    if(color==9) color = 5 
    if(color == 5) surface="AA"
    if(color == 1) surface="NN"
    if(color == 3) surface="^^"
    for(y=nh;y>(nh-delta_nh);y-=2){
       delta_left+=1; delta_right+=1;
       for(x=left_board+delta_left;x<right_board-delta_right;x++){
            cx=int(x); cy=int(y);
            buffer[cx,cy] = getPixel(color,bright,colormode,surface)
       }
       for(x=left_board+delta_left+delta1;x<right_board-delta_right-delta2;x++){
            cx=int(x); cy=int(y);
            buffer[cx,cy-1] = getPixel(color,bright,colormode,surface)
       }
       delta_left+=delta1; delta_right+=delta2;
    }
}
function draw_surface_right(right_border,left_border,delta_left,delta_right,delta1,delta2,color,bright,nh,delta_nh)
{
    if((color=="m") || (color=="M"))  return 0
    if(color==9) color = 5 
    if(color == 5) surface="AA"
    if(color == 1) surface="NN"
    if(color == 3) surface="<<"
    for(y=nh;y>(nh-delta_nh);y-=2){
       delta_left+=1; delta_right+=1;
       for(x=left_board-delta_left;x<right_board-delta_right;x++){
            cx=int(x); cy=int(y);
            buffer[cx,cy] = getPixel(color,bright,colormode,surface)
       }
       for(x=left_board-delta_left-delta1;x<right_board-delta_right-delta2;x++){
            cx=int(x); cy=int(y);
            buffer[cx,cy-1] = getPixel(color,bright,colormode,surface)
       }
       delta_left+=delta1; delta_right+=delta2;
    }
}
function draw_surface_left(right_border,left_border,delta_left,delta_right,delta1,delta2,color,bright,nh,delta_nh)
{
    if((color=="m") || (color=="M"))  return 0
    if(color==9) color = 5 
    if(color == 5) surface="AA"
    if(color == 1) surface="NN"
    if(color == 3) surface=">>"
    for(y=nh;y>(nh-delta_nh);y-=2){
       delta_left+=1; delta_right+=1;
       for(x=left_board+delta_left;x<right_board+delta_right;x++){
            cx=int(x); cy=int(y);
            buffer[cx,cy] = getPixel(color,bright,colormode,surface)
       }
       for(x=left_board+delta_left+delta1;x<right_board+delta_right+delta2;x++){
            cx=int(x); cy=int(y);
            buffer[cx,cy-1] = getPixel(color,bright,colormode,surface)
       }
       delta_left+=delta1; delta_right+=delta2;
    }
}
function mini_map(mw,mh){
   for(i=-mw;i<=mw;i++){
    for(j=-mw;j<=mw;j++){
        surface = worldMap(posX-DposY*i-DposX*j,posY-DposX*i-DposY*j);
        
        if(surface==9) surface = 5;
        else if(surface==5) text="aa"
        else if(surface==1) text="nn"
        else if(surface=="m") {text="mm"; surface=4 }
        else if(surface=="M") {text="mm"; surface=8 }
       else { surface = 3;  text=".."} 
     if(DposY!=0)
        buffer[mw-i,mh+j]= getPixel(surface,1,colormode,text);
        else
        buffer[mw-i,mh-j]= getPixel(surface,1,colormode,text);
    }
   }
     surface = worldMap(posX,posY);
     buffer[mw,mh] = getPixel(2,1,colormode,"/\\");
    # border minimap
    for(i=-mw;i<=mw;i++){
     buffer[mw+i,mh-mw] = getPixel(8,1,colormode,"  ");
     buffer[mw+i,mh+mw] = getPixel(8,1,colormode,"  ");
     buffer[mw-mw,mh+i] = getPixel(8,1,colormode,"  ");
     buffer[mw+mw,mh+i] = getPixel(8,1,colormode,"  ");
    }
     buffer[mw-1,mh-mw] = getPixel(8,1,colormode,"MI");
     buffer[mw,mh-mw] = getPixel(8,1,colormode,"NI");
     buffer[mw+1,mh-mw] = getPixel(8,1,colormode,"MA");
     buffer[mw+2,mh-mw] = getPixel(8,1,colormode,"P ");
    }
function    psevdo_raund(x,y,color)
    {
     buffer[x,y] = getPixel(color,1,colormode,"  ");
     buffer[x+1,y+1] = getPixel(color,1,colormode,"  ");
     buffer[x-1,y+1] = getPixel(color,1,colormode,"  ");
     buffer[x-2,y+2] = getPixel(color,1,colormode,"  ");
     buffer[x+2,y+2] = getPixel(color,1,colormode,"  ");
     buffer[x-2,y+3] = getPixel(color,1,colormode,"  ");
     buffer[x+2,y+3] = getPixel(color,1,colormode,"  "); 
     buffer[x+1,y+4] = getPixel(color,1,colormode,"  ");
     buffer[x-1,y+4] = getPixel(color,1,colormode,"  ");
     buffer[x,y+5] = getPixel(color,1,colormode,"  ");
     buffer[x,y+1] = getPixel(1,1,colormode,"  ");
     buffer[x,y+4] = getPixel(1,1,colormode,"  ");
     }
function mountain(nh,nw,x,y,up){
    nh=nw;
    while(nw != 0){
    j=y-(nh-nw);
        for(i=x-nw;i<x+nw;i++){
            if(j-up>y-nh){
                buffer[i,j]=getPixel(4,0,colormode,"MM");
            } else
                buffer[i,j]=getPixel(8,1,colormode,"MM");
        }
        nw--;
    }
}
function rise(nw,fire,nh){
delta=0;
for(y=h;y>nh+3;y--){
   for(x=((w/2)-nw+delta);x<w/2+nw-delta;x++){
       buffer[x,y]=getPixel(1,1,colormode,"NN");
   }
       if((fire==1)&&(x>=w/2+nw-delta)){
            if(y%2==0){ 
                buffer[x-1,y]=getPixel(4,1,colormode,"FF");
                buffer[(w/2)-nw+delta,y]=getPixel(4,1,colormode,"FF");
       }
       }
       else{
        if(((y%2) == 1)&&(x>=w/2+nw-delta)){
            buffer[x-1,y]=getPixel(4,1,colormode,"FF"); 
                buffer[(w/2)-nw+delta,y]=getPixel(4,1,colormode,"FF");
       }
       }
    delta++;
}
}
function fuel_meter(){
    psevdo_raund(w-4,int(h/2)+8,4);
    buffer[w-4,int(h/2)+8+2] = getPixel(1,1,colormode,"UE");
    buffer[w-3,int(h/2)+8+2] = getPixel(1,1,colormode,"L ");
    buffer[w-5,int(h/2)+8+2] = getPixel(1,1,colormode," F");
    str=fuel;
    if(length(fuel)==3)
        str="0" str
    if(length(fuel)==2)
        str="00" str
    if(length(fuel)==1)
        str="000" str
    buffer[w-5,int(h/2)+8+3] = getPixel(1,1,colormode," " substr(str,1,1));
    buffer[w-4,int(h/2)+8+3] = getPixel(1,1,colormode,substr(str,2,2));
    buffer[w-3,int(h/2)+8+3] = getPixel(1,1,colormode,substr(str,4,1) " ");
}
function speedometer(){
    psevdo_raund(w-4,int(h/2),2);
    buffer[w-4,int(h/2)+2] = getPixel(1,1,colormode,"EE");
    buffer[w-3,int(h/2)+2] = getPixel(1,1,colormode,"D ");
    buffer[w-5,int(h/2)+2] = getPixel(1,1,colormode,"SP");
    mes=int(moveSpeed*150)
    if(length(mes)==2)
        mes="0" mes
    if(length(mes)==1)
        mes="00" mes
    buffer[w-5,int(h/2)+3] = getPixel(1,1,colormode,substr(mes,1,2));
    buffer[w-4,int(h/2)+3] = getPixel(1,1,colormode, substr(mes,3,1) "k");
    buffer[w-3,int(h/2)+3] = getPixel(1,1,colormode,"mh");
}
function main()
{
 while (1) {
    if(fuel > 0)
        fuel--;
    else return 2;
    Background();
    #EARTH SURFACE   
    {
    DposX=-dirX; DposY=dirY;
    left_board=22; right_board=42;
    delta=-1; a=7; b=0;
     for(k=0;k<4;k++){
        surface = worldMap(posX-k*DposX,posY+k*DposY);
        if(surface != 0) {
            draw_surface(right_border,left_border,delta,delta,0,0,surface,1,h-1-b,a);
        }
        delta=delta+4-k;
        b=b+(4-k)*2;
        a-=2;
    }
#BAD CODE. HERE DEPLOED CYCLES
    #surface -1;0
    left_board=0; right_board=22
     surface = worldMap(posX - 1*DposY,posY - 1*DposX);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,-1,-1,2,0,surface,1,h-1,7);
     }

     #surface -1;1
     surface = worldMap(posX-1*DposY-1*DposX,posY-1*DposX+1*DposY);
     if(surface != 0) {
        draw_surface_left(right_border,left_border,11,3,2,0,surface,1,h-1-8,5);
     }
     #surface -1;2
     surface = worldMap(posX-1*DposY-2*DposX,posY-1*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,20,6,2,0,surface,1,h-1-14,3);
     }
    #surface -1;3
     surface = worldMap(posX-1*DposY-3*DposX,posY-1*DposX+3*DposY);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,27,8,2,0,surface,1,h-1-18,1);
     }

    #surface 1;0
    left_board=42; right_board=64
     surface = worldMap(posX + 1*DposY,posY + 1*DposX);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,-1,-1,0,2,surface,1,h-1,7);
     }
    #surface 1;1
     surface = worldMap(posX+1*DposY-1*DposX,posY+1*DposX+1*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,3,11,0,2,surface,1,h-1-8,5);
     }
     #surface 1;2
     surface = worldMap(posX+1*DposY-2*DposX,posY+1*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,6,20,0,2,surface,1,h-1-14,3);
     }
    #surface 1;3
     surface = worldMap(posX+1*DposY-3*DposX,posY+1*DposX+3*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,8,27,0,2,surface,1,h-1-18,1);
     }

    #surface -2;0
    left_board=-3; right_board=0
     surface = worldMap(posX - 2*DposY,posY - 2*DposX);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,-1,-1,0,2,surface,1,h-1,7);
     }
    #surface -2;1
     surface = worldMap(posX-2*DposY-1*DposX,posY-2*DposX+1*DposY);
     if(surface != 0) {
        draw_surface_left(right_border,left_border,3,11,3,2,surface,1,h-1-8,5);
     }

     #surface -2;2
     surface = worldMap(posX-2*DposY-2*DposX,posY-2*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,16,20,3,2,surface,1,h-1-14,3);
     }
    #surface -2;3
     surface = worldMap(posX-2*DposY-3*DposX,posY-2*DposX+3*DposY);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,27,27,2,2,surface,1,h-1-18,1);
     }
    #surface -3;1
    left_board=-3; right_board=0
     surface = worldMap(posX-3*DposY-1*DposX,posY-3*DposX+1*DposY);
     if(surface != 0) {
        draw_surface_left(right_border,left_border,0,0,0,3,surface,1,h-1-8,5);
     }
     #surface -3;2
     surface = worldMap(posX-3*DposY-2*DposX,posY-3*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,5,13,4,3,surface,1,h-1-14,3);
     }
   #surface -3; 3
    surface = worldMap(posX-3*DposY-3*DposX,posY-3*DposX+3*DposY);
    if(surface != 0) { 
       draw_surface_left(right_border,left_border,20,24,4,2,surface,1,h-1-18,1);
    }

     #surface -4;2
     surface = worldMap(posX-4*DposY-2*DposX,posY-4*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_left(right_border,left_border,0,2,0,4,surface,1,h-1-14,3);
     }
  #surface -4; 3
   surface = worldMap(posX-4*DposY-3*DposX,posY-4*DposX+3*DposY);
   if(surface != 0) { 
      draw_surface_left(right_border,left_border,8,17,6,4,surface,1,h-1-18,1);
   }
  #surface -5; 3
   surface = worldMap(posX-5*DposY-3*DposX,posY-5*DposX+3*DposY);
   if(surface != 0) { 
      draw_surface_left(right_border,left_border,0, 5,0,6,surface,1,h-1-18,1);
   }
    #surface 2;0
    left_board=w; right_board=w+3
     surface = worldMap(posX + 2*DposY,posY + 2*DposX);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,-1,-1,2,0,surface,1,h-1,7);
     }
    #surface -2;1
     surface = worldMap(posX+2*DposY-1*DposX,posY+2*DposX+1*DposY);
     if(surface != 0) {
        draw_surface_right(right_border,left_border,11,3,2,3,surface,1,h-1-8,5);
     }

     #surface -2;2
     surface = worldMap(posX+2*DposY-2*DposX,posY+2*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,20,16,2,3,surface,1,h-1-14,3);
     }
    #surface -2;-3
     surface = worldMap(posX+2*DposY-3*DposX,posY+2*DposX+3*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,27,27,2,2,surface,1,h-1-18,1);
     }
    #surface -3;1
    left_board=w; right_board=w+3
     surface = worldMap(posX+3*DposY-1*DposX,posY+3*DposX+1*DposY);
     if(surface != 0) {
        draw_surface_right(right_border,left_border,0,0,3,0,surface,1,h-1-8,5);
     }
     #surface -3;2
     surface = worldMap(posX+3*DposY-2*DposX,posY+3*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,13,5,3,4,surface,1,h-1-14,3);
     }
   #surface -3; 3
    surface = worldMap(posX+3*DposY-3*DposX,posY+3*DposX+3*DposY);
    if(surface != 0) { 
       draw_surface_right(right_border,left_border,24,20,2,4,surface,1,h-1-18,1);
    }
     #surface  4;2
     surface = worldMap(posX+4*DposY-2*DposX,posY+4*DposX+2*DposY);
     if(surface != 0) { 
        draw_surface_right(right_border,left_border,2,0,4,0,surface,1,h-1-14,3);
     }
  #surface  4; 3
   surface = worldMap(posX+4*DposY-3*DposX,posY+4*DposX+3*DposY);
   if(surface != 0) { 
      draw_surface_right(right_border,left_border,17,8,6,4,surface,1,h-1-18,1);
   }
  #surface 5; 3
   surface = worldMap(posX+5*DposY-3*DposX,posY+5*DposX+3*DposY);
   if(surface != 0) { 
      draw_surface_right(right_border,left_border,5, 0,6,0,surface,1,h-1-18,1);
   }
   }
   #MOUNTAIN
   {    #center     
        surface = worldMap(posX-6*DposX,posY+6*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/32),int(w/2),h-20,1);
        surface = worldMap(posX-5*DposX,posY+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),int(w/2),h-18,2);
        surface = worldMap(posX-4*DposX,posY+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),int(w/2),h-15,3);
        surface = worldMap(posX-3*DposX,posY+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),int(w/2),h-7,5);
        surface = worldMap(posX-2*DposX,posY+2*DposY);
        if(surface == "M")
            mountain(5,int(w/2)+15,int(w/2),h,7);


        #left
    surface = worldMap(posX-1*DposY-6*DposX,posY-1*DposX+6*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/32),int(w/2)/32+18,h-20,1);
    surface = worldMap(posX-1*DposY-5*DposX,posY-1*DposX+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),int(w/2)/16+14,h-18,2);
    surface = worldMap(posX-1*DposY-4*DposX,posY-1*DposX+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),int(w/2)/8+10,h-15,3);
    surface = worldMap(posX-1*DposY-3*DposX,posY-1*DposX+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),int(w/2)/4+6,h-7,5);
     surface = worldMap(posX-1*DposY-2*DposX,posY-1*DposX+2*DposY);
        if(surface == "M")
            mountain(5,int(w/2)+15,2,h,7);
        #right
    surface = worldMap(posX+1*DposY-6*DposX,posY+1*DposX+6*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/32),w-(int(w/2)/32+18),h-20,1);
    surface = worldMap(posX+1*DposY-5*DposX,posY+1*DposX+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),w-(int(w/2)/16+14),h-18,2);
    surface = worldMap(posX+1*DposY-4*DposX,posY+1*DposX+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),w-(int(w/2)/8+10),h-15,3);
    surface = worldMap(posX+1*DposY-3*DposX,posY+1*DposX+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),w-(int(w/2)/4+6),h-7,5);
     surface = worldMap(posX+1*DposY-2*DposX,posY+1*DposX+2*DposY);
        if(surface == "M")
            mountain(5,int(w/2)+15,w-2,h,7);
        #left2
    surface = worldMap(posX-2*DposY-6*DposX,posY-2*DposX+6*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/32),int(w/2)/32,h-20,1);
    surface = worldMap(posX-2*DposY-5*DposX,posY-2*DposX+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),int(w/2)/16,h-18,2);
    surface = worldMap(posX-2*DposY-4*DposX,posY-2*DposX+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),int(w/2)/8-2,h-15,3);
    surface = worldMap(posX-2*DposY-3*DposX,posY-2*DposX+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),int(w/2)/4-6,h-7,5);
     surface = worldMap(posX-2*DposY-2*DposX,posY-2*DposX+2*DposY);
        if(surface == "M")
           mountain(5,int(w/2)+15,-int(w/4),h,7);
        #right2
    surface = worldMap(posX+2*DposY-6*DposX,posY+2*DposX+6*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/32),w-(int(w/2)/32),h-20,1);
    surface = worldMap(posX+2*DposY-5*DposX,posY+2*DposX+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),w-(int(w/2)/16),h-18,2);
    surface = worldMap(posX+2*DposY-4*DposX,posY+2*DposX+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),w-(int(w/2)/8-2),h-15,3);
    surface = worldMap(posX+2*DposY-3*DposX,posY+2*DposX+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),w-(int(w/2)/4-6),h-7,5);
     surface = worldMap(posX+2*DposY-2*DposX,posY+2*DposX+2*DposY);
        if(surface == "M")
           mountain(5,int(w/2)+15,w+int(w/4),h,7);
       
       #left3
    surface = worldMap(posX-3*DposY-5*DposX,posY-3*DposX+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),int(w/2)/16-5,h-18,2);
    surface = worldMap(posX-3*DposY-4*DposX,posY-3*DposX+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),int(w/2)/8-10,h-15,3);
    surface = worldMap(posX-3*DposY-3*DposX,posY-3*DposX+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),int(w/2)/4-12,h-7,5);
     surface = worldMap(posX-3*DposY-2*DposX,posY-3*DposX+2*DposY);
        if(surface == "M")
           mountain(5,int(w/2)+15,-int(w/4)-10,h,7);
        #right3
    surface = worldMap(posX+3*DposY-5*DposX,posY+3*DposX+5*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/16),w-(int(w/2)/16-5),h-18,2);
    surface = worldMap(posX+3*DposY-4*DposX,posY+3*DposX+4*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/8),w-(int(w/2)/8-10),h-15,3);
    surface = worldMap(posX+3*DposY-3*DposX,posY+3*DposX+3*DposY);
        if(surface == "M")
            mountain(5,int((w+50)/4),w-(int(w/2)/4-12),h-7,5);
     surface = worldMap(posX+3*DposY-2*DposX,posY+3*DposX+2*DposY);
        if(surface == "M")
           mountain(5,int(w/2)+15,w+int(w/4)+10,h,7);
   }
    #MINIMAP
     mini_map(6,5+6);
    #speedometer
    speedometer();
    #fuel meter
    fuel_meter();
  redraw();  
    if((int(oldPosX)!=int(posX))||(int(oldPosY)!=int(posY))) redraw();
    system("stty -echo")
 cmd = "bash -c 'read -t 1 -n 1 input; echo $input'"
# cmd = "bash -c 'read -n 1 input; echo $input'"
    cmd | getline input
    if(input=="") input = "forward"
    close(cmd)
    system("stty echo")
    if(input == movf_key || input == movb_key){
        if(input==movf_key) newSpeed=moveSpeed+0.2
        else newSpeed=moveSpeed-0.2
        if(((newSpeed<1.9) && (newSpeed>0.9))){
            moveSpeed=newSpeed;}
            input=forward;
         }
         
    if(input==movdown_key){
    if((int(posX)==winX)&&(int(posY)==winY)&&(int(moveSpeed)<1.2))
    return 0;
    } else
    if (input=="forward" || input == movl_key || input == movr_key){
      newPosX = posX - dirX * moveSpeed
      newPosY = posY - dirY * moveSpeed
     if(input=="forward") {
        newPosX = posX + dirX * moveSpeed
        newPosY = posY + dirY * moveSpeed
     }
     if(input == movl_key){
        newPosX = posX + dirX * moveSpeed
        newPosY = posY + dirY * moveSpeed
        newPosX = newPosX - dirY * moveSpeed
        newPosY = newPosY + dirX * moveSpeed
      }
      if(input == movr_key){
        newPosX = posX + dirX * moveSpeed
        newPosY = posY + dirY * moveSpeed
        newPosX = newPosX + dirY * moveSpeed
        newPosY = newPosY - dirX* moveSpeed
      }
        if(worldMap(newPosX,posY) <= 5) {oldPosX= posX;posX = newPosX;}
        else if(worldMap(newPosX,posY) == 9){ posX = abs(posX-mapHeight);}
        else return 1;
        if(worldMap(posX,newPosY) <= 5) {oldPosY= posY; posY = newPosY}
        else if(worldMap(posX,newPosY) == 9) posY = abs(posY-mapWidth);
        else return 1;
    } 
    if (input == rotr_key ){
        newPosX = posX + dirX * moveSpeed
        newPosY = posY + dirY * moveSpeed
        newPosX = newPosX + dirY * moveSpeed
        newPosY = newPosY - dirX * moveSpeed
        if(worldMap(newPosX,posY) <= 5) {oldPosX= posX;posX = newPosX;}
        else if(worldMap(newPosX,posY) == 9){oldPosX= posX; posX = abs(posX-mapHeight);}
        else return 1;
        if(worldMap(posX,newPosY) <= 5) {oldPosY= posY; posY = newPosY}
        else if(worldMap(posX,newPosY) == 9) posY = abs(posY-mapWidth);
        else return 1;
        if(dirY==-1){dirX=-1; dirY=0;}
        else
        if(dirY==1){dirX=1; dirY=0;}
        else
        if(dirX==-1){dirX=0; dirY=1;}
        else
        if(dirX==1){dirX=0; dirY=-1;}
    }
   if (input == rotl_key ){
        newPosX = posX + dirX * moveSpeed
        newPosY = posY + dirY * moveSpeed
        newPosX = newPosX + dirY * moveSpeed
        newPosY = newPosY - dirX * moveSpeed
        if(worldMap(newPosX,posY) <= 5) {oldPosX= posX;posX = newPosX;}
        else if(worldMap(newPosX,posY) == 9){oldPosX= posX; posX = abs(posX-mapHeight);}
        else return 1;
        if(worldMap(posX,newPosY) <= 5) {oldPosY= posY; posY = newPosY}
        else if(worldMap(posX,newPosY) == 9) posY = abs(posY-mapWidth);
        else return 1;
        if(dirY==-1){dirX=1; dirY=0;}
        else
        if(dirY==1){dirX=-1; dirY=0;}
        else
        if(dirX==-1){dirX=0; dirY=-1;}
        else
        if(dirX==1){dirX=0; dirY=1;}
   }
      #both camera direction and camera plane must be rotated
    if(input == "1")
      colormode = 1
    else if(input == "2")
      colormode = 2
    else if(input == "3")
      colormode = 3
    else if(input == "4")
      colormode = 4
    else if(input == exit_key)
     return 3
  }
}
