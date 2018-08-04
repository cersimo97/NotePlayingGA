// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Genetic Algorithm, Evolving Shakespeare

// A class to describe a psuedo-DNA, i.e. genotype
//   Here, a virtual organism's DNA is an array of character.
//   Functionality:
//      -- convert DNA into a string
//      -- calculate DNA's "fitness"
//      -- mate DNA with another set of DNA
//      -- mutate DNA


class DNA {

  // The genetic sequence
  Note[] genes;

  float fitness;

  // Constructor (makes a random DNA)
  DNA(int num) {
    genes = new Note[num];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = new Note((int)random(300, 600), 400);
    }
  }

  // Fitness function (returns floating point % of "correct" characters)
  void fitness (Note[] target) {
    float score = 0.0f;
    float fitnessPitch = 0.0f;
    // float fitnessDuration = 0;
    for (int i = 0; i < genes.length; i++) {
      fitnessPitch = map(abs(target[i].pitch - genes[i].pitch), 0, 300, 1, 0);  // 300 = 600Hz - 300Hz
      // fitnessDuration = 1 - abs(target[i].duration - genes[i].duration) / 950; // 950 = 1000ms - 50ms
      score += fitnessPitch; // + fitnessDuration;
      /*
      if (genes[i] == target[i]) {
       score++;
       }
       */
    }
    fitness = pow(2, score);
  }

  // Crossover
  DNA crossover(DNA partner) {
    // A new child
    DNA child = new DNA(genes.length);


    int midpoint = int(random(genes.length)); // Pick a midpoint

    // Half from one, half from the other
    for (int i = 0; i < genes.length; i++) {
      if (i > midpoint) child.genes[i] = new Note(genes[i].pitch, 100);
      else              child.genes[i] = new Note(partner.genes[i].pitch, 100);
    }

    return child;
  }

  // Based on a mutation probability, picks a new random character
  void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i].pitch = (int)random(300, 600);
      }
    }
  }
}
