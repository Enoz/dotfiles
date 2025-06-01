tabletName='Huion H610X'

# Mouse Mode
if [ $1 = "mouse" ]; then
    otd setoutputmode "${tabletName}" OpenTabletDriver.Desktop.Output.RelativeMode
    exit 0
fi

## Absolute Mode
tabletArea=(0 0 0 0)
displayArea=(0 0 0 0)
if [ $1 = "left" ]; then
    tabletArea=(90 158.8 127 79.4)
    displayArea=(1080 1920 540 960)
fi
if [ $1 = "middle" ]; then
    tabletArea=(254 158.8 127 79.4)
    displayArea=(2560 1440 2360 1010)
fi
if [ $1 = "right" ]; then
    tabletArea=(254 158.8 127 79.4)
    displayArea=(2560 1440 4920 1387)
fi

otd setoutputmode "${tabletName}" OpenTabletDriver.Desktop.Output.AbsoluteMode

## Set Monitor Area
otd setdisplayarea "${tabletName}" ${displayArea[0]} ${displayArea[1]} ${displayArea[2]} ${displayArea[3]}

## Set Tablet Area
otd settabletarea "${tabletName}" ${tabletArea[0]} ${tabletArea[1]} ${tabletArea[2]} ${tabletArea[3]} 0


