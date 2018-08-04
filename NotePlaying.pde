import java.util.*;
import java.util.concurrent.TimeUnit;

Note[] target;
int popMax;
float mutationRate;
Population population;

void setup() {
  size(400, 300);
  target = new Note[8];
  target[0] = new Note(392, 200);
  target[1] = new Note(392, 200);
  target[2] = new Note(392, 200);
  target[3] = new Note(311, 800);
  target[4] = new Note(350, 200);
  target[5] = new Note(350, 200);
  target[6] = new Note(350, 200);
  target[7] = new Note(292, 800);
  
  /*
  for (int i = 0; i < target.length; i++) {
    target[i] = new Note(floor(random(300, 600)), floor(random(50, 1000)));
  }
  */

  popMax = 5000;
  mutationRate = 0.03;
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
  textAlign(LEFT);
  
  // DISPLAY TARGET PHRASE
  text("Target phrase:", 10, 10);
  int sumDurations = 0;
  for (Note n : target) {
    sumDurations += n.duration;
  }
  float w1 = 0;
  float w2 = 0;
  stroke(255);
  strokeWeight(2);
  for (Note n : target) {
    float y = map(n.pitch, 300, 600, 0, 100);
    w2 = w1 + map(n.duration, 0, sumDurations, 0, width / 2 - 10);
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

  // DISPLAY BEST PHRASE
  text("Best phrase:", width / 2, 10);
  sumDurations = 0;
  for (Note n : answer) {
    sumDurations += n.duration;
  }
  w1 = width / 2;
  w2 = width / 2;
  if (b) {
    stroke(0, 255, 0);
  }
  for (Note n : answer) {
    float y = map(n.pitch, 300, 600, 0, 100);
    w2 = w1 + map(n.duration, 0, sumDurations, 0, width / 2 - 10);
    line(w1, 110 - y, w2, 110 - y);
    w1 = w2;
  }

  if (b) {
    try {
      for (Note n : answer) {
        n.playNote(this);
      }
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
  text(String.format("progress: %d%%", floor(population.getMaxFitness() / population.perfectScore * 100)), 10, 230);
  textAlign(RIGHT);
  text(String.format("Time elapsed:%n%02d:%02d", TimeUnit.MILLISECONDS.toMinutes(millis()),
    TimeUnit.MILLISECONDS.toSeconds(millis()) % 60), width - 10, 140);
}
