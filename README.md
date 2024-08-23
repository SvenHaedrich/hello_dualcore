# nRF54L15 ARM and RISC V

First project to use both cores of the nRF54L15

## Hardware

The following hardware is used for the project:

- Nordic nRF54L15 PDK

## Firmware

### Tools

- Set up your Zephyr development tooling. For details refer to the [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)
- For flashing via `west`, set up nrf-command-line tools available [here](https://www.nordicsemi.com/Products/Development-tools/nRF-Command-Line-Tools/Download) from nRF.

### Initialization

	# prepare workspace
	mkdir nRF54L15
	python3 -m venv --copies nRF54L15/.venv
	source nRF54L15/.venv/bin/activate
	# install west
	python3 -m pip install west
	
	# initialize workspace
	west init -m https://github.com/SvenHaedrich/hello_dualcore --mr main nRF54L15
	cd nRF54L15
	west update
	
	# install additional tools
	python3 -m pip install pyelftools
	python3 -m pip install intelhex

### Separate Builds with Merge on Silicon

You can run two seperate builds. This will give you two HEX files.

	west build --board nrf54l15pdk/nrf54l15/cpuapp --build-dir build-app -S nordic-flpr hello_dualcore
	west build --board nrf54l15pdk/nrf54l15/cpuflpr --build-dir build-risc hello_dualcore

Use the nrf Programmer tool to merge the output and flash the result to your device. You can observe the two serial ports via the devkits´s USB connection. These show up as `/dev/ttyACM0` and `/dev/ttyACM1`. You get the following output on these ports:

	*** Booting nRF Connect SDK v2.7.0-5cb85570ca43 ***
	*** Using Zephyr OS v3.6.99-100befc70c74 ***
	Hello World! nrf54l15pdk@0.3.0/nrf54l15/cpuapp

and

	*** Booting nRF Connect SDK v2.7.0-5cb85570ca43 ***
	*** Using Zephyr OS v3.6.99-100befc70c74 ***
	Hello World! nrf54l15pdk@0.3.0/nrf54l15/cpuflpr



### Sysbuild

The canonical way two handle this situation is to use Zephyr's [sysbuild](https://docs.zephyrproject.org/latest/build/sysbuild/index.html). The sysbuild will need some additional configuration files. In this sample
the sysbuild is driven by `sysbuild.cmake`. As of now that attempt files, there seems to be something rotten in the RISC V device tree configuration.

	west build --board nrf54l15pdk/nrf54l15/cpuapp -S nordic-flpr --sysbuild hello_dualcore -- -DSB_CONFIG_RISCV_CPU='"nrf54l15pdk/nrf54l15/cpuflpr"'

gives, at some point:

```
-- Found devicetree overlay: /home/sven_gcx/Repos/nRF54L15/zephyr/snippets/nordic-flpr/nordic-flpr.overlay
devicetree error: 'execution-memory' is marked as required in 'properties:' in /home/sven_gcx/Repos/nRF54L15/zephyr/dts/bindings/riscv/nordic,nrf-vpr-coprocessor.yaml, but does not appear in <Node /soc/peripheral@50000000/vpr@4c000 in '/home/sven_gcx/Repos/nRF54L15/zephyr/misc/empty_file.c'>
-- In: /home/sven_gcx/Repos/nRF54L15/build/riscv/zephyr, command: /home/sven_gcx/Repos/nRF54L15/.venv/bin/python;/home/sven_gcx/Repos/nRF54L15/zephyr/scripts/dts/gen_defines.py;--dts;/home/sven_gcx/Repos/nRF54L15/build/riscv/zephyr/zephyr.dts.pre;--dtc-flags;'';--bindings-dirs;/home/sven_gcx/Repos/nRF54L15/nrf/dts/bindings;/home/sven_gcx/Repos/nRF54L15/zephyr/dts/bindings;--header-out;/home/sven_gcx/Repos/nRF54L15/build/riscv/zephyr/include/generated/devicetree_generated.h.new;--dts-out;/home/sven_gcx/Repos/nRF54L15/build/riscv/zephyr/zephyr.dts.new;--edt-pickle-out;/home/sven_gcx/Repos/nRF54L15/build/riscv/zephyr/edt.pickle;--vendor-prefixes;/home/sven_gcx/Repos/nRF54L15/nrf/dts/bindings/vendor-prefixes.txt;--vendor-prefixes;/home/sven_gcx/Repos/nRF54L15/zephyr/dts/bindings/vendor-prefixes.txt
CMake Error at /home/sven_gcx/Repos/nRF54L15/zephyr/cmake/modules/dts.cmake:296 (message):
  gen_defines.py failed with return code: 1
```
