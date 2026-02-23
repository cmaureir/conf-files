#!/bin/bash

#!/bin/bash
read -r clock temp busy <<< $(nvidia-smi --query-gpu=clocks.gr,temperature.gpu,utilization.gpu --format=csv,noheader,nounits | tr ',' ' ')
echo '{"text": "'$clock'MHz |  '$temp'°C <span color=\"darkgray\"> | '$busy'%</span>", "class": "custom-gpu", "tooltip": "<b>'$deviceinfo'</b>\n'$driverinfo'"}'
