class Rocket{
  PVector pos;
  PVector vel;
  boolean active;
  DNA dna;
  int time;
  float fitness;
  Rocket(float x, float y, int l){
    pos = new PVector(x, y);
    vel = new PVector(3, 0);
    active = true;
    dna = new DNA(l);
    time = 0;
  }
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading()-PI/2);
    rectMode(CENTER);
    stroke(255, 0, 0, 200);
    fill(255, 255, 0, 200);
    if(active)
      triangle(-3.5, 0, 3.5, 0, 0, -6);
    stroke(0, 255, 0);
    fill(0, 255, 0, 15);
    arc(0, 8, 7, 18, 0, PI);
    rect(0, 4, 7, 8); 
    popMatrix();
  }
  void update(){
    if(active){
      pos.add(vel);
      time ++;
      fitness = pos.x;
    }
  }
  void move(){
    if(active)
      vel.rotate(radians(dna.genes[time]));
  }
  void steer(float r){
    vel.rotate(radians(r));
  }
  void collide(Asteroid a){
    float dist = dist(a.pos.x, a.pos.y, pos.x, pos.y);
    if(dist < a.radius + 10)
      active = false;
    if(pos.y > 400 || pos.y < 0)
      active = false;
    if(time == dna.genes.length - 1)
      active = false;
    if(pos.x <= 0){
      active = false;
      fitness = 0;
    }
  }
  void resetTo(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector(3, 0);
    active = true;
    time = 0;
  }
}