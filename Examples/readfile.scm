#! /usr/local/bin/guile3 -s
 !#

;
; $Id:$
;

(use-modules (ice-9 pretty-print))
(use-modules (ice-9 rdelim))
(use-modules (ice-9 regex))


(define (f)
  (let loop ((line (read-line)))
    (if (not (eof-object? line))
        (begin
          (format #t "line: ~a\n" line)
          (let ((m (string-match "^[ \t]*#" line)))
            (if m (format #t "comment: ~a\n" line)))
          (format #t "read next line\n")
          (loop (read-line))))))

(define (main)
  (with-input-from-file "/home/kc4zvw/.calendar" f))


(main)

;
; EOF
