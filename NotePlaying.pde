import java.util.*;

Note[] target;
int popMax;
float mutationRate;
Population population;

void setup() {
  size(400, 300);
  target = new Note[10];
  for (int i = 0; i < target.length; i++) {
    target[i] = new Note((int)random(300, 600), 100);
  }

  popMax = 1000;
  mutationRate = 0.01;
  population = new Population(target, mutationRate, popMax);
}
void draw() {
  background(0);
  noFill();
  textSize(10);


  population.naturalSelection();
  population.generate();
  population.calcFitness();

  if (population.finished()) {
    println(millis()/1000);
    noLoop();
  }

  displayInfo(population.finished());
}

void displayInfo(boolean b) {
  Note[] answer = population.getBest();
  text("Target phrase:", 10, 10);

  float w1 = 0;
  float w2 = 0;
  stroke(255);
  strokeWeight(2);
  for (Note n : target) {
    float y = map(n.pitch, 300, 600, 0, 100);
    w2 = w1 + map(n.duration, 0, 1000, 0, width / 2);
    line(w1, 110 - y, w2, 110 - y);
    w1 = w2;
  }

  if (b) {
    try {
      for (Note n : target) {
        n.playNote(this);
      }
      Thread.sleep(2000);
    } 
    catch(InterruptedException e) {
    }
  }

  text("Best phrase:", width / 2, 10);
  w1 = width / 2;
  w2 = width / 2;
  for (Note n : answer) {
    float y = map(n.pitch, 300, 600, 0, 100);
    w2 = w1 + map(n.duration, 0, 1000, 0, width / 2);
    line(w1, 110 - y, w2, 110 - y);
    w1 = w2;
  }

  if (b) {
    try {
      for (Note n : answer) {
        n.playNote(this);
      }
      Thread.sleep(2000);
    } 
    catch(InterruptedException e) {
    }
  }

  text("total generations: " + population.getGenerations(), 10, 140);
  text("average fitness: " + population.getAverageFitness(), 10, 155);
  text("total population: " + popMax, 10, 170);
  text("mutation rate: " + mutationRate, 10, 185);
  text("perfect score: " + population.perfectScore, 10, 200);
  text("best fitness: " + population.getMaxFitness(), 10, 215);
  text(String.format("progress: %.0f%%", floor(population.getMaxFitness() / population.perfectScore * 100)), 10, 230);
}
