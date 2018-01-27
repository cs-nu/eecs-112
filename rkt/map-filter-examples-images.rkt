;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname map-filter-examples-images) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define shapes
  (list (square 100 "solid" "green")
        (square 90 "solid" "blue")
        (square 30 "solid" "red")))

"shapes"
shapes

"map: rotate all images"
(map (lambda (img) (rotate 45 img))
     shapes)

"filter: only images wider than 50px"
(filter (lambda (img)
          (> (image-width img) 50))
     shapes)

"foldl: combine a listof X into one X, two at a time"
(foldl (lambda (current acc)
         (overlay current acc))
       empty-image
       shapes)

"foldr: notice how the order matters because we place the small images first"
(foldr (lambda (current acc)
         (overlay current acc))
       empty-image
       shapes)