#!/usr/bin/env newlisp

(define (read-version-alist in)
  (let ((line-start true) (found false))
    (while (not found)
      (let ((c (read-char in)))
        (if (or (not c) (and line-start (= c (char "("))))
            (set 'found true)
            (set 'line-start (= c (char "\n")))))))
  (read in buffer 10000)
  (set 'buffer (append "(" (or buffer "")))
  (let ((i 0) (xs '()))
    (while (< i (length buffer))
      (let ((x (read-expr buffer (context) 'err i)))
        (if (or (= nil x) (= 'err x))
            (set 'i (length buffer))
            (begin (set 'i $count)
                   (push x xs)))))
    (reverse xs)))

(print (read-version-alist (device)))
(print "\n")
