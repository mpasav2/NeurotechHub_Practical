#include "FS.h"
#include "SD.h"
#include <SPI.h>

#define SD_CS 5          // SD card chip select pin
#define SD_PWR 12        // GPIO to control SD card power (MOSFET gate)
#define LOG_INTERVAL 600 // 10 minutes in seconds

void setup() {
  pinMode(SD_PWR, OUTPUT);
  digitalWrite(SD_PWR, LOW); // Power ON SD card (MOSFET ON)
  delay(50);                 // Allow SD card to power up

  if (!SD.begin(SD_CS)) {
    digitalWrite(SD_PWR, HIGH); // Power OFF SD card
    esp_deep_sleep(LOG_INTERVAL * 1000000ULL);
  }

String filename = "/LOG" + String((uint32_t)esp_random() % 10000) + ".CSV"; // Create unique filename (e.g., "LOG1234.CSV")

  File file = SD.open(filename, FILE_WRITE);
  if (file) {
    // Write CSV header
    file.println("timestamp,data1,data2,data3");

    // Write 5 rows of unique data
    for (int i = 0; i < 5; i++) {
      unsigned long timestamp = millis(); 
      int data1 = random(0, 100);
      int data2 = random(100, 200);
      int data3 = random(200, 300);

      file.print(timestamp);
      file.print(",");
      file.print(data1);
      file.print(",");
      file.print(data2);
      file.print(",");
      file.println(data3);

      delay(100); // Simulate time between readings
    }
    file.close();
  }

  SD.end(); // Unmount SD card
  digitalWrite(SD_PWR, HIGH); // Power OFF SD card (MOSFET OFF)

  // Sleep for 10 minutes
  esp_sleep_enable_timer_wakeup(LOG_INTERVAL * 1000000ULL);
  esp_deep_sleep_start();
}

void loop() {
  // Not used (ESP32 deep sleep: code runs in setup() after wake)
}
