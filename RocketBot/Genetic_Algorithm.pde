class Population{
  Rocket [] rockets;
  Population(int size, int genes){
    rockets = new Rocket[size];
    for(int i = 0; i < size; i ++){
      rockets[i] = new Rocket(50, height/2, genes);
    }
  }
  void randomizeDNA(){
    for(int i = 0; i < rockets.length; i ++){
      rockets[i].dna.randomize();
    }
  }
  void runRockets(Asteroid [] a){
    for(int i = 0; i < rockets.length; i ++){
      for(int j = 0; j < a.length; j ++){
        rockets[i].collide(a[j]);
      }
      rockets[i].update();
      if(!showBest)
        rockets[i].display();
      rockets[i].move();
      if(rockets[i].pos.x > width)
        goalReached = true;
    }
  }
  void getFitness(){
    float total = 0;
    for(int i = 0; i < rockets.length; i ++){
      total += rockets[i].fitness;
    }
    for(int i = 0; i < rockets.length; i ++){
      rockets[i].fitness /= total;
    }
  }
  void reproduce(){
    ArrayList<Rocket> pool = new ArrayList<Rocket>();
    for(int i = 0; i < rockets.length; i++){
      int n = int(rockets[i].fitness*100);
      for(int j = 0; j < n; j ++){
        pool.add(rockets[i]);
      }
    }
    for(int i = 0; i < rockets.length; i++){
      Rocket a = pool.get(int(random(0, pool.size())));
      Rocket b = pool.get(int(random(0, pool.size())));
      rockets[i] = new Rocket(50, height/2, rockets[i].dna.genes.length);
      rockets[i].dna.combine(a.dna, b.dna);
    }
  }
  void mutate(){
    for(int i = 0; i < rockets.length; i++){
      rockets[i].dna.mutate();
    }
  }
  DNA maxFitness(){
    float max = 0;
    Rocket best = new Rocket(0, 0, 0);
    for(int i = 0; i < rockets.length; i++){
      if(rockets[i].fitness > max){
        best = rockets[i];
        max = rockets[i].fitness;
      }
    }
    return best.dna;
  }
  boolean nextGen(){
    boolean temp = true;
    for(int i = 0; i < rockets.length; i ++){
      if(rockets[i].active == true)
        temp = false;
    }
    if(showBest && gen > 0){
      if(genBest.active == true){
        temp = false;
      }
    }
    return temp;
  }
}

class DNA{
  float[] genes;
  float mutationRate = 0.01;
  DNA(int l){
    genes = new float[l];
  }
  void randomize(){
    for(int i = 0; i < genes.length; i ++){
      genes[i] = random(-5, 5);
    }
  }
  void combine(DNA a, DNA b){
    if(a.genes.length == b.genes.length){
      int cut = int(random(1, a.genes.length-1));
      for(int i = 0; i < a.genes.length; i ++){
        if(i < cut){
          genes[i] = a.genes[i];
        }else{
          genes[i] = b.genes[i];
        }
      }
    }
  }
  void mutate(){
    for(int i = 0; i < genes.length; i ++){
      if(random(0, 1) < mutationRate){
        genes[i] = random(-5, 5);
      }
    }
  }
}