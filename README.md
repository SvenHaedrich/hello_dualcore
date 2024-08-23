# VIEGA CAN Bridge

Investigate a proof of concept that bridges between an Aqua VIP CAN bus and a bluetooth mesh.

## Hardware

The following hardware is used for the project:

- [Nordic nRF52840 DK](https://www.nordicsemi.com/Products/Development-hardware/nRF52840-DK)
- [seeed studio CAN-BUS Shield V2.0](https://wiki.seeedstudio.com/CAN-BUS_Shield_V2.0/)

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
	west init -m https://github.com/SvenHaedrich/hello_riscv --mr main nRF54L15
	cd nrf54L15
	west update
	
	# install additional tools
	python3 -m pip install pyelftools
	python3 -m pip install intelhex

### Build


