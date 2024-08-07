# Slice to Block

This script will instantly mirror and shade the contents of a small slice into a finished block each time it is triggered.

*Thank you to YellowAfterlife for making the original mirror shade script, and stabu_ for helping me condense the script into one step!*

https://github.com/user-attachments/assets/26d2f0c9-674e-4e14-8596-28b9850e4c18


## Installation
Download the script [here](https://github.com/stacktrace-error/slice-to-block/releases), then open your scripts folder:

![image](https://github.com/user-attachments/assets/a26528ca-65e7-4b46-8668-f356fc621c1c)

Move the script inside, and press `File` > `Scripts` > `Rescan Scripts Folder`. It should now appear when opening `File` > `Scripts` again, and clicking it will run it once.
If your Ase version supports it, binding an easy to reach key to it is recommended.


## Usage
To define colors to be swapped, create a layer called `swaps` with the affected palettes in the format below.

![image](https://github.com/user-attachments/assets/ad0cdb3a-b3a1-47c7-b119-2d8970812f76)

Unused colors, layer position, visibility, and settings do not matter. If frames are used, the script will use the active frame's `swaps`.


Trigger the script either by pressing your keybind, or selecting it in `File` > `Scripts`.
Your sprite should be square and trimmed to the block you want to shade.
Everything but the following slice of the selected layer/cel will be removed, and the remaining part copied to all corners, to remove asymmetries.

![image](https://github.com/user-attachments/assets/fe2a2b65-ab0d-40c9-b5c5-f87cd2fc397f)
