import processing.sound.*;

class Note {
  int pitch;
  long duration;

  Note(int p, long d) {
    this.pitch = p;
    this.duration = d;
  }
  
  void playNote(PApplet app) throws InterruptedException {
   TriOsc note = new TriOsc(app);
   note.freq(pitch);
   note.play();
   Thread.sleep(duration);
   note.stop();
  }
}
