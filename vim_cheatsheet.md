# Some useful vim commands

| vim                                              | result                                                 |
| -----------------------                          | ------------------                                     |
| SHIFT + v                                        | select row(s)                                          |
| CTRL + v                                         | select blocks (columns)                                |
| vip                                              | select block                                           |
| gv                                               | reselect last selection                                |
| >>                                               | indent                                                 |
| <<                                               | unindent                                               |
| :ls                                              | list buffers                                           |
| :bN (N = buffer number)                          | open buffer                                            |
| :sort                                            | sort selected rows                                     |
| *                                                | search for word under cursor                           |
| gf                                               | open file under cursor                                 |
| qX (X = key to assign macro to)                  | start recording a macro                                |
| q                                                | stop recording a macro                                 |
| @X (X = key macro was assigned to)               | playback macro                                         |
| @@                                               | replay previously played macro                         |
| mX (X = key to assign bookmark to)               | bookmark current play in file                          |
| 'X (X = key bookmark was assigned to)            | jump to bookmark                                       |
| :marks                                           | show all bookmarks                                     |
| :delm X (X = bookmark key)                       | delete a bookmark                                      |
| :delm!                                           | delete all bookmarks                                   |
| :only                                            | close all other windows                                |
| gg=G                                             | indent whole file                                      |
| gi                                               | move to last insert location and switch to insert mode |
| g;                                               | move to last insert location                           |
| g,                                               | opposite of g;                                         |
| cw, dw                                           | change or delete rest of word                          |
| caw, daw                                         | change or delete the whole word                        |
| ciX (X = brackets, parentheses, quotation marks) | change inner                                           |
| diX, yiX                                         | same as ciX but with delete and yank                   |
| ctX (X = any key)                                | delete up to X and switch to insert mode               |
| :fold                                            | folds selected content                                 |
| za                                               | toggle fold                                            |
