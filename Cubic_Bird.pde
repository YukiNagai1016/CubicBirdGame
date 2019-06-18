float x = 100;
float y = 200;
float speed = 0;
float dx = 400;
float dy = 200;
int shibou = 0;
int score = 0;
int title = 1;
PImage gazo;

void setup() {
  size(600, 400);
  textFont(createFont("Arial", 48));
  gazo = loadImage("monkey.png");
}
void draw() {
  background(0);
  
  if(title == 1){
    fill(255);
    textSize(48);
    textAlign(CENTER);
    text("キュービックバード",  width/2, height/2);
    return;
  }
  // 死亡フラグがたっていなければ
  if(shibou == 0){
    // 土管のプログラム
    dokan();
    // プレイヤーのプログラム
    player();
  }
  if(shibou == 1){
    fill(255, 0, 0);
    textAlign(CENTER);
    text("GAME OVER", 300, 200); 
  }
  
  fill(255);
  textAlign(CENTER);
  textSize(48);
  text(score, width/2, 100);

}
void mousePressed() {
  speed = -8;
}

void dokan(){
  // 土管のdraw
  dx = dx - 5;
  if (dx + 50 < 0) {
    dx = 600;
    dy = random(200, 300);
    score = score + 1;
  }
  fill(255, 255, 255);
  rect(dx, dy, 50, 400 - dy);
  
  //上の土管
  fill(255);
  rect(dx, 0, 50, dy - 150);
}

void player(){
  speed = speed + 0.5;
  y = y + speed;
  // とりえあえず白に戻す
  fill(255, 255, 255);
  // 下の土管と衝突しているか調べる
  int hit = isHit(x, y, 50, 50, dx, dy, 50, 400 - dy);
  if(hit == 1){
    fill(255, 0, 0);
    shibou = 1;
  }
  // 上の土管と衝突しているか調べる
  int hit02 = isHit(x, y, 50, 50, dx, 0, 50, dy - 150);
  if(hit02 == 1){
    fill(255, 0, 0); 
    shibou = 1;
  }
  
  if(y < -50 || y > height){
    shibou = 1;
  }
  
  //rect(x, y, 50, 50);
  image(gazo, x, y, 50, 50);
}

int isHit(float px, float py, float pw, float ph, float ex, float ey, float ew, float eh) {
  if (px < ex + ew && px + pw > ex) {
    if (py < ey + eh && py + ph > ey) {
      return 1;
    }
  }
  return 0;
}

void init(){
  // グローバル変数にアクセスするようにした
  x = 100;
  y = 200;
  speed = 0;
  dx = 400;
  dy = 200;
  shibou = 0;
  score = 0;
  title = 1;
}

void keyPressed(){
  // スペースが押されたら
  if(key == ' '){
    // タイトル画面での処理
    if(title == 1){
      title = 0;
    }
    // 死亡時の処理
    if(shibou == 1){
      init();
    }
  }
}
