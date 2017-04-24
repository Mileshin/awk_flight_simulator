# awk_flight_simulator

Запуск: gawk -f simulator.awk

Управление: 

Взлет k

Посадка j

Движение влево a

Движение вправо d

Увелечение скорости во время полета w

уменьшение скорости во время полета s


Разворот влево h

Разворот вправо l

1 2 3 4 цветовые схемы

Выход q

Авиасимулятор, написанный на gawk. Цель игры: перелететь карту на самолете и сесть на посадочной полосе. Она отмечена знаками > и < по бокам. Посадка возможна лишь при минимальной скорости самолета. Повороты совершаются на 90 градусов с заносом, то есть игрок при повороте пролетит еще какое-то расстояние вперед за счет инерции. При вылете за пределы карты игрок оказывается на противоположной стороне карты.

Скорости самолета и соответствие в движении на карте

150 км/ч - 1

180 км/ч - 1.2

210 км/ч - 1.4

240 км/ч - 1.6

270 км/ч - 1.8

Сontrolling: 

takeoff k

Landing j

Movement to the left a

Movement to the right d

The increase speed in-flight w

decrease the speed during the flight s


Turn left h

Turn to the right l

1 2 3 4 color schemes

The output q

Aviation simulator written in gawk. Purpose of the game: fly the map on the plane and sit on the runway. It is marked by the signs > and < on the sides. Landing is possible only with the minimum speed of the aircraft. Turns are made at 90 degrees with a drift, that is, the player will fly some more distance ahead at the expense of inertia when turning. When flying out of the card, the player is on the opposite side of the card.

The speed of the aircraft and compliance in the movement on the map

150 km/h - 1

180 km/h - 1.2

210 km/h - 1.4

240 km/h - 1.6

270 km/h - 1.8
