# TOFU SE Keyboard

I purchase two KBDFANS Tofu SE (Special Edition) keyboards in early 2023.
At the time, it was claimed that they would be configurable using [VIA](https://usevia.app/) software out-of-the-box.
That was almost true, but not quite.

Attempting to connect either of the keyboards in VIA would fail with an error about being unable to fetch a definition.
I believe this is because VIA has a repository of keyboard definitions (which possibly also relies on entries in a QMK repository of firmwares?),
and the Tofu SE was not in that repo at the time.

Thankfully, KDBFANS has provided "v2" & "v3" definition JSON files, which can be provided to VIA.

NOTE: The Tofu SE was a special release of the "TOFU II", and V2 vs V3 definition types have nothing to do with that.

# Providing VIA a definition JSON file:
1. in the Via app go to Settings and enable Show Design Tab
2. in the Design Tab use "Load Draft Definition".
  - If you are using the "v2" definition file, toggle on "use v2 definitions (deprecated)"
  - but instead of that, just use the V3 definition file provided: `definitions/tofu_iiv3.json`


You can apply saved layouts (mappings & settings) by loading a layout file. Such as the included `layouts/tofu_ii.layout.json`
