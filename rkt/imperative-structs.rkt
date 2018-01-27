;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname reviewsession) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (copy-tree! from to) 
  (begin (unless (directory-exists? to)
           (make-directory! to))
         (for-each (λ (file)
                     (begin (printf "Copying file ~A to ~A~n" file to)
                            (copy-file! file
                                        (build-path to (path-filename file))
                                        #true)))
                   (directory-files from))
         (for-each (λ (subdir)
                     (copy-tree! subdir
                                 (build-path to (path-filename subdir))))
                   (directory-subdirectories from))))


(define (all-files-current-directory directory)
  (directory-files directory))

(define (all-files directory)
  (append
   (all-files-current-directory directory)
   (apply append (map all-files-current-directory (directory-subdirectories directory)))))


;; Remember, build-path doesn't actually create any files,
;; but just makes an object of type path to be used in other functions.
;; Ex: copy-tree! takes a "from" path and a "to" path

;; To access the "Test2" directory in the homework, you would have to (build-path "Test" "Test2")

