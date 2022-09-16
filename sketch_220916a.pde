import ddf.minim.analysis.*;
import ddf.minim.*;


Minim minim;
AudioPlayer player;
FFT fft;
float a;

void setup() {
  size(200, 200);
  noStroke();

  minim=new Minim(this);
  player=minim.loadFile("Ganryu.mp3", 1024);
  player.loop();

  fft=new FFT(player.bufferSize(), player.sampleRate());
  println("sampling reate is " +player.sampleRate());
  println("spec size is " +fft.specSize());
  println("bandwidth is: " +fft.getBandWidth());

  for (int i=0; i<fft.specSize(); i++) {
    println(i+"="+fft.getBandWidth()*i+"~"+fft.getBandWidth()*(i+1));
  }
}

void draw() {
  background(0);
  fft.forward(player.mix);

  for (int b=100; b<360; b++ ) {
    for (int i=0; i<fft.getBand(b); i++) {
      a=map(i, 0, fft.getBand(b), 0, 255);
      fill(random(255), random(255), random(255), a);
      rect(0, 0, width, height);
    }
  }
}
