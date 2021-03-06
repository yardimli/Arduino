
#define NUMREADINGS 30 // raise this number to increase data smoothing


int senseLimit = 150; // raise this number to decrease sensitivity (up to 1023 max)
int probePin = 5; // analog 5
int val = 0; // reading from probePin


int readings[NUMREADINGS];                // the readings from the analog input
int index = 0;                            // the index of the current reading
int total = 0;                            // the running total
int average = 0;                          // final average of the probe reading

//CHANGE THIS TO affect the speed of the updates for numbers. Lower the number the faster it updates.
int updateTime = 5;

void setup() {
  
    Serial.begin(9600);  // initiate serial connection for debugging/etc

  for (int i = 0; i < NUMREADINGS; i++)
    readings[i] = 0;                      // initialize all the readings to 0
}

void loop() {
  val = analogRead(probePin);  // take a reading from the probe
 if(val >= 1){                // if the reading isn't zero, proceed
//    val = constrain(val, 1, senseLimit);  // turn any reading higher than the senseLimit value into the senseLimit value
//    val = map(val, 0, 1023, 0, 255);  // remap the constrained value within a 1 to 1023 range

    total -= readings[index];               // subtract the last reading
    readings[index] = val; // read from the sensor
    total += readings[index];               // add the reading to the total
    index = (index + 1);                    // advance to the next index

    if (index >= NUMREADINGS)               // if we're at the end of the array...
      index = 0;                            // ...wrap around to the beginning

    average = total / NUMREADINGS;          // calculate the average

    Serial.println(average); // use output to aid in calibrating
    delay(updateTime);
  }

}

