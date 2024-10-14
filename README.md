# awk_flight_simulator

### Running:
```bash
gawk -f simulator.awk
```

### Controlling:
- `k` — takeoff
- `j` — landing
- `a` — move left
- `d` — move right
- `w` — increase speed in-flight
- `s` — decrease speed in-flight
- `h` — turn left
- `l` — turn right
- `1 2 3 4` — select color schemes
- `q` — quit

### Game Description:
An aviation simulator written in gawk. The goal of the game is to fly the plane across the map and land on the runway, marked with `>` and `<` symbols on the sides. Landing is only possible at minimum speed. Turns are made at 90 degrees with drift, meaning the plane will continue moving forward due to inertia. When flying off the edge of the map, the player reappears on the opposite side.

### Aircraft speed and movement on the map:
- **150 km/h** — 1 cell
- **180 km/h** — 1.2 cells
- **210 km/h** — 1.4 cells
- **240 km/h** — 1.6 cells
- **270 km/h** — 1.8 cells