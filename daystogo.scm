#! /usr/local/bin/guile3 -s
 !#

; $Id: daystogo.scm,v 0.63 2024/08/17 17:00:45 kc4zvw Exp kc4zvw $

(use-modules (ice-9 format))
(use-modules (ice-9 iconv))
(use-modules (ice-9 pretty-print))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))
(use-modules (ice-9 string-fun))

;
;  Author: David Billsbrough <kc4zvw@earthlink.net>
; Revised: Friday, March 10, 2017 at 11:25:52 AM (EST)
;

(define file (string-copy ".calendar"))
(define home (string-copy "/home/kc4zvw"))
(define sep (string-copy "/"))
(define event-date (make-string 15 #\space))
(define event-name (make-string 60 #\.))
(define answer (string-copy "$"))
(define num 0)

(define Now current-time)
(define Today (strftime "%A, %B %d, %y at %H:%M:%S (%Z)" (localtime (current-time))))
(define some-file "/home/kc4zvw/.calendar")


(define (get_home_dir)
	; myHOME = ENV["HOME"]
	(define myHOME (getenv "HOME"))
	(display (format #f "My $HOME directory is ~a.~%~%" myHOME)))

(define (process_line event-date event-name)
	(set! answer (string-append "Date=" event-date ":Event=" event-name))
	;(display (format #f "result: ~s ~%" answer))
	)

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


(define year 1964)
(define mon 4)
(define mday 27)
(define zone 0500)

;(define dateTarget mktime(year mon mday) zone)

;(define temp dateTarget - Now)

;(display (format #t "time target is ~a~%" dateTarget))
;(display (format #t "time diff is ~a~%" temp))
(display (format #f "time now is ~a~%" Now))

; dayCount = temp.to_i


;(define formattedDate
;	((lambda (date0)
;	(set! date string.append( date0.wday date0.mon date0.day date0.year)))))


;  #==================================###
;  #     Main program begins here      ##
;  #==================================###

(newline)
(display (format #f "Today's date is ~a.~%" Today))
(newline)

(define myhome (get_home_dir))

(define fullpath (string-append home sep file))
(display (format #f "Filename: ~a~%~%" fullpath))
(newline)

;(display some-file)
;(newline)

(begin
	(define infile (open-input-file some-file))
	;(define in (open-input-file calendarFile))
;rescue
;	print "Couldn't open #{calendarFile} for reading dates.\n"
;	exit 2 
;end
)

;  (substring string start end) 

;(define s (string-match ":" line1))

(define (first-loop)
  (let loop ((line (read-line)))
    (if (not (eof-object? line))
      (begin
        ;(format #t "line: ~a\n" line)
        ; process the line
		(set! event-date (substring line 0 10))
		(set! event-name (substring line 11))

		(process_line event-date event-name)
		(output-display num event-name)

        (let ((m (string-match "^[ \t]*#" line)))
          (if m (format #t "comment: ~a\n" line)))
        ;(format #t "read next line\n")
        (loop (read-line))))))

(define (main)
	(with-input-from-file "/home/kc4zvw/.calendar" first-loop))
	
(main)

;(set! num 20)
;(output-display num "No Event 5")

; close input file
(close-input-port infile)

(newline)
(pretty-print "End of report")

; End of script
