import com.shigeodayo.ardrone.processing.*;

ARDroneForP5 ardrone;

int cnt = 0;

float previousPitch = 0;
float previousRoll = 0;

float[] pitches = new float[60];
float[] rolls = new float[60];

void setup() {
  size(320, 240);

  ardrone=new ARDroneForP5("192.168.1.1");
  // connect to the AR.Drone
  ardrone.connect();
  // for getting sensor information
  ardrone.connectNav();
  // for getting video informationp
  ardrone.connectVideo();
  // start to control AR.Drone and get sensor and video data of it
  ardrone.start();
}

void draw() {
  background(204);  

  // getting image from AR.Drone
  // true: resizeing image automatically
  // false: not resizing
  PImage img = ardrone.getVideoImage(false);
  if (img == null)
    return;
  image(img, 0, 0);

  // print out AR.Drone information
  //ardrone.printARDroneInfo();

  // getting sensor information of AR.Drone
  float pitch = ardrone.getPitch();
  float roll = ardrone.getRoll();
  float yaw = ardrone.getYaw();
  float altitude = ardrone.getAltitude();
  float[] velocity = ardrone.getVelocity();
  int battery = ardrone.getBatteryPercentage();

  String attitude = "pitch:" + pitch + "\nroll:" + roll + "\nyaw:" + yaw + "\naltitude:" + altitude;
  text(attitude, 20, 85);
  String vel = "vx:" + velocity[0] + "\nvy:" + velocity[1];
  text(vel, 20, 140);
  String bat = "battery:" + battery + " %";
  text(bat, 20, 170);

  cnt++;
  
  // 前の値との差
  pitches[cnt % 60] = abs(pitch - previousPitch);
  rolls[cnt % 60] = abs(roll - previousRoll);
  
  // 今の値を保存しておく
  previousPitch = pitch;
  previousRoll = roll;

  float totalPitch = 0;
  float totalRoll = 0;

  // 前60回分の値を足す
  for (int i=0; i<60; i++) {
    totalPitch += pitches[i];
    totalRoll += rolls[i];
  }
    
  if (totalPitch > 10 && totalRoll > 10) {
    // 地震検知
//    println("じしん！！！！！！！！！！！！！！！！！！"+cnt);
  }
}