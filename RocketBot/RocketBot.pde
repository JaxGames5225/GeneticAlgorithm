Rocket rocket;
Asteroid [] asteroids;
Population population;
final int DNA_LENGTH = 1000;
int gen = 0;
Rocket genBest;
boolean showBest = false;
boolean goalReached = false;
void setup(){
  size(1200, 500);
  asteroids = new Asteroid[20];
  for(int i = 0; i < asteroids.length; i ++){
    asteroids[i] = new Asteroid(random(200, 1000), random(0, 400));
  }
  population = new Population(50, DNA_LENGTH);
  population.randomizeDNA();
  genBest = new Rocket(50, height/2, population.rockets[0].dna.genes.length);
}
void draw(){
  background(25);
  if(population.nextGen()){
    population.getFitness();
    genBest.dna = population.maxFitness();
    genBest.resetTo(50, height/2);
    population.reproduce();
    population.mutate();
    gen ++;
  }else{
    population.runRockets(asteroids);
    if(gen > 0){
      if(showBest)
        genBest.display();
      genBest.update();
      genBest.move();
      for(int i = 0; i < asteroids.length; i ++){
        genBest.collide(asteroids[i]);
      }
    }
  }
  for(int i = 0; i < asteroids.length; i ++){
    asteroids[i].display();
  }
  rectMode(CORNER);
  fill(150);
  rect(0, 400, width, 100);
  fill(0);
  text("Generation: " + gen, 10, 420);
  text("Mutation Rate: " + new DNA(1).mutationRate*100 + "%", 10, 440);
  text("Population Size: " + population.rockets.length, 10, 460);
  text("Goal Reached: " + goalReached, 10, 480);
}