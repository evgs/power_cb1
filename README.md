# Управление питанием системы, содержащей вычислительный модуль BTT CB1

Основная цель - управление питанием в стиле ATX PC, а именно - корректное завершение работы с обесточиванием системы, включая SBC и 3д-принер, после сброса кэшей записи и размонтирования файловой системы.
Работает с платами BTT Manta M4P, M5P, M8P, а также с BTT Pi

В качестве исполнительного устройства, выключающего питание системы, предлагается использовать BTT Relay https://aliexpress.ru/item/4000180758289.html

![BTT Relay](../images/btt_enclosure.png) 

Основная характеристика реле, обеспечившая его выбор (а не похожее MKS PWC) - задержка включения/выключения 15 секунд, позволяющая загрузить ядро Linux 
с необходимыми оверлеями без необходимости зажимать на это время (около 5 секунд) кнопку включения.

Основной недостаток - реле включает нагрузку по умолчанию, при начальной подаче сетевого напряжения 230В или пропадания сетевого напряжения.

Подробно работа данного реле рассмотрена в статье https://3dtoday.ru/blogs/vasilius-v/reversing-modulya-rele-bigtreetech-relay-v12

Возможно использование других реле, удовлетворяющих основному требованию - задержке выключения 10-15 секунд при отсутствии управляющего сигнала


![CAUTION](/images/highvoltage.png)

**ВНИМАНИЕ!** **ОПАСНО ДЛЯ ЖИЗНИ!** Действия, описываемые в данной статье, подразумевают вмешательство в электрическую часть системы (3д-принтера), напрямую подключаемую к электрической сети 230В. Все манипуляции, связанные с подключением проводов, проводить на обесточенной системе! Сетевой шнур должен быть вынут из розетки. Если вы не обладаете знаниями, навыками и допуском к работе с электроустановками, обратитесь к специалисту для выполнения описанных модификаций.

Крайне рекомендуется изолированый корпус или полукорпус для модуля BTT Relay


## Предварительные требования

* Наличие BTT CB1 v2.2 или BTT CB1 eMMC
* Наличие BTT Relay
* Свободный пин #40 (Обозначение GPIO21 на платах BTT MANTA, PC8 на BTT CB1 v2.2, или PI2 на CB1 eMMC)
* Установленный официальный образ Debian [отсюда](https://github.com/bigtreetech/CB1/releases). Тестировалась версия 2.3.3

## Кнопка включения
На момент написания статьи кнопка задействуется только для включения системы, выключение производится через веб-интерфейс командой Shutdown host,
кнопкой в интерфейсе Klipperscreen, shell-командой ```sudo poweroff```. Также возможно выключение принтера по [таймауту бездействия](https://github.com/evgs/OrangePi3Lts/blob/main/power/auto_poweroff.md)

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

[wiring](/images/wiring.png)
