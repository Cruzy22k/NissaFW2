# Firmware2 
***Originally known as "NissaFW2"***
**This tool only works on non-factory keyrolled Chromebooks.**
A tool for setting the correct recovery firmware on keyrolled devices
To use this, first make sure that you are connected to an unmanaged network, and that you are signed into a valid account on the Chromebook. 
Then switch to VT2 and enter root by typing `chronos` 
Make sure you use `chronos` and not `root`
Then type these commands first


`curl -LO https://raw.githubusercontent.com/Cruzy22k/Firmware2/main/firmware.sh && chmod +x firmware.sh && sudo bash firmware.sh`

Don't worry if it gives you a warning about noexec mount, this is intended behaviour 

Follow the prompts, ensuring you have firmware and hardware **WP** **DISABLED** as this will not work with WP ON.

***Do not select the wrong device, make sure u know 100% what your device's board name is.***


**Then ur done, boot a shim or whatever**
