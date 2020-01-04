**********************
hns dependencies
**********************

.. code-block:: console

                ib_core
                   ^
                   |
                   +----- hns_roce <-----  hns_roce_hw_v2
                                               +
                                               |
                          hnae3    <-----------+
                                   <----+
                                        +- hns3
                                        |
                                        +- hclge
                                        |
                                        +- hclgevf
    scsi_transport_sas
      ^
      |
      +--+ libsas <---+ hisi_sas_main
            ^ ^ ^        ^ ^ ^
            | | |        | | |
            | | +------------+------------ hisi_sas_v2_hw
            | |          | |
            | +------------+-------------- hisi_sas_v2_hw
            |            |
            +------------+---------------+ hisi_sas_v3_hw


hnae3       (Hisilicon Network Acceleration Engine) Framework
HNS3        Hisilicon Ethernet Driver
hclge       HCLGE Driver
HCLGEVF     HCLGEVF Driver