#!/bin/bash
#
# $Id:$

HEAPSIZE=2607104
STACKSIZE=300

scheme48 -h $HEAPSIZE -s $STACKSIZE -a batch << EOF

,set load-noisily
,set inline-values on
,open big-scheme

(define some-file "Charle.txt")
;(define stdout (output-port))

(define out (open-output-file some-file))
(display "Hello World!" out)

;(write (char->ascii '(13)))
;(write (char->ascii '(10)))

(display (ascii->char 13 ) out)
(display (ascii->char 10 ) out)

;(write-char 13 out)
;(write-char 10 out)

(close-output-port out)

(display "")
(display ascii-whitespaces)
(display "")
(display ascii-limit)

(display "")
(display "Wrote file ...")
(display "")

EOF

# more notes

# End of File
