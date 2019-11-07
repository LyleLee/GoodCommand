树莓派的/proc/interrupts 
```txt
           CPU0       CPU1       CPU2       CPU3       
 16:          0          0          0          0  bcm2836-timer   0 Edge      arch_timer
 17:    3047829    2104689    4451895    1361536  bcm2836-timer   1 Edge      arch_timer
 23:      15893          0          0          0  ARMCTRL-level   1 Edge      3f00b880.mailbox
 24:          2          0          0          0  ARMCTRL-level   2 Edge      VCHIQ doorbell
 46:          0          0          0          0  ARMCTRL-level  48 Edge      bcm2708_fb dma
 48:          0          0          0          0  ARMCTRL-level  50 Edge      DMA IRQ
 50:          0          0          0          0  ARMCTRL-level  52 Edge      DMA IRQ
 51:      35573          0          0          0  ARMCTRL-level  53 Edge      DMA IRQ
 54:        206          0          0          0  ARMCTRL-level  56 Edge      DMA IRQ
 59:          0          0          0          0  ARMCTRL-level  61 Edge      bcm2835-auxirq
 62:  139285704          0          0          0  ARMCTRL-level  64 Edge      dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb1
 79:          0          0          0          0  ARMCTRL-level  81 Edge      3f200000.gpio:bank0
 80:          0          0          0          0  ARMCTRL-level  82 Edge      3f200000.gpio:bank1
 86:      21597          0          0          0  ARMCTRL-level  88 Edge      mmc0
 87:       5300          0          0          0  ARMCTRL-level  89 Edge      uart-pl011
 92:       4489          0          0          0  ARMCTRL-level  94 Edge      mmc1
FIQ:              usb_fiq
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:     590271     437681    1438135     374644  Rescheduling interrupts
IPI3:         21         22        346         94  Function call interrupts
IPI4:          0          0          0          0  CPU stop interrupts
IPI5:     550412     395048    1834241     236945  IRQ work interrupts
IPI6:          0          0          0          0  completion interrupts
Err:          0
```