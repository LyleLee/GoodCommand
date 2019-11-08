interrupts
***********************

中断，它是一种由设备使用的硬件资源异步向处理器发信号。实际上，中断就是由硬件来打断操作系统。
大多数现代硬件都通过中断与操作系统通信。对给定硬件进行管理的驱动程序注册中断处理程序，是为了响应并处理来自相关硬件的中断。中断过程所做的工作包括应答并重新设置硬件,
从设备拷贝数据到内存以及反之，处理硬件请求，并发送新的硬件请求。
《linux内核设计与实现》

不同设备的中断：

| `[树莓派的中断] <resources/pi.proc.interrupts.md>`__
| `[x86云主机的中断] <resources/cloud.proc.interrupts.md>`__
| `[x86服务器的中断] <resources/x86.proc.interrupts.md>`__
| `[arm服务器的中断] <resources/arm.proc.interrupts.md>`__

解读中断
--------

这里以树莓派的中断为例。

.. code::

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

在\ ``kernel/irq/proc.c`` 中的函数可以看到打印函数

.. code:: c

   int show_interrupts(struct seq_file *p, void *v)

| 前半部分
| 第一列：是中断号。
| 第二、三、四、五列：每列一个CPU，是在该CPU上的中断计数器。可以看到17号中断产生了非常多，它是时钟中断。

.. code:: c

           /* print header and calculate the width of the first column */
           if (i == 0) {
                   for (prec = 3, j = 1000; prec < 10 && j <= nr_irqs; ++prec)
                           j *= 10;

                   seq_printf(p, "%*s", prec + 8, "");
                   for_each_online_cpu(j)
                           seq_printf(p, "CPU%-8d", j);
                   seq_putc(p, '\n');
           }

| 第六列是中断控制器。\ `[bcm2836] <https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/README.md>`__\ 是树莓派2的CPU。bcm2836-timer是cpu时钟中断控制器。\ `[ARMCTRL-level] <https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/brcm%2Cbcm2835-armctrl-ic.txt>`__\ 是bcm2836的顶层中断控制器。
| 第七列：硬件中断号？

.. code:: c

           if (desc->irq_data.domain)
                   seq_printf(p, " %*d", prec, (int) desc->irq_data.hwirq);
           else
                   seq_printf(p, " %*s", prec, "");

第八列：中断级别。

.. code:: c

   #ifdef CONFIG_GENERIC_IRQ_SHOW_LEVEL
           seq_printf(p, " %-8s", irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge");
   #endif

第九列：就是注册的终端处理程序。有多个逗号的表示这个中断号对应有多个中断处理程序。

.. code:: c

           action = desc->action;
           if (action) {
                   seq_printf(p, "  %s", action->name);
                   while ((action = action->next) != NULL)
                           seq_printf(p, ", %s", action->name);
           }

``dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb1``\ 代表以太网或者USB中断
`[x86云主机的中断] <resources/cloud.proc.interrupts.md>`__\ 中的\ ``i8042``\ 代表键盘控制器中断
##术语 IRQ 中断请求 ISR Interrupt Service Routine 中断服务例程
