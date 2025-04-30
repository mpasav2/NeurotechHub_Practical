# NeurotechHub_Practical
# Low-Power Data Logger

Logs 5 rows of sensor data every **10 minutes** to a uniquely-named CSV file, then cuts power to the µSD card for maximum battery life.

---

## Hardware

| Qty | Item | Example part | Purpose |
|-----|------|--------------|---------|
| 1 | **ESP32 Dev Board** | ESP32-WROOM-32D module / dev-kit | MCU + Wi-Fi (if you want remote sync later) |
| 1 | **µSD-card socket / module** | Generic 3 V3 SPI breakout | Removable storage |
| 1 | **P-channel MOSFET** | *IRLML6402* (or load-switch IC) | High-side switch to cut SD-card VCC |
| 1 | 10 k Ω resistor | — | Pull-up on MOSFET gate |
| 1 | 0.1 µF capacitor | — | Local decoupling on SD VCC |

<details>
<summary>🖉  Minimal wiring</summary>


</details>

---

## Getting Started

1. **Clone & open** this repo in **Arduino IDE 2.x**.  
2. **Boards Manager → ESP32** : install latest “esp32 by Espressif”.  
3. Connect your ESP32 board, select the right **COM/tty** port.  
4. `Sketch → Upload`.  
5. Open the Serial Monitor at **115 200 baud** to watch status messages.

The firmware:

* powers the SD card (sets `SD_PWR` LOW),   
* writes 5 rows of dummy data (`timestamp,data1,data2,data3`),  
* unmounts and powers the card down,  
* deep-sleeps the ESP32 for 10 minutes,  
* repeats forever.

---

## Tools Used

* **Arduino IDE 2.x**  
* **esp32-arduino core** (v3.x)  
* **Perplexity AI** – assisted with example code & docs wording  

---

## Repository Contents

| Path | Description |
|------|-------------|
| `logger.ino` | Minimal ESP32 sketch — main application |
| `hardware/` | Schematic PDF / PNG & BOM |
| `README.md` | This file |

