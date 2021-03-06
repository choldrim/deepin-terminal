# Deepin Terminal

This is default terminal emulation application for Deepin.

## Dependencies

* vala
* vte-2.91
* gtk+-3.0

In debian, use below command to install dependencies:

`sudo apt-get install valac libgtk-3-dev libgee-0.8-dev libvte-2.91-dev libjson-glib-dev libsecret-1-dev libwnck-3-dev`

## Usage

Below is keymap list for deepin-terminal:

| Function					      | Keymap                              |
|---------------------------------|-------------------------------------|
| Copy                            | **Ctrl** + **Shift** + **c**        |
| Paste                           | **Ctrl** + **Shift** + **v**        |
| Select word                     | **Double click**                    |
| Open URL                        | **Ctrl** + **LeftButton**           |
| Split vertically                | **Ctrl** + **Shift** + **h**        |
| Split horizontally              | **Ctrl** + **h**                    |
| Search history                  | **Ctrl** + **r**                    |
|                                                                       |
| Close current terminal          | **Ctrl** + **q**                    |
| Close other terminals           | **Ctrl** + **Shift** + **q**        |
|                                                                       |
| Focus up window                 | **Alt**  + **k**                    |
| Focus down window               | **Alt**  + **j**                    |
| Focus left window               | **Alt**  + **h**                    |
| Focus right window              | **Alt**  + **l**                    |
| Close window                    | **Ctrl** + **Shift** + **q**        |
|                                                                       |
| Zoom out                        | **Ctrl** + **=**                    |
| Zoom in                         | **Ctrl** + **-**                    |
| Revert default size             | **Ctrl** + **0**                    |
|                                                                       |
| New workspace                   | **Ctrl** + **Shift** + **t**        |
| Close workspace                 | **Ctrl** + **Shift** + **q**        |
| Switch preview workspace        | **Ctrl** + **Tab**                  |
| Switch next workspace           | **Ctrl** + **Shift** + **Tab**      |
| Select workspace with number    | **Ctrl** + **number**               |
|                                                                       |
| Search                          | **Ctrl** + **Shift** + **f**		|
|                                                                       |
| Adjust background opacity       | **Ctrl** + **ScrollButton**         |
| Fullscreen                      | **F11**                             |
| Help                            | **Ctrl** + **?**                    |

## Installation

`make && ./main`

## Getting help

Any usage issues can ask for help via

* [Gitter](https://gitter.im/orgs/linuxdeepin/rooms)
* [IRC channel](https://webchat.freenode.net/?channels=deepin)
* [Forum](https://bbs.deepin.org)
* [WiKi](http://wiki.deepin.org/)

## Getting involved

We encourage you to report issues and contribute changes

* [Contribution guide for users](http://wiki.deepin.org/index.php?title=Contribution_Guidelines_for_Users)
* [Contribution guide for developers](http://wiki.deepin.org/index.php?title=Contribution_Guidelines_for_Developers).

## License

Deepin Terminal is licensed under [GPLv3](LICENSE).
