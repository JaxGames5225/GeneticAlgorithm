class Asteroid{
  PVector pos;
  PVector [] points;
  float radius;
  Asteroid(float x, float y){
    pos = new PVector(x, y);
    points = new PVector[6];
    radius = 30;
    for(int i = 0; i < 6; i ++){
      points[i] = new PVector();
      points[i].y = random(radius - 5, radius + 10);
      points[i].rotate((i*(TWO_PI/6)));
    }
  }
  void display(){
    fill(255, 0, 0, 15);    
    stroke(255, 0, 0);
    beginShape();
    for(int i = 0; i < points.length; i ++){
      vertex(points[i].x+pos.x, points[i].y+pos.y);
    }
    vertex(points[0].x+pos.x, points[0].y+pos.y);
    endShape();
  }
}