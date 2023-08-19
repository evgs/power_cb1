## Предварительные требования

* Наличие BTT CB1 v2.2 или BTT CB1 eMMC
* Наличие BTT Relay
* Свободный пин #40 (Обозначение GPIO21 на платах BTT MANTA, PC8 на BTT CB1 v2.2, или PI2 на CB1 eMMC)
* Установленный официальный образ Debian [отсюда](https://github.com/bigtreetech/CB1/releases). Тестировалась версия 2.3.3

## быстрая установка на BTT CB1 v2.2

```bash
git clone https://github.com/evgs/power_cb1
cd power_cb1
sudo ./install_v2.2.sh
sudo reboot
```

## быстрая установка на BTT CB1 eMMC

```bash
git clone https://github.com/evgs/power_cb1
cd power_cb1
sudo ./install_eMMC.sh
sudo reboot
```
## проверка перед подключением

```bash
sudo apt install gpiod
gpioinfo | grep btt
```

При правильно установленном и загруженном оверлее увидим
```
        line  72:      unnamed  "btt-relay"  output  active-high [used]
```

номер Line 72 - для CB1 v2.2, Line 258 - для CB1 eMMC


## Схема подключения  
(TBD)
