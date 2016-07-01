# Some useful vim commands

| vim                                              | result                                                 |
| -----------------------                          | ------------------                                     |
| g;                                               | move to last insert location                           |
| g,                                               | opposite of g;                                         |
| :ls                                              | list buffers                                           |
| :bN (N = buffer number)                          | open buffer                                            |
| :sort                                            | sort selected rows                                     |
| *                                                | search for word under cursor                           |
| @X (X = key macro was assigned to)               | playback macro                                         |
| @@                                               | replay previously played macro                         |
| mX (X = key to assign bookmark to)               | bookmark current play in file                          |
| 'X (X = key bookmark was assigned to)            | jump to bookmark                                       |
| :marks                                           | show all bookmarks                                     |
| :delm X (X = bookmark key)                       | delete a bookmark                                      |
| :delm!                                           | delete all bookmarks                                   |
| :only                                            | close all other windows                                |
| ctX (X = any key)                                | delete up to X and switch to insert mode               |
| :fold                                            | folds selected content                                 |
| za                                               | toggle fold                                            |
| cs({, ds"                                        | change or delete brackets (surround)                   |
| :TOhtml                                          | Creates html with syntax highlighting                  |
