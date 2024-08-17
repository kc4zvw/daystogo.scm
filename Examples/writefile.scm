#! /usr/local/bin/guile3 -s
 !#

;
; $Id: writefile.scm,v 0.3 2024/08/16 12:40:46 kc4zvw Exp kc4zvw $
;

(use-modules (ice-9 pretty-print))
(use-modules (ice-9 format))

; testing file output

(define some-file "Bravo.txt")
(define out (open-output-file some-file))

(display "Hello world!\n" out)
(display (format #f "~c" #\return ) out)
(display (format #f "~c" #\newline) out)	; -| ^J

(close-output-port out)

(newline)

(format #t "~a~%" "foo") 
(format #t "~s~%" "foo")

(newline)
(newline)
(pretty-print "Wrote file ...")
(newline)

; EOF
