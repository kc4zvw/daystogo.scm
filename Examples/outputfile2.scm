#! /usr/local/bin/guile3 -s
 !#

; $Id:$

(use-modules (ice-9 format))
(use-modules (ice-9 iconv))
(use-modules (ice-9 pretty-print))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules (ice-9 string-fun))

;
;  Author: David Billsbrough 
;   Email: <billsbrough@gmail.com> 
; Revised: Saturday, August 17, 2024 at 17:18:30 PM (EDT)
;

(define events (make-string 15 #\space))
(define ascii-limit #\delete)
(define done "done")

(define some-file "Charle.txt")
(define out (open-output-file some-file))

; ** subroutines

(define subroutine-one
	(begin
		(display "Hello World!" out)
		(display (string->number "13" ) out)
		(display (string->number "10" ) out)

		(write-char #\return out)
		(write-char #\linefeed out)
		(newline)))


(define subroutine-two
	(begin
		(newline)
		(display (format #f "stuff: ~~'~a'~~. (fifteen spaces)~%" events))
		(newline)

		(display ascii-limit)

		(newline)
		(display (format #f "Wrote file ... ~a~%" done))
		(newline)))

(define main
	(begin
		(subroutine-one)
		(subroutine-two)
		(newline)))

(main)

(close-output-port out)
(p "Finished!")

; more notes

; vim: tabstop=2 nowrap:

; End of File
