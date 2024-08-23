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
	cd nrf54L15
	west update
	
	# install additional tools
	python3 -m pip install pyelftools
	python3 -m pip install intelhex

### Build


