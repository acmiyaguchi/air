#!/bin/sh

lisgd \
    -o 3 \
    -g "1,DU,B,*,R,awesome-client 'awesome.emit_signal(\"keyboard::toggle\")'" \
    -g "1,UD,TR,*,R,awesome-client 'awesome.emit_signal(\"client::titlebars\")'" \
    -g "1,UD,TL,*,R,awesome-client 'awesome.emit_signal(\"settings::toggle\")'" \
    -g "1,LR,L,*,R,awesome-client 'awesome.emit_signal(\"open_windows::toggle\")'"

