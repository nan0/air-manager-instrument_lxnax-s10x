# Lxnax-s10x instrument for Air Manager
_A implementation of the S10x glider vario suitable for the Got Friends Discus 2c_

![preview](https://raw.githubusercontent.com/nan0/air-manager-instrument_lxnax-s10x/develop/5e7fece5-48de-49a4-3d9a-e905411b8255/preview.png)


## Release Plan
### 1.x.x _In Planning (Ordered by priority)_
1. Thermal mode
2. Waypoint mode pages (way point + attitude)
3. Switching between metric an imperial units
4. Be able to change the number and content of the navboxes
5. Changing avg vario / netto computing time

### 1.2.0 _In development_
- Speed to fly indicator
- Blue arrow : MacCready setting
- Switching off the screen when master is off
- Adding a splashscreen when booting the vario
- Adding two rotary buttons and menu navigation
- Displaying wing speed in km/h
- _Fix : Making the yellow bar be able to go under 0 when the max value is negative and upper 0 when the min value is positive_


### 1.1.0 _Released [[Video review here]](https://youtu.be/dhCVyx4by5A)_
- Yellow bar : min/ max vario 
- Red diamond : Avg. Netto within a period of 10s
- 4 navboxes : Avg vario, Netto, Altitude and TAS (True Air Speed)
- _Fix : Using TOTAL ENERGY event instead of VARIO NEEDLE to compute the vario_

### 1.0.0 _Released_
- Vario speed in a  +/-5 m/s range. Needle in medium size
- Avg wind direction and speed in knots
- Avg vario within a period of 20s
- Altitude in meters

## Supported platforms
| Simulator | Platforms         |
|:----------|:------------------|
| MSFS 2020 | Windows, Android  |

## Notes
There are two projects in the repos. The first one the Air manager instrument, 
the other one (UI_projects) are the gimp projects of the graphical assets.

## Author
[Nans Plancher](https://github.com/nan0) / nans.plancher@gmail.com. Feel free to contact me for any feature request or support :)


