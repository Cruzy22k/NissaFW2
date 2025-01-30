# NissaFW2
A tool for setting the correct recovery firmware on Nissa
To use this, first make sure that you are connected to an unmanaged network, and that you are signed into a valid account on the Chromebook. 
Then switch to VT2 and enter chronos by typing `chronos` 
Make sure you use `chronos` and not `root`
Then type this command. 
Don't worry if it gives you a warning about noexec mount, this is intended behaviour 

`cd; curl -LO https://raw.githubusercontent.com/Cruzy22k/NissaFW2/main/firmware.sh && chmod +x firmware.sh && bash firmware.sh`

Follow the prompts, ensuring you have firmware and hardware **WP** **DISABLED** as this will not work with WP ON.


**then ur done, go boot a shim or whatever**
