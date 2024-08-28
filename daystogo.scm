#! /usr/local/bin/guile3 -s
 !#

;  ***
;  ***    Author: David Billsbrough 
;  ***   Created: Sunday, August 18, 2024 at 18:22:44 PM (EDT)
;  ***   License: GNU General Public License -- version 2
;  ***   Version: $Revision: 0.65 $
;  ***  Warranty: None
;  ***   Purpose: Calculate the difference in days between two dates
;  ***

; $Id: daystogo.scm,v 0.65 2024/08/18 22:29:05 kc4zvw Exp kc4zvw $

(use-modules (ice-9 format))
(use-modules (ice-9 iconv))
(use-modules (ice-9 pretty-print))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules (ice-9 string-fun))


(define calfile ".calendar")
(define sep "/")

(define event-date (make-string 15 #\space))
(define event-name (make-string 60 #\.))

(define dayCount 0)
(define answer (string-copy "$"))

(define Now (current-time))

(define Today (strftime "%A, %B %d, %y at %H:%M:%S (%Z)" (localtime (current-time))))

(define (as-days secs)
	(truncate (/ secs 86400)))

(define (date-to-secs str)
	(car (mktime (car (strptime "%Y/%m/%d" str)))))

(define mydate 0)

;(define (formattedDate d)
;	(set! mydate (string-append d.wday d.mon d.day d.year)))

; -----

(define (get_home_dir)
	; myHOME = ENV["HOME"]
	(define myHOME (getenv "HOME"))
	(display (format #f "My $HOME directory is ~a.~%~%" myHOME)))

(define (process_line event-date event-name)
	(set! answer (string-append "Date=" event-date ":Event=" event-name))
	;(display (format #f "result: ~s ~%" answer))
	(calc-dates num-days1 num-days2)
	(output-display dayCount event-name))

(define (output-display dayCount eventName)
	(cond
		((<= dayCount -2)
			display (format #t "It was ~a days ago since ~a.~%" (abs dayCount) eventName))
		((= dayCount -1)
			display (format #t "Yesterday was ~a.~%" eventName))
		((= dayCount 0)
			display (format #t "Today is ~a.~%" eventName))
		((= dayCount 1)
			display (format #t "Tomorrow is ~a.~%" eventName))
		((>= dayCount 2)
			display (format #t "There are ~a days until ~a.~%" dayCount eventName))
		(else
			display (format #t "No Match for ~a.~%" eventName))))

;-----

(define delta-days 0)
(define temp1 (string-copy ""))

(define zone 0500)  ;-- not used now

;(define (target (car str)(date-to-secs (car str))))
;(define date-target (as-days target))
(define date-today (as-days Now))

(define num-days1 date-today)
(define num-days2 0)

(define (diff num1 num2) (- num2 num1))

(define (calc-dates num-days1 num-days2)
	(begin
		(set! temp1 (car (mktime (car (strptime "%Y/%m/%d" event-date)))))
		(set! num-days2 (as-days temp1))
		(set! delta-days (diff num-days1 num-days2))
		(set! dayCount delta-days)

		;(display (format #f "var temp1 is ~a~%" temp1))
		;(display (format #f "var Now is ~a~%" Now))
		;(display (format #f "date source is ~a~%" num-days1))
		;(display (format #f "date target is ~a~%" num-days2))
		))


;  #==================================###
;  #     Main program begins here      ##
;  #==================================###

(newline)
(display (format #f "Today's date is ~a.~%" Today))
(newline)

(define myhome (get_home_dir))

(define calendar-file
  (string-append (or (getenv "HOME") "/home/kc4zvw") sep ".calendar"))

(begin
	(define infile (open-input-file calendar-file))
;rescue
;	(format #f  "Couldn't open ~a for reading dates.~%" calendar-file)
;	exit 2 
  )

(display (format #f "Filename: ~a~%" calendar-file))
(newline)

; do main loop though the calendar file

(define (first-loop)
  (let loop ((line (read-line)))
    (if (not (eof-object? line))
      (begin
        ;(format #t "line: ~a\n" line)
		  (set! event-date (substring line 0 10))
		  (set! event-name (substring line 11))

        ; process the line
		  (process_line event-date event-name)

        (let ((m (string-match "^[ \t]*#" line)))
          (if m (format #t "comment: ~a\n" line)))
        ;(format #t "read next line\n")
        (loop (read-line))))))

(define (main)
	(begin
		(with-input-from-file calendar-file first-loop)))
	
(main)

(newline)
; close input file
(close-input-port infile)

(pretty-print "End of report")

; vim: tabstop=3 nowrap syntax=scheme:

; End of script
