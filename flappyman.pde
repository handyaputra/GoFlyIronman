PImage main, back, ironman, wall; //init image

int play = 0; //1 = mulai main
int score = 0; int high = 0; //score dan highscore
int x = 0; int y = 0; //posisi ironman
int v = 0; //kecepatan
int wx[] = new int[2]; int wy[] = new int [2]; //posisi wall

void setup() {
  size(600,700);
  frameRate(60);
  
  fill(255);
  textSize(32);
  
  main = loadImage("main.png");
  back = loadImage("back2.png");
  ironman = loadImage("ironman2.png");
  wall = loadImage("wall.png");
}

void draw() {
  if(play == 0) { //main menu
    imageMode(CENTER);
    image(main, width/2, height/2);
    text("High Score = "+high, 48, 50);
  } else { //waktu main
    imageMode(CORNER);
    image(back, x, 0); //background 1
    image(back, x+back.width, 0); //background 2
    x -= 1; //gerak background
    v++; //gravitasi
    y += v; //posisi + gravitasi
    if(x == -1920) { //re-render background
      x = 0;
    }
    for(int i=0 ; i<2 ; i++) { //init  wall
      imageMode(CENTER);
      image(wall, wx[i], wy[i] - (wall.height/2+100));
      image(wall, wx[i], wy[i] + (wall.height/2+100));
      if(wx[i] < 0) { //ganti wall
        wx[i] = width;
        wy[i] = (int)random(200, height-200);
      }
      if(wx[i] == width/2) { //berhasil lewat
        high = max(++score, high);
      }
      if(y > height || y < 0 || (abs(width/2-wx[i])<25 && abs(y-wy[i])>100)) { //saat nabrak
        play = 0;
      }
      wx[i] -= 5; //gerak wall
    }
    image(ironman, width/2, y);
    text(score, width/2, 600);
  }
}

void mousePressed() {
  v = -15; //up up
  if(play == 0) { //init wall awal
    wx[0] = 600;
    wy[0] = height/2;
    
    wx[1] = 900;
    wy[1] = 600;
    
    x = 0;
    y = height/2;
    
    play = 1;
    score = 0;
  }
  play = 1;
}
