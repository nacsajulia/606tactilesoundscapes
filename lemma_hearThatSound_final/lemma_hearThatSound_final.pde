import lemma.library.Event;
import lemma.library.EventHandler;
import lemma.library.Lemma;
import ddf.minim.*;

//----------------------------------------------------------------------------------------------------------------//

Lemma guest1;
Lemma guest2;
int sensorValues0;
int sensorValues1;
int sensorValues2;

int sensorValueTier1 = 1400;
int sensorValueTier2= 1600;
int sensorValueTier3 = 1800;

Minim minim;
AudioPlayer[] soundSampleArray = new AudioPlayer[4];

void setup() { 
  guest1 = new Lemma(this, "bigEars", "julia");

  guest1.hear("shoutLoud0", new Echo());
  guest1.hear("shoutLoud1", new Tempo());
  guest1.hear("shoutLoud2", new Scale());

  guest1.hear("shutUp0", new stopEcho());
  guest1.hear("shutUp1", new stopTempo());
  guest1.hear("shutUp2", new stopScale());



  minim = new Minim(this);
  for (int i = 0; i< soundSampleArray.length; i++)
  {
    soundSampleArray[i] = minim.loadFile("beat" + (i+1)+ ".wav");
    //println(soundSampleArray[i]);
    if ( soundSampleArray[i] == null ) println("Didn't get the music!");
  }

  if (! soundSampleArray[0].isPlaying()) {
      soundSampleArray[0].rewind();
      soundSampleArray[0].play();
    }
}


void draw() {

  guest1.run();
  
  if (! soundSampleArray[0].isPlaying()) {
      soundSampleArray[0].rewind();
      soundSampleArray[0].play();
    }
}

//----------------------------------------------------------------------------------------------------------------//


class Echo implements EventHandler {
  public void callback(Event event) {
    sensorValues0 = event.intValue;
    if (! soundSampleArray[1].isPlaying()) {
      soundSampleArray[1].rewind();
      soundSampleArray[1].play();
    }
  }
}

class Tempo implements EventHandler {
  public void callback(Event event) {
    sensorValues1 = event.intValue;
    if (! soundSampleArray[2].isPlaying()) {
      soundSampleArray[2].rewind();
      soundSampleArray[2].play();
    }
  }
}

class Scale implements EventHandler {
  public void callback(Event event) {
    sensorValues2 = event.intValue;
    if (! soundSampleArray[3].isPlaying()) {
      soundSampleArray[3].rewind();
      soundSampleArray[3].play();
    }
  }
}


class stopEcho implements EventHandler {
  public void callback(Event event) {
    sensorValues0 = event.intValue;
    soundSampleArray[1].pause();
  }
}

class stopTempo implements EventHandler {
  public void callback(Event event) {
    sensorValues1 = event.intValue;
    soundSampleArray[2].pause();
  }
}

class stopScale implements EventHandler {
  public void callback(Event event) {
    sensorValues2 = event.intValue;
    soundSampleArray[3].pause();
  }
}

