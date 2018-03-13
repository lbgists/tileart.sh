#!/usr/bin/env bash
# Copyright (c) 2018 Yu-Jie Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


M=32768

TW=8
TH=4
TS='━━━━━━━━━━┃┃┃┃┃┃┃┃┃┃┏┓┗┛  ░▒▓'


SW="$(tput  cols)"
SH="$(tput lines)"


tiling()
{
    local fg bg fgr fgg fgb bgr bgg bgb ty tx y x

    # generate foreground and background 256-color
    ((
        fgr = 6 * RANDOM / M,
        fgg = 6 * RANDOM / M,
        fgb = 6 * RANDOM / M,
        bgr = (fgr + 3) % 6,
        bgg = (fgg + 3) % 6,
        bgb = (fgb + 3) % 6,
        fg = 16 + 36 * fgr + 6 * fgg + fgb,
        bg = 16 + 36 * bgr + 6 * bgg + bgb
    ))

    for ((ty = 0; ty < TH; ty++)); do
        for ((tx = 0; tx < TW; tx++)); do
            ts="${TS:${#TS} * RANDOM / M:1}"
            for ((y = ty + 1; y <= SH; y += TH)); do
                for ((x = tx + 1; x <= SW; x += TW)); do
                    echo -ne "\e[${y};${x}H\e[38;5;${fg}m\e[48;5;${bg}m$ts"
                done
            done
        done
    done
    echo -ne '\e[0m'
}


main()
{
    while tiling; read -n 1; [[ "$REPLY" != [qQ] ]]; do :; done
}


main "$@"
