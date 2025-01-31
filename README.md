# Firmware2 

***Originally known as "NissaFW2"***

A tool for setting the correct recovery firmware on any keyrolled devices
To use this, first make sure that you are connected to an unmanaged network, and that you are signed into a valid account on the Chromebook. 
Then switch to VT2 and enter root by typing `chronos` 
Make sure you use `chronos` and not `root`
Then type these commands first


`curl -LO https://raw.githubusercontent.com/Cruzy22k/Firmware2/main/firmware.sh && chmod +x firmware.sh && sudo bash firmware.sh`

Don't worry if it gives you a warning about noexec mount, this is intended behaviour 

Follow the prompts, ensuring you have firmware and hardware **WP** **DISABLED** as this will not work with WP ON.

***Do not select the wrong device, make susre u know 100% what your devices board name is.***


**then ur done, boot a shim or whatever**
